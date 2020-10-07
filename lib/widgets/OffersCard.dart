import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/offers.dart';

class OffersCard extends StatelessWidget {
  final Offers offer;
  OffersCard(this.offer);
  @override
  Widget build(BuildContext context) {
    return GFCard(
      content: Container(
        padding:
            offer.desc.trim() == '' ? EdgeInsets.all(0) : EdgeInsets.all(2),
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
      imageOverlay:
         offer.offerImage.trim() == '' ? null : NetworkImage(offer.offerImage),
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      title: GFListTile(
        title: Center(
          child: Container(
            padding: offer.mainText.trim() == ''
                ? EdgeInsets.all(0)
                : EdgeInsets.all(2),
            color: Colors.black38,
            child: Text(
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
    );
  }
}
