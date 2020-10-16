import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/screens/bar-screen.dart';
import 'package:plantStore/screens/cart-screen.dart';
import 'package:plantStore/widgets/onlineCarousel.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/topOffersCard.dart';
import '../Providers/product-provider.dart';
import '../models/product.dart';
import '../widgets/categoryTile.dart';
import '../models/offers.dart';
import '../widgets/mainOffersCarousel.dart';
import '../widgets/newsCarousel.dart';
import '../widgets/multipleItemCarousel.dart';

class HomeScreen extends StatefulWidget {
  // HomeScreen({Key key, @required this.user})
  //     : assert(user != null),
  //       super(key: key);
  static String routename = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _topPicks = [];

  List<String> favIds;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _categoryList = [
      {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
      {'cat': 'Turf', 'path': 'assets/images/turf.png'},
      {'cat': 'Bus Timings', 'path': 'assets/images/bus.png'},
      {'cat': 'Taxi', 'path': 'assets/images/tab.png'},
      {'cat': 'more', 'path': 'assets/images/more.png'},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //Holds Ads or Offers or etc

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
                  stream: Firestore.instance
                      .collection('advertisement')
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final docs = snapshot.data.documents;
                    return MainOffersCarousel(docs);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemCount: _categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                    width: 250,
                    child: CategoryTile1(
                      _categoryList[i]['cat'],
                      _categoryList[i]['path'],
                    ),
                  ),
                ),
              ),
              Divider(),
              //Can be any Heading here

              //Holds Ads or Offers or etc
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: StreamBuilder(
                    stream: Firestore.instance.collection('News').snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final docs = snapshot.data.documents;
                      return NewsCar(docs);
                    }),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Offers And deals',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.25,
                child: StreamBuilder(
                  stream: Firestore.instance.collection('offers').snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final docs = snapshot.data.documents;
                    return MultipleItemCarousel(docs);
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Online Store',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 5,
                  ),
                ),
              ),
              Container(
                height: 250,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: StreamBuilder(
                  stream: Firestore.instance.collection('online').snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final docs = snapshot.data.documents;
                    return OnlineCarousel(docs);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
