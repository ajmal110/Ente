import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/offers.dart';
import './fullScreenImage.dart';

class OffersCard extends StatelessWidget {
  final Offers offer;
  OffersCard(this.offer);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => FullScreenImage(offer.offerImage, 'image'))),
      child: GFCard(
        content: Container(
          color: Colors.black26,
          child: Text(
            offer.desc,
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
        imageOverlay: offer.offerImage.trim() == ''
            ? null
            : NetworkImage(offer.offerImage),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        title: GFListTile(
          title: Center(
            child: Container(
              color: Colors.black38,
              child: offer.mainText == null
                  ? null
                  : Text(
                      offer.mainText,
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
