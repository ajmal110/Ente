import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../widgets/main-drawer.dart';
import './cart-screen.dart';
import '../widgets/categoryTile2.dart';
import '../widgets/mainOffersCarousel.dart';
import '../models/offers.dart';
import '../Providers/offer-provider.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String cat;
  SubCategoriesScreen(this.cat);

  //ADD YOUR ICONS AND SUBCATEGORIES HERE BELOW !!!

  final List<Map<String, String>> busTimings = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> taxi = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> professionals = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> vehicles = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> news = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> workers = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> business = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> shopping = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> govtInstitutions = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> _categoryList = [
      {'cat': 'Bus timings', 'subcat': busTimings},
      {'cat': 'Taxi', 'subcat': taxi},
      {'cat': 'Professionals', 'subcat': professionals},
      {'cat': 'Vehicles', 'subcat': vehicles},
      {'cat': 'News', 'subcat': news},
      {'cat': 'Workers', 'subcat': workers},
      {'cat': 'Business', 'subcat': business},
      {'cat': 'Shopping', 'subcat': shopping},
      {'cat': 'Govt Institutions', 'subcat': govtInstitutions},
    ];

    List<Map<String, String>> _subCategoryList =
        _categoryList.firstWhere((ele) => ele['cat'] == cat)['subcat'];
    final List<Offers> seasonalOffers =
        Provider.of<OfferProvider>(context).seasonalOffers;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ente Manjeri',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routename);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 30,
              left: 8,
              right: 8,
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            color: Theme.of(context).splashColor,
            child: MainOffersCarousel(seasonalOffers),
          ),
          Text(
            cat,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: _subCategoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (ctx, i) => CategoryTile(
                  true,
                  _subCategoryList[i]['cat'],
                  _subCategoryList[i]['path'],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
