import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../models/offers.dart';
import './OffersCard.dart';
import './newsCard.dart';

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
          child: NewsCard({
            'Photo': prod['Photo'],
            'Heading': prod['Heading'],
            'Description': prod['Description'],
            'SubDes': prod['SubDes'],
          }),
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
