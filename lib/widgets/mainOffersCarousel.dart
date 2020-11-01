import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/models/MainAd.dart';
import 'package:plantStore/widgets/mainAdCard.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/offers.dart';
import './OffersCard.dart';

class MainOffersCarousel extends StatefulWidget {
  final List inputList;
  MainOffersCarousel(this.inputList);
  @override
  _MainOffersCarouselState createState() => _MainOffersCarouselState();
}

class _MainOffersCarouselState extends State<MainOffersCarousel> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
      autoPlayCurve: Curves.easeInCubic,
      autoPlayInterval: Duration(seconds: 4),
      enlargeMainPage: true,
      pagination: true,
      viewportFraction: 1.0,
      items: widget.inputList.map((prod) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: MainAdCard(
            MainAd(
                mainAdImage: prod['photo'],
                mainText: prod['mainText'],
                link: prod['link']),
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
