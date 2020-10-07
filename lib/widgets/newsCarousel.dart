import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/offers.dart';
import './OffersCard.dart';

class NewsCar extends StatefulWidget {
  final List inputList;
  NewsCar(this.inputList);
  @override
  _NewsCarState createState() => _NewsCarState();
}

class _NewsCarState extends State<NewsCar> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      enlargeMainPage: true,
      pagination: true,
      viewportFraction: 1.0,
      items: widget.inputList.map((prod) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: OffersCard(
            Offers(
                offerImage: prod['Photo'],
                mainText: prod['Heading'],
                desc: prod['Description']),
          ),
        );
      }).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
