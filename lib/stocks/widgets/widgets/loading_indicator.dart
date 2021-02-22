import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:priceless/colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: SpinKitThreeBounce(
      //   color: Colors.white,
      //   size: 25.0
      // ),
      child: SpinKitFadingCircle(
        color: APP_BLUE,
        size: 56,
      ),
    );
  }
}
