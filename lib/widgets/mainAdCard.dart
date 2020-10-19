import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/models/MainAd.dart';
import 'package:url_launcher/url_launcher.dart';

import './fullScreenImage.dart';

class MainAdCard extends StatelessWidget {
  final MainAd mainAd;
  var url = mainAd.link;
  MainAdCard(this.mainAd);
  @override
  Widget build(BuildContext context) {
    _launchURL() async {

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return GestureDetector(
      onTap: () => _launchURL(),
      child: GFCard(
        padding: EdgeInsets.all(4),
        color: Theme.of(context).primaryColorLight,
        elevation: 8,
        imageOverlay: mainAd.mainAdImage.trim() == ''
            ? null
            : NetworkImage(mainAd.mainAdImage),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        title: GFListTile(
          title: Center(
            child: Container(
              color: Colors.black38,
              child: mainAd.mainText == null
                  ? null
                  : Text(
                      mainAd.mainText,
                      softWrap: true,
                      style: TextStyle(
                        color: Theme.of(context).splashColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
