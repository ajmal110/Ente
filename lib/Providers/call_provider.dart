import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchCaller(String number) async {
  var url = 'tel:${number}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'could not place call';
  }
}
