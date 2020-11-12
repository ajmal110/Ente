import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantStore/Providers/notification_bloc.dart';
import 'package:plantStore/Providers/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:plantStore/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  StreamSubscription<Map> _notificationSubscription;

  @override
  void dispose() {
    _notificationSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _notificationSubscription = NotificationsBloc.instance.notificationStream
        .listen(_performActionOnNotification);
  }

  _performActionOnNotification(Map<String, dynamic> message) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  final TextEditingController _phoneNumberController = TextEditingController();

  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("in validate : ${_phoneNumberController.text.length}");
    if (_phoneNumberController.text.length == 10) {
      updateState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var eml;
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.only(top: 100),
                child: Hero(
                  tag: 'eml',
                  child: Image.asset(
                    'assets/images/EML.png',
                    height: SizeConfig.blockSizeVertical * 45,
                    // width: 700,
                    scale: .1,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 7,
          ),
          Divider(
            thickness: .6,
            indent: 30,
            endIndent: 30,
            color: Colors.green,
          ),
          Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
              alignment: Alignment.center,
              child: new RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Colors.green[300],
                onPressed: () => {},
                child: new Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          onPressed: () {
                            print("pressed");
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext bc) {
                                  print("VALID CC: $isValid");

                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter state) {
                                    return Container(
                                      padding: EdgeInsets.all(16),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Sign up',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            ' [This is a one time procedure] \nCreate Account quickly and have Manjeri at your fingertips ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  _phoneNumberController,
                                              autofocus: true,
                                              onChanged: (text) {
                                                validate(state);
                                              },
                                              decoration: InputDecoration(
                                                labelText:
                                                    "10 digit mobile number",
                                                prefix: Container(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "+91",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              autovalidate: true,
                                              autocorrect: false,
                                              maxLengthEnforced: true,
                                              validator: (value) {
                                                return !isValid
                                                    ? 'Please provide a valid 10 digit phone number'
                                                    : null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                child: RaisedButton(
                                                  color: !isValid
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.5)
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0)),
                                                  child: Text(
                                                    !isValid
                                                        ? "ENTER PHONE NUMBER"
                                                        : "CONTINUE",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    if (isValid) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    OTPScreen(
                                                              mobileNumber:
                                                                  _phoneNumberController
                                                                      .text,
                                                            ),
                                                          ));
                                                    } else {
                                                      validate(state);
                                                    }
                                                  },
                                                  padding: EdgeInsets.all(16.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                });
                          },
                          padding: EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Phone",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
