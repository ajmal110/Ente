import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:plantStore/screens/offerDeatailScreen.dart';

import '../models/offers.dart';
import './fullScreenImage.dart';

class OnlineCard extends StatelessWidget {
  final prod;
  final String id;
  final String desc;
  final String name;
  final String mainText;
  final String photo;
  final String price;
  final String details;

  OnlineCard(
      {this.prod,
      this.id,
      this.desc,
      this.mainText,
      this.name,
      this.photo,
      this.price,
      this.details});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => OfferDetailScreen(
            prod: prod,
            id: id,
            mainText: mainText,
            name: name,
            photo: photo,
            price: price,
            desc: desc,
            details: details,
          ),
        ),
      ),
      child: GFCard(
        content: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
            color: Colors.black12,
            child: Text(
              name,
              softWrap: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
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
          title: Container(
            color: Colors.black38,
            child: mainText == null
                ? null
                : Text(
                    mainText,
                    softWrap: true,
                    style: TextStyle(
                        color: Theme.of(context).splashColor,
                        fontSize: 25,
                        letterSpacing: 2),
                  ),
          ),
        ),
      ),
    );
  }
}
