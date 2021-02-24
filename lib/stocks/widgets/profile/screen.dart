import 'package:flutter/material.dart';
import 'package:priceless/auth/toast.dart';
import 'package:priceless/colors.dart';
import 'package:priceless/graphs/time_series_chart/simple.dart';
import 'package:priceless/stockhistory.dart';
import 'package:priceless/predict_page.dart';
import 'package:priceless/main.dart';
import 'package:priceless/stocks/models/profile/profile.dart';
import 'package:priceless/stocks/models/storage/storage.dart';
import 'package:priceless/stocks/shared/colors.dart';
import 'package:priceless/stocks/widgets/profile/widgets/profile/profile.dart';

import 'widgets/widget/save_button.dart';
// import 'package:sma/models/profile/profile.dart';
// import 'package:sma/models/storage/storage.dart';

// import 'package:sma/shared/colors.dart';
// import 'package:sma/widgets/profile/widgets/profile/profile.dart';
// import 'package:sma/widgets/profile/widgets/widget/save_button.dart';

class ProfileScreen extends StatefulWidget {
  final bool isSaved;
  final Color color;
  final ProfileModel profile;
  final String symbol;

  ProfileScreen(
      {@required this.isSaved,
      @required this.profile,
      @required this.color,
      @required this.symbol});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.show_chart),
            onPressed: () async {
              List cow = await fetchStockHistory(symbol: widget.symbol);
              print(cow.length);
              if (cow == null || cow.length == 0) {
                showErrorToast(
                    "Prediction for ${widget.symbol} is unavailable, Try again",
                    context);
                return;
              }
              setState(() {
                CULTURE = cow;
                SIGNAL = widget.symbol;
              });
              // showSuccessToast("Prediction: ${cow.toString()}", context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PredictPage(color: widget.color)));
            }),
        appBar: AppBar(
          backgroundColor: widget.color,
          centerTitle: true,
          title: Text(this.widget.profile.stockQuote.symbol),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            WatchlistButtonWidget(
              storageModel: StorageModel(
                  symbol: widget.profile.stockQuote.symbol,
                  companyName: widget.profile.stockQuote.name),
              isSaved: widget.isSaved,
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: APP_WHITE,
        body: SafeArea(
          child: Profile(
            color: widget.color,
            stockProfile: widget.profile.stockProfile,
            stockChart: widget.profile.stockChart,
            stockQuote: widget.profile.stockQuote,
          ),
          // ProfileNewsScreen(news: profile.stockNews,),
        ));
  }
}
