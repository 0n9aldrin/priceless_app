import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:priceless/stocks/keys/api_keys.dart';
import 'package:http/http.dart' as http;
import 'package:tflite/tflite.dart';
// import 'package:tflite/tflite.dart';

fetchStockHistory({@required String symbol}) async {
  print(symbol);
  final Uri uri = Uri.https('www.alphavantage.co', '/query', {
    'function': 'TIME_SERIES_INTRADAY',
    'symbol': symbol,
    'interval': '5min',
    'apikey': kAlphaVantageKey
  });
  print(uri.toString());

  final response = await http.get(uri);

  // final response = await Dio().getUri(uri);
  Map<String, dynamic> goat = jsonDecode(response.body);
  // try {
  var dog = goat["Meta Data"]["3. Last Refreshed"];
  double answer = double.parse(goat["Time Series (5min)"][dog]["4. close"]);
  print(answer);
  // return;
  // } catch (e) {
  // print('ERROOORRR: ${e.toString()}');
  // }
  // var jsonD = goat["Time Series (5min)"]["2021-02-22 20:00:00"]["1. open"];
  // var jsonD1 =
  //     response.data["Time Series (5min)"]['2021-02-19 19:50:00']["4. close"];
  // var jsonD2 =
  //     response.data["Time Series (5min)"]['2021-02-19 19:45:00']["4. close"];
  // var jsonD3 =
  //     response.data["Time Series (5min)"]['2021-02-19 19:40:00']["4. close"];
  var cat = answer * 0.4;
  cat += answer;
  print(cat.toString());
  // return;
  var qwe = answer * 0.2;
  qwe += answer;
  print(qwe.toString());
  // return;
  var qaz = answer * 0.3;
  qaz += answer;
  print(qaz.toString());
  // return;
  // var jsonD4 =
  //     response.data["Time Series (5min)"]['2021-02-19 19:35:00']["4. close"];
  // print(jsonD.toString());
  // return double.parse(jsonD);

  var now = new DateTime.now();
  DateTime dateToday = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
  );
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:00:00");
  var x = DateTime.now().hour;
  List<double> y = [];
  for (var q = 6; q > 0; --q) {
    x = x - 1;
    if (x > 0) {
      y.add(double.parse(x.toString()));
    } else {
      break;
    }
  }
  List z = [];
  List<String> prices = [];
  // prices.add(jsonD.toString());
  // prices.add(jsonD2.toString());
  // prices.add(jsonD3.toString());
  // prices.add(jsonD4.toString());
  double sum = 0;
  for (var item in prices) {
    sum += double.parse(item);
    // y.add(double.parse(item));
  }
  var mean = sum / 4;
  List<double> cow = [];

  for (var i in y) {
    cow.add(mean + i * 0.2);
  }
  try {
    String res = await Tflite.loadModel(
      model: "assets/regression.tflite",
      labels: "assets/callback.txt",
      // useGpuDelegate: true,
    );
    print(res);
    prices.add(res);
  } catch (e) {
    //print(e);
  }
  for (var item in cow) {
    sum += item;
  }
  mean = sum / 8;
  print(mean);
  z.add(cat);
  z.add(qwe);
  z.add(qaz);
  return z;

  // String string = dateFormat.format(now);
  // print(string);
  // final data = response.data["Time Series (5min)"];
  // print(data.toString());
  // for (var item in jsonD) {
  //   print(item);
  // }
}

// class Result {}
