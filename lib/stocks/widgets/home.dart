import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:priceless/colors.dart';
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
        backgroundColor: APP_WHITE,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PriceHome()));
          },
          label: Text('Prices'),
          icon: Icon(Icons.search),
          backgroundColor: Colors.pink,
        ),
        body: tabs.elementAt(_selectedIndex),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(
                gap: 4,
                activeColor: REAL_BLACK,
                color: APP_GREY,
                iconSize: 20,
                backgroundColor: APP_WHITE,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: REAL_BLACK.withAlpha(60),
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
