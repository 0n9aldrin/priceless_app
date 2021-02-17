import 'package:flutter/material.dart';

class StandardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget action;

  StandardHeader(
      {@required this.title, @required this.subtitle, @required this.action});

  static const kPortfolioHeaderTitle =
      const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static const kPortfolioSubtitle = const TextStyle(
      color: Colors.white54, fontSize: 24, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            this.action,
            Text(this.title, style: kPortfolioHeaderTitle),
          ],
        ),
        // Text(this.title, style: kPortfolioHeaderTitle),
        Text(this.subtitle, style: kPortfolioSubtitle),
      ],
    );
  }
}
