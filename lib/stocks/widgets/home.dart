import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:priceless/prices/price_home.dart';
import 'package:priceless/stocks/shared/colors.dart';
import 'package:priceless/stocks/widgets/portfolio/portfolio.dart';

import 'markets/markets_section.dart';
import 'news/news_section.dart';
import 'search/search_section.dart';
// import 'package:sma/shared/colors.dart';

// import 'package:sma/widgets/markets/markets_section.dart';
// import 'package:sma/widgets/news/news_section.dart';
// import 'package:sma/widgets/portfolio/portfolio.dart';
// import 'package:sma/widgets/search/search_section.dart';

class StockMarketAppHome extends StatefulWidget {
  @override
  _StockMarketAppHomeState createState() => _StockMarketAppHomeState();
}

class _StockMarketAppHomeState extends State<StockMarketAppHome> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    PortfolioSection(),
    MarketsSection(),
    SearchSection(),
    NewsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Prices Comparison'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PriceHome()));
              },
            ),
            ListTile(
              title: Text('Stock Market'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StockMarketAppHome()));
              },
            ),
            ListTile(
              title: Text('Wishlist'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => StockMarketAppHome()));
              },
            ),
          ],
        )),
        backgroundColor: kScaffoldBackground,
        body: tabs.elementAt(_selectedIndex),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(
                gap: 4,
                activeColor: Colors.white,
                iconSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.white30,
                selectedIndex: _selectedIndex,
                tabs: _bottomNavigationBarItemItems(),
                onTabChange: _onItemTapped),
          ),
        ));
  }

  List<GButton> _bottomNavigationBarItemItems() {
    return [
      GButton(
        icon: FontAwesomeIcons.shapes,
        text: 'Home',
      ),
      GButton(
        icon: FontAwesomeIcons.suitcase,
        text: 'Markets',
      ),
      GButton(
        icon: FontAwesomeIcons.search,
        text: 'Search',
      ),
      GButton(
        icon: FontAwesomeIcons.globeAmericas,
        text: 'News',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}
