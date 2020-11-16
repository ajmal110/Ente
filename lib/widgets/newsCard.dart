import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/Providers/text-scroll.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:plantStore/screens/news1.dart';

import '../models/offers.dart';

class NewsCard extends StatelessWidget {
  final Map offer;
  NewsCard(this.offer);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => News1(offer))),
      child: GFCard(
        content: Container(
          padding: offer['SubDes'].trim() == ''
              ? EdgeInsets.all(0)
              : EdgeInsets.all(0),
          // color: Colors.black26,
          child: Text(
            offer['SubDes'],
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: SizeConfig.blockSizeHorizontal * 3,
              // fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
        ),
        padding: EdgeInsets.all(1),
        color: Colors.white,
        elevation: 8,
        // imageOverlay:
        //     offer['Photo'].trim() == '' ? null : NetworkImage(offer['Photo']),
        // boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        title: GFListTile(
          title: Center(
            child: Container(
              padding: offer['Heading'].trim() == ''
                  ? EdgeInsets.all(0)
                  : EdgeInsets.all(0),
              // color: Colors.black38,
              child: Text(
                offer['Heading'],
                softWrap: true,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
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
