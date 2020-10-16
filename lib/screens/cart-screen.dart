import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/widgets/UserDetails.dart';
import 'package:plantStore/widgets/onlineCard.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Providers/product-provider.dart';
import '../models/order.dart';
import '../Providers/order-provider.dart';

class CartScreen extends StatefulWidget {
  static const routename = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void changePage(BuildContext context, String currUid, List cartToShow) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => NewUser(cartToShow, currUid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> cartItems = Provider.of<ProductProvider>(context).cart;
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: Firestore.instance.collection('online').snapshots(),
              builder: (ctx, snapshot) {
                final currUid = snap.data.uid;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final productData = snapshot.data.documents;
                print(productData);
                final cartToShow = [];
                productData.forEach((prod) {
                  if (cartItems.contains(prod.documentID)) {
                    cartToShow.add(prod);
                  }
                });

                return Scaffold(
                  appBar: AppBar(
                    title: Text('My Cart'),
                  ),
                  persistentFooterButtons: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (cartItems.length == 0) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text('Nothing in Cart!!'),
                                    content: Text(
                                        'Add something in cart to proceed'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ));
                        } else {
                          changePage(context, currUid, cartToShow);
                        }
                      },
                      child: Container(
                        color: Color(0xffE7F0C3),
                        height: 59,
                        width: 900,
                        child: Center(
                          child: Text(
                            '+ Add Details to place order',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff32AFA9),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  body: Provider.of<ProductProvider>(context).cart.isEmpty
                      ? Center(
                          child: Text('Nothing in Cart yet!'),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.builder(
                                itemCount: cartToShow.length,
                                itemBuilder: (ctx, i) {
                                  final String id = cartToShow[i].documentID;
                                  final String desc =
                                      cartToShow[i]['Description'];
                                  final String name = cartToShow[i]['Name'];
                                  final String mainText =
                                      cartToShow[i]['mainText'];
                                  final String photo = cartToShow[i]['photo'];
                                  final String price = cartToShow[i]['price'];
                                  final String details =
                                      cartToShow[i]['productDetails'];

                                  return OnlineCard(
                                    desc: desc,
                                    id: id,
                                    mainText: mainText,
                                    name: name,
                                    photo: photo,
                                    price: price,
                                    details: details,
                                  );
                                },
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 80),
                            //   width: double.infinity,
                            //   child: FlatButton(
                            //     color: Theme.of(context).primaryColor,
                            //     onPressed: () {
                            //       placeOrder(cartToShow, currUid);
                            //       Provider.of<ProductProvider>(context,
                            //               listen: false)
                            //           .emptyCart();
                            //     },
                            //     child: Text(
                            //       'Place Order',
                            //       style: TextStyle(
                            //         color: Theme.of(context).accentColor,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                );
              },
            ),
    );
  }
}
