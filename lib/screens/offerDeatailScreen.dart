import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/screens/addReviewScreen.dart';
import 'package:plantStore/screens/cart-screen.dart';
import '../widgets/UserDetails.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../Providers/product-provider.dart';

class OfferDetailScreen extends StatelessWidget {
  final prod;
  final String id;
  final String desc;
  final String name;
  final String mainText;
  final String photo;
  final String price;
  final String details;
  OfferDetailScreen(
      {this.prod,
      this.id,
      this.desc,
      this.mainText,
      this.name,
      this.photo,
      this.price,
      this.details});

  //THE FOLLOWING IS A LIST OF DUMMY REVIEWS which actually has to
  // be a part of Products OR has to be in a separate database with the
  //prodId along with it.
  //THIS IS JUST FOR YOUR FRONT-END looks....but this can EASILY be fitted
  //into desired BACK-END.
  /* final List<Map<String, Object>> reviews = [
    {
      'rating': 4.0,
      'review':
          'Excellent phone in this budget .The only thing is battery drains fast and charges slowly and also camera is not so good but works fine .'
    },
    {
      'rating': 4.0,
      'review':
          'Excellent phone in this budget .The only thing is battery drains fast and charges slowly and also camera is not so good but works fine .'
    },
    {
      'rating': 4.0,
      'review':
          'Excellent phone in this budget .The only thing is battery drains fast and charges slowly and also camera is not so good but works fine .'
    },
    {
      'rating': 4.0,
      'review':
          'Excellent phone in this budget .The only thing is battery drains fast and charges slowly and also camera is not so good but works fine .'
    },
    {
      'rating': 4.0,
      'review':
          'Excellent phone in this budget .The only thing is battery drains fast and charges slowly and also camera is not so good but works fine .'
    },
    {
      'rating': 4.0,
      'review':
          'Excellent phone in this budget .The only thing is battery drains fast and charges slowly and also camera is not so good but works fine .'
    },
  ];
 */

  void changePage(BuildContext context, String currUid, List cartToShow) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => NewUser(cartToShow, currUid),
      ),
    );
  }

  var currUid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snap) {
        currUid = snap.data.uid;
        return StreamBuilder(
            stream: Firestore.instance
                .collection('online')
                .document(id)
                .collection('reviews')
                .snapshots(),
            builder: (ctx, snapshot) {
              final reviews =
                  snapshot.data == null ? [] : snapshot.data.documents;
              double rat = 0;
              for (int j = 0; j < reviews.length; j++) {
                rat =
                    ((rat * j) + double.parse(reviews[j]['rating'])) / (j + 1);
              }
              print(rat);
              print(rat.toStringAsFixed(2));
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.rate_review,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddReview(id),
                    ),
                  ),
                ),
                // appBar: AppBar(
                //   title: GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text(
                //       'Online Store',
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontFamily: 'Lato',
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                //   centerTitle: true,
                //   actions: [
                //     // IconButton(
                //     //   icon: Icon(Icons.search),
                //     //   onPressed: () {},
                //     // ),
                //     IconButton(
                //       icon: Icon(Icons.shopping_cart,
                //           color: Colors.grey[200], size: 25),
                //       onPressed: () {
                //         Navigator.pushNamed(context, CartScreen.routename);
                //       },
                //     )
                //   ],
                // ),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      // automaticallyImplyLeading: false,
                      expandedHeight: 200,
                      pinned: true,
                      floating: true,
                      snap: true,
                      shadowColor: Colors.black,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        //
                        title: Stack(
                          children: [
                            Container(
                              child: Text(name,
                                  style: TextStyle(
                                      // color: Colors.white,

                                      fontSize: 18.0,
                                      fontFeatures: [
                                        FontFeature.enable('smcp')
                                      ],
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 2
                                        ..color = Colors.black,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Montserrat')),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFeatures: [FontFeature.enable('smcp')],
                                  color: Color(0xffE7F0C3),
                                  letterSpacing: 1.1,
                                  fontFamily: 'Montserrat'),
                            ),
                          ],
                        ),
                        background: Image.network(
                          photo,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Text(
                                  'Price : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Card(
                                  // elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  // color: Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(price.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          // color: Theme.of(context).accentColor,
                                          fontSize: 16,
                                        )
                                        // fontWeight: FontWeight.bold),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Product Details : ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            child: Text(
                              details.toString(),
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Description : ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            child: Text(
                              desc.toString(),
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          SizedBox(height: 10),
                          Consumer<ProductProvider>(
                            builder: (ctx, product, ch) => Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.11,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FlatButton.icon(
                                  color: product.cart.contains(id)
                                      ? Colors.grey
                                      : Theme.of(context).primaryColor,
                                  onPressed: () {
                                    product.toggleCart(id);
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: product.cart.contains(id)
                                        ? Colors.black
                                        : Theme.of(context).accentColor,
                                  ),
                                  label: Text(
                                    product.cart.contains(id)
                                        ? 'Remove from Cart'
                                        : 'Add to Cart',
                                    style: TextStyle(
                                      color: product.cart.contains(id)
                                          ? Colors.black
                                          : Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Consumer<ProductProvider>(
                            builder: (ctx, product, ch) => Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.11,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FlatButton.icon(
                                  color: Colors.teal[800],
                                  onPressed: () {
                                    changePage(context, currUid, [prod]);
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  label: Text(
                                    'Buy Now',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(thickness: 3),
                          //       Consumer<ProductProvider>(
                          //         builder: (ctx, product, ch) => Center(
                          //           child: Container(
                          //             height: MediaQuery.of(context).size.width * 0.11,
                          //             width: MediaQuery.of(context).size.width * 0.9,
                          //             child: FlatButton.icon(
                          //               onPressed: () {},
                          //               label: Text('Buy Now'),
                          //               icon: Icon(Icons.shopping_bag),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Divider(thickness: 3),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Text(
                                  'Rating : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                if (reviews.length == 0) Text('No ratings yet'),
                                if (reviews.length != 0)
                                  Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            rat.toStringAsFixed(
                                                1), //////////////////////
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Reviews : ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children: [
                              if (reviews.length == 0)
                                Text('No Reviews to Display'),
                              if (reviews.length != 0)
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  padding: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                    itemCount: reviews.length,
                                    itemBuilder: (ctx, i) => Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 8,
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: 80,
                                          child: Card(
                                            elevation: 20,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    double.parse(reviews[i]
                                                            ['rating'])
                                                        .toStringAsFixed(
                                                            1), //////////
                                                    style: TextStyle(
                                                        color: Colors.amber,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(reviews[i]['review']),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
