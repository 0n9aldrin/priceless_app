import 'package:flutter/material.dart';
import 'package:priceless/colors.dart';
import 'package:priceless/stocks/shared/colors.dart';
import 'package:priceless/stocks/widgets/about/attributions/attributions.dart';
import 'package:priceless/stocks/widgets/widgets/empty_screen.dart';
// import 'package:sma/shared/colors.dart';
// import 'package:sma/widgets/about/attributions/attributions.dart';
// import 'package:sma/widgets/widgets/empty_screen.dart';

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('About'),
            backgroundColor: Colors.indigo,
            bottom: TabBar(
              indicatorColor: Color(0X881f1f1f),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
              indicatorWeight: 3,
              tabs: [
                Tab(
                  text: 'Information',
                ),
                Tab(
                  text: 'Settings',
                ),
              ],
            ),
          ),
          backgroundColor: APP_WHITE,
          body: SafeArea(
            child: TabBarView(
              children: <Widget>[
                Attributions(),
                EmptyScreen(message: 'Settings section coming soon'),
              ],
            ),
          )),
    );
  }
}
