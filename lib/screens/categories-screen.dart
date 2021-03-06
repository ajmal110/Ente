import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:plantStore/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/main-drawer.dart';
import './cart-screen.dart';
import '../widgets/categoryTile.dart';
import '../widgets/mainOffersCarousel.dart';
import '../models/offers.dart';

class CategoriesScreen extends StatelessWidget {
  static const routename = '/categories-screen';

//You can Change this List as per your requirment.
  final List<Map<String, String>> _categoryList = [
    {'cat': 'Bus Timings', 'path': 'assets/images/bus.png'},
    // {'cat': 'Train Booking', 'path': 'assets/images/Train Booking.png'},
    {'cat': 'Taxi', 'path': 'assets/images/tab.png'},
    {'cat': 'Professionals', 'path': 'assets/images/business.png'},
    {'cat': 'Vehicles', 'path': 'assets/images/Utility.png'},
    {'cat': 'News', 'path': 'assets/images/NEWS!.png'},
    {'cat': 'Skilled Workers', 'path': 'assets/images/Workers.png'},
    // {'cat': 'Business', 'path': 'assets/images/Business1.png'},
    {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
    {'cat': 'Institutions', 'path': 'assets/images/Untitled design(1).png'},
    {'cat': 'My Doctor', 'path': 'assets/images/doc.png'},
    {'cat': 'Turf', 'path': 'assets/images/turf.png'},
    {'cat': 'Blood Bank', 'path': 'assets/images/Blood Bank.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Ente Manjeri',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'Lato',
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.grey[200], size: 25),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routename);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
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
            'Categories',
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: _categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (ctx, i) => CategoryTile1(
                  _categoryList[i]['cat'],
                  _categoryList[i]['path'],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
