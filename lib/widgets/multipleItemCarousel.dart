import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/offers.dart';
import './OffersCard.dart';

class MultipleItemCarousel extends StatelessWidget {
  final List offers;
  MultipleItemCarousel(this.offers);
  @override
  Widget build(BuildContext context) {
    return GFItemsCarousel(
      rowCount: 2,
      children: offers.map((offer) {
        return OffersCard(
          Offers(
            offerImage: offer['photo'],
            mainText: offer['mainText'],
          ),
        );
      }).toList(),
    );
  }
}
