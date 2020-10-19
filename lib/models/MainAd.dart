import 'package:flutter/cupertino.dart';

class MainAd {
  final String mainAdImage;
  final String mainText;
  final String link;

  MainAd({
    @required this.mainAdImage,
    this.mainText = '',
    this.link = '',
  });
}
