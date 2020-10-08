import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/screens/news1.dart';

import '../models/offers.dart';

class NewsCard extends StatelessWidget {
  final Map offer;
  NewsCard(this.offer);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=>News1(offer))),
      child: GFCard(
        content: Container(
          padding:
              offer['Description'].trim() == '' ? EdgeInsets.all(0) : EdgeInsets.all(2),
          color: Colors.black26,
          child: Text(
            offer['Description'],
            softWrap: true,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        padding: EdgeInsets.all(4),
        color: Theme.of(context).primaryColorLight,
        elevation: 8,
        imageOverlay: offer['Photo'].trim() == ''
            ? null
            : NetworkImage(offer['Photo']),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        title: GFListTile(
          title: Center(
            child: Container(
              padding: offer['Heading'].trim() == ''
                  ? EdgeInsets.all(0)
                  : EdgeInsets.all(2),
              color: Colors.black38,
              child: Text(
                offer['Heading'],
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