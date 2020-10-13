import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/screens/offerDeatailScreen.dart';

import '../models/offers.dart';
import './fullScreenImage.dart';

class OnlineCard extends StatelessWidget {
  final String id;
  final String desc;
  final String name;
  final String mainText;
  final String photo;
  final String price;
  final String productDetails;
  OnlineCard({
    this.id,
    this.desc,
    this.mainText,
    this.name,
    this.photo,
    this.price,
    this.productDetails,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => OfferDetailScreen(
            id: id,
            mainText: mainText,
            name: name,
            photo: photo,
            price: price,
            desc: desc,
            productDetails: productDetails,
          ),
        ),
      ),
      child: GFCard(
        content: Container(
          color: Colors.black26,
          child: Text(
            name,
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
        imageOverlay: photo.trim() == '' ? null : NetworkImage(photo),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        title: GFListTile(
          title: Center(
            child: Container(
              color: Colors.black38,
              child: mainText == null
                  ? null
                  : Text(
                      mainText,
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
