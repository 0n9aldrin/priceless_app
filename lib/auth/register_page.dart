import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priceless/auth/forgot_password.dart';
import 'package:priceless/auth/toast.dart';
import 'package:priceless/index.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  // String email, password, username;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();

  GoogleSignInAccount _account;
  bool _verified = false;

  _signUp() async {
    String email = _emailcontroller.text;
    String password = _passwordcontroller.text;
    String username = _usernamecontroller.text;
    _emailcontroller.clear();
    _passwordcontroller.clear();
    _usernamecontroller.clear();
    print('Email: $email');
    print('Password: $password');
    print('Username: $username');
    FocusScope.of(context).unfocus();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = FirebaseAuth.instance.currentUser;
      user.updateProfile(displayName: username);
      setState(() {
        _isSignedIn = true;
        // user = FirebaseAuth.instance.currentUser;
      });
      showSuccessToast("Account created", context);
      await _verify();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSignedIn = false;
      });
      print(e.toString());
      showErrorToast(e.toString(), context);
      if (e.code == 'weak-password') {
        showErrorToast("Password too weak", context);
      } else if (e.code == 'email-already-in-use') {
        showErrorToast("Email already in use", context);
      }
    }
  }

  _verify() async {
    User user = FirebaseAuth.instance.currentUser;
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    } else {
      showErrorToast("Email not yet verified", context);
    }
  }

  Future<void> _handleSignOut() {
    _googleSignIn.disconnect();
    setState(() {
      _isSignedIn = false;
    });
    showSuccessToast("You've Signed Out", context);
  }

  // _submit() async {
  //   await _signIn();
  // }

  Future<void> _handleSignIn() async {
    try {
      _account = await _googleSignIn.signIn();
      setState(() {
        _isSignedIn = true;
      });
      showSuccessToast("You've Signed In", context);
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
    return Scaffold(
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
                          margin: EdgeInsets.only(right: 32, left: 32, top: 16),
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
                        top: height / 6,
                        bottom: 16,
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "Create Account",
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
                            "Please register to continue",
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
                              controller: _usernamecontroller,
                              // onChanged: (val) {
                              //   setState(() {
                              //     val = username;
                              //   });
                              // },
                              style: TextStyle(color: APP_WHITE, fontSize: 16),
                              cursorColor: APP_WHITE,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: APP_WHITE)),
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    color: APP_GREY,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
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
                              style: TextStyle(color: APP_WHITE, fontSize: 16),
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
                            await _signUp();
                          },
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
                              "Create Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: height / 2.4),
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
                        //     () => Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => ForgotPassword()));
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
