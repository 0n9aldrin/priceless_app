import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:priceless/database.dart';
import 'package:priceless/stocks/helpers/sentry_helper.dart';
import 'package:priceless/stocks/models/data_overview.dart';
import 'package:priceless/stocks/models/profile/market_index.dart';
import 'package:priceless/stocks/models/storage/storage.dart';
import 'package:priceless/stocks/respository/portfolio/client.dart';
import 'package:priceless/stocks/respository/portfolio/storage_client.dart';
// import 'package:sma/helpers/sentry_helper.dart';

// import 'package:sma/models/data_overview.dart';
// import 'package:sma/models/profile/market_index.dart';
// import 'package:sma/models/storage/storage.dart';

// import 'package:sma/respository/portfolio/client.dart';
// import 'package:sma/respository/portfolio/storage_client.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final _databaseRepository = PortfolioStorageClient();
  final _repository = PortfolioClient();

  @override
  PortfolioState get initialState => PortfolioInitial();

  @override
  Stream<PortfolioState> mapEventToState(PortfolioEvent event) async* {
    if (event is FetchPortfolioData) {
      yield PortfolioLoading();
      yield* _loadContent();
    }

    if (event is SaveProfile) {
      yield PortfolioLoading();
      await bookmarkStock(model: event.storageModel);
      await this._databaseRepository.save(storageModel: event.storageModel);
      yield* _loadContent();
    }

    if (event is DeleteProfile) {
      yield PortfolioLoading();
      await deleteStock(symbol: event.symbol);
      await this._databaseRepository.delete(symbol: event.symbol);
      yield* _loadContent();
    }
  }

  Stream<PortfolioState> _loadContent() async* {
    try {
      // final symbolsStored = await _databaseRepository.fetch();
      final symbolsStored = await fetchStock() ?? [];
      final indexes = await _repository.fetchIndexes();

      if (symbolsStored.isNotEmpty) {
        // await fetchStock();
        final stocks = await Future.wait(symbolsStored.map((symbol) async =>
            await _repository.fetchStocks(symbol: symbol.symbol)));

        yield PortfolioLoaded(stocks: stocks, indexes: indexes);
      } else {
        yield PortfolioStockEmpty(indexes: indexes);
      }
    } catch (e, stack) {
      yield PortfolioError(message: '${e.toString()}');
      // await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
