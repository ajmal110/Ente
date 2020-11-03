import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/widgets/onlineCard.dart';

import '../models/offers.dart';
import './OffersCard.dart';

class OnlineCarousel extends StatefulWidget {
  final List inputList;
  OnlineCarousel(this.inputList);
  @override
  _OnlineCarouselState createState() => _OnlineCarouselState();
}

class _OnlineCarouselState extends State<OnlineCarousel> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      enlargeMainPage: true,
      pagination: true,
      viewportFraction: 1.0,
      items: widget.inputList.map((prod) {
        print(prod['price']);
        return Container(
            width: MediaQuery.of(context).size.width,
            child: OnlineCard(
              prod: prod,
              id: prod.documentID.toString(),
              desc: prod['Description'],
              mainText: prod['mainText'],
              photo: prod['photo'],
              name: prod['Name'],
              price: prod['price'],
              details: prod['productDetails'],
            ));
      }).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
