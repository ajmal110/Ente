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

class OfferDetailScreen extends StatefulWidget {
  final prod;
  final String id;
  final String desc;
  final String name;
  final String mainText;
  final String photo;
  final int price;
  final String details;
  final int count;

  OfferDetailScreen({
    this.prod,
    this.id,
    this.desc,
    this.mainText,
    this.name,
    this.photo,
    this.price,
    this.details,
    this.count,
  });

  @override
  _OfferDetailScreenState createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  int _itemCount;
  int _n = 0;

  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      _itemCount =
          (Provider.of<ProductProvider>(context).cart.contains(widget.id))
              ? Provider.of<ProductProvider>(context)
                  .cartWithCount
                  .firstWhere((element) => element['id'] == widget.id)['count']
              : 1;
    }
    setState(() {
      _init = false;
    });
    super.didChangeDependencies();
  }

  void changePage(
      BuildContext context, String currUid, List cartToShow, int count) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => NewUser(cartToShow, currUid, count),
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
                .document(widget.id)
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
                      builder: (ctx) => AddReview(widget.id),
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
                              child: Text(widget.name,
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
                              widget.name,
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
                          widget.photo,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: 5),
                          // Container(
                          //   padding: const EdgeInsets.all(15),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'Price : ',
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 20,
                          //         ),
                          //       ),
                          //       Card(
                          //         // elevation: 20,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(30),
                          //         ),
                          //         // color: Theme.of(context).primaryColor,
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(10.0),
                          //           child: Text(widget.price.toString(),
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                 // color: Theme.of(context).accentColor,
                          //                 fontSize: 16,
                          //               )
                          //               // fontWeight: FontWeight.bold),
                          //               ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
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
                              widget.details.toString(),
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
                              widget.desc.toString(),
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          SizedBox(height: 10),
                          Consumer<ProductProvider>(
                            builder: (ctx, product, ch) => Container(
                              margin: EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  _itemCount != 1
                                      ? new IconButton(
                                          icon: new Icon(Icons.remove),
                                          onPressed: () =>
                                              setState(() => _itemCount--),
                                        )
                                      : new IconButton(
                                          icon: new Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                        ),
                                  new Text(_itemCount.toString()),
                                  new IconButton(
                                      icon: new Icon(Icons.add),
                                      onPressed: () =>
                                          setState(() => _itemCount++))
                                ],
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Amount : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 15, top: 15),
                                child: Text('Rs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // color: Theme.of(context).accentColor,
                                      fontSize: 16,
                                    )
                                    // fontWeight: FontWeight.bold),
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child:
                                    Text((_itemCount * widget.price).toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          // color: Theme.of(context).accentColor,
                                          fontSize: 16,
                                        )
                                        // fontWeight: FontWeight.bold),
                                        ),
                              ),
                            ],
                          ),

                          Consumer<ProductProvider>(
                            builder: (ctx, product, ch) => Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.11,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FlatButton.icon(
                                  color: product.cart.contains(widget.id)
                                      ? Colors.grey
                                      : Theme.of(context).primaryColor,
                                  onPressed: () {
                                    product.toggleCart(widget.id, _itemCount);
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: product.cart.contains(widget.id)
                                        ? Colors.black
                                        : Theme.of(context).accentColor,
                                  ),
                                  label: Text(
                                    product.cart.contains(widget.id)
                                        ? 'Remove from Cart'
                                        : 'Add to Cart',
                                    style: TextStyle(
                                      color: product.cart.contains(widget.id)
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
                                    changePage(context, currUid, [widget.prod],
                                        _itemCount);
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
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              child: Text('* Cash On Delivery'),
                            ),
                          ),

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
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            rat.toStringAsFixed(
                                                1), //////////////////////
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.yellow[800],
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[800],
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
                                      elevation: 4,
                                      child: ListTile(
                                        leading: SizedBox(
                                          width: 80,
                                          child: Card(
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
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
                                                        color:
                                                            Colors.yellow[800],
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow[800],
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
