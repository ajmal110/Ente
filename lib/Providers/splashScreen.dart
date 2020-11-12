import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/models/app.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:plantStore/onboarding_screen.dart';
import 'package:plantStore/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => AppWelcome()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnboardingScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Scaffold(
      body: Column(
        children: [
          Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/images/EML.png',
                height: SizeConfig.blockSizeVertical * 20,
                // width: 700,
                scale: .1,
                fit: BoxFit.cover,
              )),
          new Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
