import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantStore/Providers/auth-provider.dart';
import 'package:plantStore/Providers/phone_auth.dart';
import 'package:plantStore/screens/bar-screen.dart';
import 'package:plantStore/screens/home.dart';
import 'package:flutter/material.dart';

class AppWelcome extends StatefulWidget {
  AppWelcome({Key key}) : super(key: key);

  @override
  _AppWelcomeState createState() => _AppWelcomeState();
}

class _AppWelcomeState extends State<AppWelcome> {
  final _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(user);
    return Scaffold(
        body: user != null
            ? BarScreen(
                // user: user,
                )
            : PhoneLogin());
  }
}
