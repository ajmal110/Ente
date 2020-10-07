import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../widgets/main-drawer.dart';
import './cart-screen.dart';
import '../widgets/locRequieredTile.dart';
import '../widgets/categoryTile2.dart';
import '../widgets/mainOffersCarousel.dart';
import '../models/offers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String cat;
  SubCategoriesScreen(this.cat);

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final List<Map<String, String>> busTimings = [
    {'cat': 'Pandikad', 'path': 'assets/images/A.png'},
    {'cat': 'Nilamboor', 'path': 'assets/images/A.png'},
    {'cat': 'Wandoor', 'path': 'assets/images/A.png'},
    {'cat': 'Calicut', 'path': 'assets/images/A.png'},
    {'cat': 'Perinthlmanna', 'path': 'assets/images/A.png'},
    {'cat': 'Thrissur', 'path': 'assets/images/A.png'},
    {'cat': 'Eranamkulam', 'path': 'assets/images/A.png'},
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
    {'cat': 'PickUp', 'path': 'assets/images/pickup.png'},
    {'cat': 'Goods Auto', 'path': 'assets/images/Goods Auto.png'},
    {'cat': 'Truck', 'path': 'assets/images/truck.png'},
    {'cat': 'Tourist Bus', 'path': 'assets/images/Tourist Bus.png'},
    {'cat': 'Traveller', 'path': 'assets/images/Traveller.png'},
  ];

  final List<Map<String, String>> skilledWorkers = [
    {'cat': 'Painter', 'path': 'assets/images/Painter.png'},
    {'cat': 'Industrial Worker', 'path': 'assets/images/Industrial Worker.png'},
    {'cat': 'Flooring Works', 'path': 'assets/images/Flooring works.png'},
    {'cat': 'Catering', 'path': 'assets/images/Catering.png'},
    {'cat': 'Tyre&Puncture', 'path': 'assets/images/Tyre & Puncture.png'},
    {'cat': 'Fridge Mechanic', 'path': 'assets/images/Fridge & AC.png'},
    {'cat': 'Block Masonry', 'path': 'assets/images/Block Masonry.png'},
    {'cat': 'Vehicle Mechanic', 'path': 'assets/images/Vehicle Mechanics.png'},
    {'cat': 'Plastering', 'path': 'assets/images/plastering.png'},
    {'cat': 'Plumber', 'path': 'assets/images/Plumber.png'},
    {'cat': 'Coconut Climber', 'path': 'assets/images/Coconut Climber.png'},
    {'cat': 'Electrician', 'path': 'assets/images/Electrician.png'},
    {'cat': 'Grass Cutting', 'path': 'assets/images/Grass Cutting.png'},
    {'cat': 'Wood Cutting', 'path': 'assets/images/Wood Cutting.png'},
    {'cat': 'AC Mechanic', 'path': 'assets/images/AC Mechanic.png'},
  ];

  final List<Map<String, String>> doctor = [
    {'cat': 'Govt. Hospital', 'path': 'assets/images/Govt. Hospitals.png'},
    {'cat': 'General Medicine', 'path': 'assets/images/Homeo.png'},
    {'cat': 'Cardiologist', 'path': 'assets/images/cardiologist.png'},
    {'cat': 'Dentist', 'path': 'assets/images/Dentist.png'},
    {'cat': 'Dermatologist', 'path': 'assets/images/Dermatologist.png'},
    {'cat': 'Eye Care', 'path': 'assets/images/Eye.png'},
    {'cat': 'ENT Specialist', 'path': 'assets/images/ENT Specialist.png'},
    {'cat': 'Homeo Clinic', 'path': 'assets/images/General medicine.png'},
    {
      'cat': 'Gastroenterologist',
      'path': 'assets/images/Gastroenterologist.png'
    },
    {'cat': 'Medical Laboratory', 'path': 'assets/images/Laborotary.png'},
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
    {'cat': 'Meat', 'path': 'assets/images/meat.png'},
    {'cat': 'Footwear', 'path': 'assets/images/footware.png'},
    {'cat': 'Stationary', 'path': 'assets/images/stationary.png'},
    {'cat': 'Jewellery', 'path': 'assets/images/jwellery.png'},
    {'cat': 'Salon', 'path': 'assets/images/salon.png'},
    {'cat': 'Home appliances', 'path': 'assets/images/home appliances.png'},
    {'cat': 'Mobile Accessories', 'path': 'assets/images/mobile.png'},
    {'cat': 'Gents Fashion', 'path': 'assets/images/Gents Fashion.png'},
    {'cat': 'Electricals', 'path': 'assets/images/Electricals.png'},
    {'cat': 'Opticals', 'path': 'assets/images/opticals.png'},
    {'cat': 'Sanitaryware', 'path': 'assets/images/sanitary.png'},
    {'cat': 'Sports store', 'path': 'assets/images/sports store.png'},
    {'cat': 'Studio', 'path': 'assets/images/Studio.png'},
    {'cat': 'Courier Service', 'path': 'assets/images/Courier Service.png'},
  ];

  final List<Map<String, String>> govtInstitutions = [
    {'cat': 'Post Office', 'path': 'assets/images/Post Office.png'},
    {'cat': 'Police', 'path': 'assets/images/police.png'},
    {'cat': 'Fire Force', 'path': 'assets/images/Fire Force.png'},
  ];
  final List<Map<String, String>> bloodBank = [
    {'cat': 'A+ve', 'path': 'assets/images/A+ve.png'},
    {'cat': 'A-ve', 'path': 'assets/images/A-ve.png'},
    {'cat': 'AB+ve', 'path': 'assets/images/AB+ve.png'},
    {'cat': 'AB-ve', 'path': 'assets/images/AB-ve.png'},
    {'cat': 'B+ve', 'path': 'assets/images/B+ve.png'},
    {'cat': 'B-ve', 'path': 'assets/images/B-ve.png'},
    {'cat': 'O+ve', 'path': 'assets/images/O+ve.png'},
    {'cat': 'O-ve', 'path': 'assets/images/O-ve.png'},
  ];
  var selectedValue;

  List<String> locRequired = ['Taxi'];

  @override
  void initState() {
    selectedValue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> _categoryList = [
      {'cat': 'Bus Timings', 'subcat': busTimings},
      {'cat': 'Taxi', 'subcat': taxi},
      {'cat': 'Professionals', 'subcat': professionals},
      {'cat': 'Vehicles', 'subcat': vehicles},
      {'cat': 'Skilled Workers', 'subcat': skilledWorkers},
      {'cat': 'My Doctor', 'subcat': doctor},
      {'cat': 'Shopping', 'subcat': shopping},
      {'cat': 'Govt Institutions', 'subcat': govtInstitutions},
      {'cat': 'Blood Bank', 'subcat': bloodBank},
    ];

    List<Map<String, String>> _subCategoryList =
        _categoryList.firstWhere((ele) => ele['cat'] == widget.cat)['subcat'];
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
            child: StreamBuilder(
                stream:
                    Firestore.instance.collection('advertisement').snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final docs = snapshot.data.documents;
                  return MainOffersCarousel(docs);
                }),
          ),
          Text(
            widget.cat,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 10),
          if (widget.cat == 'Taxi')
            DropdownButton(
              onTap: () {},
              dropdownColor: Theme.of(context).primaryColorLight,
              value: selectedValue,
              items: [
                DropdownMenuItem(
                  child: Text('Location1'),
                  value: 'Location1',
                ),
                DropdownMenuItem(
                  child: Text('Govt. Hospital'),
                  value: 'Govt. Hospital',
                ),
                DropdownMenuItem(
                  child: Text('2'),
                  value: '2',
                ),
                DropdownMenuItem(
                  child: Text('3'),
                  value: '3',
                ),
                DropdownMenuItem(
                  child: Text('4'),
                  value: '4',
                ),
              ],
              hint: Text(
                'Select Location',
              ),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
                print(selectedValue);
              },
            ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: _subCategoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (ctx, i) {
                    if (locRequired.contains(widget.cat)) {
                      return LocTile(
                        widget.cat,
                        _subCategoryList[i]['cat'],
                        _subCategoryList[i]['path'],
                        selectedValue,
                      );
                    } else {
                      return CategoryTile2(
                        widget.cat,
                        _subCategoryList[i]['cat'],
                        _subCategoryList[i]['path'],
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
