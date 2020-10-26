import 'package:flutter/material.dart';
import 'package:plantStore/Providers/call_provider.dart';
import 'package:plantStore/screens/cart-screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';
import '../Providers/product-provider.dart';

class News1 extends StatelessWidget {
  final docs;
  News1(this.docs);
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);

  //THE FOLLOWING IS A LIST OF DUMMY REVIEWS which actually has to
  // be a part of Products OR has to be in a separate database with the
  //prodId along with it.
  //THIS IS JUST FOR YOUR FRONT-END looks....but this can EASILY be fitted
  //into desired BACK-END.
  final List<Map<String, Object>> reviews = [
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

  @override
  Widget build(BuildContext context) {
    String imageurl;
    if (docs['Photo'].toString().trim() != '') {
      imageurl = docs['Photo'];
    } else {
      imageurl = null;
    }
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'News',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: imageurl != null
                  ? Image.network(
                      docs['Photo'],
                      fit: BoxFit.fitWidth,
                    )
                  : null,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      // FlatButton.icon(
                      //     onPressed: () {
                      //       launch(('tel://1223467'));
                      //     },
                      //     icon: Icon(Icons.call),
                      //     label: null)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    docs['Heading'],
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Text(
                    docs['Description'],
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
