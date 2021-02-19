import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priceless/auth/forgot_password.dart';
import 'package:priceless/auth/register_page.dart';
import 'package:priceless/auth/toast.dart';
import 'package:priceless/index.dart';

import '../main.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscure = true;
  final Color APP_WHITE = Color(0xfffafafa);
  final Color APP_GREY = Color(0xffADAB9F);
  final Color LIGHT_GREY = Color(0xffD3D2C5);

  bool _isSignedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  // String email, password;
  TextEditingController _emailcontroller;
  TextEditingController _passwordcontroller;

  GoogleSignInAccount _account;
  bool _verified = false;

  @override
  void initState() {
    super.initState();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    FirebaseAuth.instance.signOut();
    _googleSignIn.disconnect();
  }

  _signIn() async {
    String email = _emailcontroller.text;
    String password = _passwordcontroller.text;
    _emailcontroller.clear();
    _passwordcontroller.clear();
    // print('Email: $email');
    // print('Password: $password');
    FocusScope.of(context).unfocus();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        _isSignedIn = true;
        // user = FirebaseAuth.instance.currentUser;
      });
      await _verify();
      showSuccessToast("You've Signed In", context);
      UID = userCredential.user.uid;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSignedIn = false;
      });
      // print(e.toString());
      showErrorToast(e.toString(), context);
      if (e.code == 'user-not-found') {
        showErrorToast("User not found for that email", context);
      } else if (e.code == 'wrong-password') {
        showErrorToast("Wrong Password for that User", context);
      }
    }
  }

  _verify() async {
    User user = FirebaseAuth.instance.currentUser;
    user.reload();
    if (user.emailVerified) {
      return;
    }
    try {
      await user.sendEmailVerification();
      showSuccessToast("Check your Email to verify", context);
      setState(() {
        _verified = true;
      });
      // return user.uid;
    } catch (e) {
      // print("An error occured while trying to send email        verification");
      print(e.message);
      showErrorToast("Error Verifying Email", context);
    }
  }

  _verifyComplete() {
    User user = FirebaseAuth.instance.currentUser;
    user.reload();
    if (user.emailVerified) {
      UID = user.uid;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    } else {
      showErrorToast("Email not yet verified", context);
    }
  }

  // Future<void> _handleSignOut() {
  //   _googleSignIn.disconnect();
  //   setState(() {
  //     _isSignedIn = false;
  //   });
  //   showSuccessToast("You've Signed Out", context);
  // }

  Future<void> _handleSignIn() async {
    try {
      _account = await _googleSignIn.signIn();
      setState(() {
        _isSignedIn = true;
      });
      UID = _account.id;
      showSuccessToast("You've Signed In", context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    } catch (error) {
      // print(error);
      showErrorToast("Problem signing in", context);
      setState(() {
        _isSignedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xff707070),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image.asset(
              "assets/mkt.jpg",
              fit: BoxFit.cover,
            )),
            Positioned.fill(
                child: Container(
              width: width,
              height: height,
              color: Color(0xff202020).withOpacity(0.7),
            )),
            _verified
                ? Positioned.fill(
                    child: Container(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "Verify Email",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          child: Text(
                            "Check your email to verify",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _verifyComplete(),
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 32, left: 32, top: 16),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: width / 5),
                            decoration: BoxDecoration(
                                color: Color(0xff3D82FF),
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              "Verified",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                : Positioned.fill(
                    child: Container(
                      width: width,
                      height: height,
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        padding: EdgeInsets.only(
                          top: 56,
                          bottom: 16,
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: Text(
                              "Please sign in to continue",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              right: 24,
                              left: 24,
                            ),
                            child: Theme(
                              data: ThemeData(primaryColor: APP_WHITE),
                              child: TextField(
                                autofocus: false,
                                controller: _emailcontroller,
                                // onChanged: (val) {
                                //   setState(() {
                                //     val = email;
                                //   });
                                // },
                                style:
                                    TextStyle(color: APP_WHITE, fontSize: 16),
                                cursorColor: APP_WHITE,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: APP_WHITE)),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color: APP_GREY,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Theme(
                              data: ThemeData(primaryColor: APP_WHITE),
                              child: TextField(
                                autocorrect: false,
                                autofocus: false,
                                controller: _passwordcontroller,
                                // onChanged: (val) {
                                //   setState(() {
                                //     val = password;
                                //   });
                                // },
                                obscureText: _obscure,
                                cursorColor: APP_WHITE,
                                style: TextStyle(color: APP_WHITE),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: APP_WHITE)),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: APP_GREY,
                                      fontWeight: FontWeight.w500),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscure = !_obscure;
                                      });
                                    },
                                    child: _obscure
                                        ? Icon(
                                            Icons.visibility,
                                            size: 20,
                                            color: APP_GREY,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            size: 20,
                                            color: APP_GREY,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _signIn();
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 32, left: 32, top: 16),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: width / 4),
                              decoration: BoxDecoration(
                                  color: Color(0xff3D82FF),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _handleSignIn();
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 32, left: 32, top: 32),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: width / 5),
                              decoration: BoxDecoration(
                                  color: Color(0xffEF504D),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(
                                "Google Sign In",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 24,
                                left: 24,
                                right: 24,
                                bottom: 24,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              alignment: Alignment.center,
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
