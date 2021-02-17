import 'package:flutter/material.dart';

import 'prices/price_home.dart';
import 'stocks/widgets/home.dart';
// import 'package:sma/prices/price_home.dart';
// import 'package:sma/widgets/home.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PriceHome())),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Color(0xff007BFF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      "Price Comparison",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockMarketAppHome())),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Color(0xff3DA745),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      "Stocks and News",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
