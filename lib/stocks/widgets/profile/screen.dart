import 'package:flutter/material.dart';
import 'package:priceless/colors.dart';
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

class ProfileScreen extends StatelessWidget {
  final bool isSaved;
  final Color color;
  final ProfileModel profile;

  ProfileScreen({
    @required this.isSaved,
    @required this.profile,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          centerTitle: true,
          title: Text(this.profile.stockQuote.symbol),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            WatchlistButtonWidget(
              storageModel: StorageModel(
                  symbol: profile.stockQuote.symbol,
                  companyName: profile.stockQuote.name),
              isSaved: isSaved,
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: APP_WHITE,
        body: SafeArea(
          child: Profile(
            color: color,
            stockProfile: profile.stockProfile,
            stockChart: profile.stockChart,
            stockQuote: profile.stockQuote,
          ),
          // ProfileNewsScreen(news: profile.stockNews,),
        ));
  }
}
