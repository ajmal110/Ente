import 'package:flutter/material.dart';
import 'package:plantStore/Providers/call_provider.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';
import '../Providers/product-provider.dart';

class DocProfShop1 extends StatelessWidget {
  final docs;
  DocProfShop1(this.docs);
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
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () async {
          launchCaller('${docs['Phone']}');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.call,
          size: 40,
          color: Theme.of(context).accentColor,
        ),
      ),
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                // decoration: BoxDecoration(
                //     color: Colors.black26,
                //     borderRadius: BorderRadius.circular(20)),
                child: Text(
                  docs['Name'],
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      fontWeight: FontWeight.normal),
                  softWrap: true,
                ),
              ),
              background: Image.network(
                docs['Photo'],
                fit: BoxFit.cover,
              ),
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
                      Text(
                        'Phone No : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            docs['Phone'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4.8,
                            ),
                          ),
                        ),
                      ),
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
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Location : ',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Text(
                    docs['Location'],
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 4.3),
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
