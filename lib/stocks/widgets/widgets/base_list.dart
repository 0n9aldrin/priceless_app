import 'package:flutter/material.dart';
import 'package:priceless/colors.dart';
import 'package:priceless/stocks/shared/colors.dart';
// import 'package:sma/shared/colors.dart';

class BaseList extends StatelessWidget {
  final List<Widget> children;

  BaseList({
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: APP_WHITE,
        body: SafeArea(
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: this.children)));
  }
}
