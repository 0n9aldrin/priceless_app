import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priceless/auth/signin_page.dart';
import 'package:priceless/colors.dart';
import 'package:priceless/stocks/shared/colors.dart';
import 'package:priceless/stocks/widgets/about/attributions/attributions.dart';
import 'package:priceless/stocks/widgets/widgets/empty_screen.dart';

import '../../../main.dart';
// import 'package:sma/shared/colors.dart';
// import 'package:sma/widgets/about/attributions/attributions.dart';
// import 'package:sma/widgets/widgets/empty_screen.dart';

class AboutSection extends StatefulWidget {
  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  _signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
    UID = '';
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

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
                ListView(
                  children: <Widget>[
                    ListTile(
                      onTap: () => _signOut(),
                      leading: Icon(Icons.explicit),
                      title: Text(
                        "Log Out",
                        style: TextStyle(
                            // color:
                            ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
