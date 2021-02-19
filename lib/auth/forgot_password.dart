import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:priceless/auth/toast.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Color APP_WHITE = Color(0xfffafafa);
  final Color APP_GREY = Color(0xffADAB9F);
  final Color LIGHT_GREY = Color(0xffD3D2C5);
  // String email;
  TextEditingController _controller = TextEditingController();

  @override
  Future<void> resetPassword() async {
    // if (email.trim().length == 0) {
    //   showErrorToast("Enter Valid Email", context);
    //   return;
    // }
    // print(email);
    String email = _controller.text;
    // print("Email: $email");
    _controller.clear();
    FocusScope.of(context).unfocus();
    var mAuth = FirebaseAuth.instance;

    try {
      await mAuth.sendPasswordResetEmail(email: email).then((value) {
        showSuccessToast("Email sent", context);
      });
    } catch (e) {
      showErrorToast('Problem Resetting Password', context);
      // print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          Positioned.fill(
            child: Container(
              width: width,
              height: height,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                padding: EdgeInsets.only(
                  top: height / 6,
                  bottom: 16,
                ),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Password Reset",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Text(
                      "A link will be sent your email",
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
                        controller: _controller,
                        autofocus: false,
                        style: TextStyle(color: APP_WHITE, fontSize: 16),
                        cursorColor: APP_WHITE,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: APP_WHITE)),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: APP_GREY, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  //   child: Theme(
                  //     data: ThemeData(primaryColor: APP_WHITE),
                  //     child: TextField(
                  //       autocorrect: false,
                  //       autofocus: false,
                  //       onChanged: (val) {
                  //         setState(() {
                  //           val = password;
                  //         });
                  //       },
                  //       obscureText: true,
                  //       cursorColor: APP_WHITE,
                  //       style: TextStyle(color: APP_WHITE),
                  //       decoration: InputDecoration(
                  //           enabledBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(color: APP_WHITE)),
                  //           labelText: "Password",
                  //           labelStyle: TextStyle(
                  //               color: APP_GREY,
                  //               fontWeight: FontWeight.w500)),
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () async {
                      await resetPassword();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 32, left: 32, top: 16),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: 14, horizontal: width / 4),
                      decoration: BoxDecoration(
                          color: Color(0xff3D82FF),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        "Send Link",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     await _handleSignIn();
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(right: 32, left: 32, top: 32),
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: 14, horizontal: width / 5),
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffEF504D),
                  //         borderRadius: BorderRadius.circular(16)),
                  //     child: Text(
                  //       "Google Sign In",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.white,
                  //           fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.only(
                  //       top: 24,
                  //       left: 24,
                  //       right: 24,
                  //       bottom: 24,
                  //     ),
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "Forgot Password?",
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.green),
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 24),
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "Create Account",
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
