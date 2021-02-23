import 'package:flutter/material.dart';

import 'chart.dart';
import 'cow/time_series_chart/simple.dart';
import 'main.dart';
import 'stocks/models/profile/stock_chart.dart';
import 'stocks/models/profile/stock_profile.dart';

class PredictPage extends StatefulWidget {
  final Color color;
  PredictPage({this.color});
  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        centerTitle: true,
        title: Text(
          SIGNAL,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: ListView(
          children: <Widget>[
            Container(
                height: height / 2,
                child: new SimpleTimeSeriesChart.withRandomData()),
          ],
        ),
      ),
    );
  }
}
