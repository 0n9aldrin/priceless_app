// import 'package:sma/models/news/news.dart';
// import 'package:sma/respository/news/news_client.dart';

import 'package:priceless/stocks/models/news/news.dart';
import 'package:priceless/stocks/respository/news/news_client.dart';

class NewsRepository extends NewsClient {
  Future<NewsDataModel> fetchNews({String title}) async {
    return await super.fetchNews(title: title);
  }
}
