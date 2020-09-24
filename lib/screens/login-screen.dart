import 'package:flutter/material.dart';
import 'package:plantStore/Providers/phone_auth.dart';

class LoginScreen extends StatelessWidget {
  static const routename = '/login-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhoneLogin(),
    );
  }
}
