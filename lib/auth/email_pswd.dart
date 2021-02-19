import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Uncomment this to use the auth emulator for testing
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isSignedIn = false;
  User user;
  _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "senfukaraymond@gmail.com",
              password: "SuperSecretPassword!");
      setState(() {
        _isSignedIn = true;
        user = FirebaseAuth.instance.currentUser;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSignedIn = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  _verify() async {
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    }
  }

  _signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "senfukaraymond@gmail.com",
              password: "SuperSecretPassword!");
      setState(() {
        _isSignedIn = true;
        user = FirebaseAuth.instance.currentUser;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSignedIn = false;
      });
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _isSignedIn = false;
    });
  }

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
              Text(!_isSignedIn ? "Hello World" : "${user.email}"),
              RaisedButton(
                  child: Icon(!_isSignedIn
                      ? Icons.access_alarm
                      : Icons.check_circle_outline),
                  onPressed: () => !_isSignedIn ? _signIn() : _signOut())
            ],
          ),
        ),
      ),
    );
  }
}
