import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priceless/auth/signin_page.dart';

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
      home: SignInPage(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSignedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount _account;

  Future<void> _handleSignOut() {
    _googleSignIn.disconnect();
    setState(() {
      _isSignedIn = false;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      _account = await _googleSignIn.signIn();
      setState(() {
        _isSignedIn = true;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isSignedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(!_isSignedIn ? "Hello World" : "${_account.displayName}"),
            RaisedButton(
                child: Icon(!_isSignedIn
                    ? Icons.access_alarm
                    : Icons.check_circle_outline),
                onPressed: () =>
                    !_isSignedIn ? _handleSignIn() : _handleSignOut())
          ],
        ),
      ),
    );
  }
}
