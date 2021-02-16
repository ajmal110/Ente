import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/screens/bar-screen.dart';
import 'package:plantStore/screens/cart-screen.dart';
import 'package:plantStore/screens/categories-screen.dart';
import 'package:plantStore/widgets/main-drawer.dart';
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
import 'package:plantStore/models/size_config.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

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
    SizeConfig().init(context);
    final List<Map<String, String>> _categoryList = [
      {'cat': 'Shopping', 'path': 'assets/images/Shopping.png'},
      {'cat': 'Turf', 'path': 'assets/images/turf.png'},
      {'cat': 'Bus Timings', 'path': 'assets/images/bus.png'},
      {'cat': 'Taxi', 'path': 'assets/images/tab.png'},
      {'cat': 'more', 'path': 'assets/images/more.png'},
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Ente Manjeri',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 28,
      //       fontFamily: 'Lato',
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     // IconButton(
      //     //   icon: Icon(Icons.search),
      //     //   onPressed: () {},
      //     // ),
      //     Padding(
      //       padding: const EdgeInsets.only(right: 8.0),
      //       child: IconButton(
      //         icon:
      //             Icon(Icons.shopping_cart, color: Colors.grey[200], size: 25),
      //         onPressed: () {
      //           Navigator.pushNamed(context, CartScreen.routename);
      //         },
      //       ),
      //     )
      //   ],
      // ),
      drawer: MainDrawer(),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CategoriesScreen.routename);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Categories  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 5,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          size: SizeConfig.blockSizeHorizontal * 7,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: SizeConfig.blockSizeHorizontal * 50,
                child: ListView.builder(
                  itemCount: _categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                    width: SizeConfig.blockSizeHorizontal * 50,
                    child: CategoryTile1(
                      _categoryList[i]['cat'],
                      _categoryList[i]['path'],
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 5,
                  ),
                ),
              ),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Offers And deals',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 5,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        size: SizeConfig.blockSizeHorizontal * 7,
                        color: Colors.black26,
                      ),
                    ],
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
              // Divider(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     'Online Store',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //       letterSpacing: 5,
              //     ),
              //   ),
              // ),
              // Container(
              //   height: 250,
              //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //   child: StreamBuilder(
              //     stream: Firestore.instance.collection('online').snapshots(),
              //     builder: (ctx, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //       final docs = snapshot.data.documents;
              //       return OnlineCarousel(docs);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
