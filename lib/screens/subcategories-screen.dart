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
    {'cat': 'Cab', 'path': 'assets/images/cab.png'},
    {'cat': 'Auto', 'path': 'assets/images/auto.png'},
  ];
  final List<Map<String, String>> professionals = [
    {'cat': 'Civil Engineer', 'path': 'assets/images/Civil Engineer.png'},
    {'cat': 'Architect', 'path': 'assets/images/Architect.png'},
    {'cat': 'Surveyors', 'path': 'assets/images/Surveyors.png'},
    {'cat': 'Advocate', 'path': 'assets/images/Advocate.png'},
  ];
  final List<Map<String, String>> vehicles = [
    {'cat': 'Pickup ', 'path': 'assets/images/pickup.png'},
    {'cat': 'Goods Auto', 'path': 'assets/images/Goods Auto.png'},
    {'cat': 'Truck', 'path': 'assets/images/truck.png'},
  ];
  final List<Map<String, String>> news = [
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Bus timings', 'path': 'assets/images/bus.png'},
    {'cat': 'Taxi', 'path': 'assets/images/auto.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
  ];
  final List<Map<String, String>> skilled_workers = [
    {'cat': 'Painter', 'path': 'assets/images/Painter.png'},
    {'cat': 'Industrial Worker', 'path': 'assets/images/Industrial Worker.png'},
    {'cat': 'Flooring works', 'path': 'assets/images/Flooring works.png'},
    {'cat': 'Catering', 'path': 'assets/images/Catering.png'},
    {'cat': 'Tyre & Puncture', 'path': 'assets/images/Tyre & Puncture.png'},
    {'cat': 'Fridge & AC', 'path': 'assets/images/Fridge & AC.png'},
    {'cat': 'Block Masonry', 'path': 'assets/images/Block Masonry.png'},
    {'cat': 'Vehicle Mechanics', 'path': 'assets/images/Vehicle Mechanics.png'},
    {'cat': 'plastering', 'path': 'assets/images/plastering.png'},
    {'cat': 'Plumber', 'path': 'assets/images/Plumber.png'},
  ];
  final List<Map<String, String>> doctor = [
    {'cat': 'cardiologist', 'path': 'assets/images/cardiologist.png'},
    {'cat': 'Dentist', 'path': 'assets/images/Dentist.png'},
    {'cat': 'Dermatologist', 'path': 'assets/images/Dermatologist.png'},
    {'cat': 'Eye Care', 'path': 'assets/images/Eye.png'},
    {'cat': 'ENT Specialist', 'path': 'assets/images/ENT Specialist.png'},
    {'cat': 'General Medicine', 'path': 'assets/images/General medicine.png'},
    {
      'cat': 'Gastroenterologist',
      'path': 'assets/images/Gastroenterologist.png'
    },
    {'cat': 'Medical Laboratory.png', 'path': 'assets/images/Laborotary.png'},
    {'cat': 'Orthopaedic', 'path': 'assets/images/Orthopaedic.png'},
    {'cat': 'Paediatrician', 'path': 'assets/images/Paediatrician.png'},
    {'cat': 'Ayurveda', 'path': 'assets/images/Ayurveda.png'},
    {'cat': 'Gynaecologist', 'path': 'assets/images/Gynaecologist.png'},
  ];
  final List<Map<String, String>> shopping = [
    {'cat': 'Hypermarket', 'path': 'assets/images/Hypermarkets.png'},
    {'cat': 'Textiles', 'path': 'assets/images/textiles.png'},
    {'cat': 'Grocery', 'path': 'assets/images/vegetables.png'},
    {'cat': 'Bakery', 'path': 'assets/images/bakery.png'},
    {'cat': 'Furniture', 'path': 'assets/images/furniture.png'},
    {'cat': 'Hardware', 'path': 'assets/images/tools.png'},
    {'cat': 'Chicken & Meat', 'path': 'assets/images/meat.png'},
    {'cat': 'Footwear', 'path': 'assets/images/footware.png'},
    {'cat': 'Stationary', 'path': 'assets/images/stationary.png'},
    {'cat': 'jewellery.png', 'path': 'assets/images/jwellery.png'},
    {'cat': 'Salon', 'path': 'assets/images/salon.png'},
    {'cat': 'Home appliances', 'path': 'assets/images/home appliances.png'},
    {'cat': 'Mobile Accessories', 'path': 'assets/images/mobile.png'},
    {'cat': 'Gents Fashion', 'path': 'assets/images/Gents Fashion.png'},
    {'cat': 'Electricals', 'path': 'assets/images/Electricals.png'},
    {'cat': 'Opticals', 'path': 'assets/images/opticals.png'},
    {'cat': 'Sanitaryware', 'path': 'assets/images/sanitary.png'},
    {'cat': 'Sports Store', 'path': 'assets/images/sports store.png'},
  ];
  final List<Map<String, String>> govtInstitutions = [
    {'cat': 'Post Office', 'path': 'assets/images/Post Office.png'},
    {'cat': 'Police', 'path': 'assets/images/police.png'},
    {'cat': 'Fire Force', 'path': 'assets/images/Fire Force.png'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> _categoryList = [
      {'cat': 'Bus timings', 'subcat': busTimings},
      {'cat': 'Taxi', 'subcat': taxi},
      {'cat': 'Professionals', 'subcat': professionals},
      {'cat': 'Vehicles', 'subcat': vehicles},
      {'cat': 'News', 'subcat': news},
      {'cat': 'Skilled Workers', 'subcat': skilled_workers},
      {'cat': 'Doctor', 'subcat': doctor},
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
