import 'package:flutter/cupertino.dart';

import '../models/offers.dart';

class OfferProvider with ChangeNotifier {
  List<Offers> _topOffers = [
    Offers(offerImage: 'assets/images/green.png'),
    Offers(offerImage: 'assets/images/Manjeri Milk.jpeg'),
    Offers(offerImage: 'assets/images/t3.jpg'),
    Offers(offerImage: 'assets/images/t4.jpg'),
    Offers(offerImage: 'assets/images/t5.jpg'),
  ];
  
  List<Offers> _seasonalOffers = [
    Offers(offerImage: 'assets/images/ente manjeri.png'),
    Offers(offerImage: 'assets/images/Manjeri Milk.jpeg'),
    Offers(offerImage: 'assets/images/ad3.jpg'),
    Offers(offerImage: 'assets/images/ad4.jpg'),
  ];

  List<Offers> get topOffers {
    return [..._topOffers];
  }



  List<Offers> get seasonalOffers {
    return [..._seasonalOffers];
  }
}
