import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantStore/Providers/call_provider.dart';
import 'package:plantStore/Providers/text-scroll.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:share/share.dart';

import '../models/product.dart';
import '../screens/cart-screen.dart';

class GovtInstitutions extends StatelessWidget {
  final String cat;

  GovtInstitutions(this.cat);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cat,
          style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // actions: [
        //   // IconButton(
        //   //   icon: Icon(Icons.search),
        //   //   onPressed: () {},
        //   // ),
        //   // IconButton(
        //   //   icon: Icon(Icons.shopping_cart, color: Colors.grey[200], size: 25),
        //   //   onPressed: () {
        //   //     Navigator.pushNamed(context, CartScreen.routename);
        //   //   },
        //   )
        // ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Institutions')
            .document(cat)
            .collection('List')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data.documents;
          if (docs.length == 0) {
            return Center(
              child: Text('No contacts to display'),
            );
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, i) => Container(
              padding: EdgeInsets.all(8),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(docs[i]['Photo']),
                    ),
                    title: Text(
                      docs[i]['Name'],
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.9,
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.phoneSquare,
                                        color: Colors.greenAccent,
                                        size: SizeConfig.blockSizeHorizontal *
                                            4.5,
                                      ),
                                      Text(
                                        '  ${docs[i]['Phone']}',
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.greenAccent,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 5,
                                      ),
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal *
                                            35.0,
                                        height: 20,
                                        child: MarqueeWidget(
                                            direction: Axis.horizontal,
                                            child: Text(
                                                " ${docs[i]['Location']}")),
                                        // Container(
                                        //   width: SizeConfig
                                        //           .blockSizeHorizontal *
                                        //       35.0,
                                        //   height: 20,
                                        //   child: Marquee(
                                        //     text:
                                        //         '  ${docs[i]['Location']}',
                                        //     style: TextStyle(
                                        //       fontSize: SizeConfig
                                        //               .blockSizeHorizontal *
                                        //           3.0,
                                        //     ),
                                        //     scrollAxis: Axis.horizontal,
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment
                                        //             .start,
                                        //     blankSpace: 20.0,
                                        //     velocity: 50.0,
                                        //     pauseAfterRound: Duration(
                                        //         milliseconds: 500),
                                        //     startPadding: 10.0,
                                        //     // accelerationDuration:
                                        //     //     Duration(seconds: 2),
                                        //     // accelerationCurve:
                                        //     //     Curves.linear,
                                        //     // decelerationDuration:
                                        //     //     Duration(
                                        //     //         milliseconds: 2),
                                        //     // decelerationCurve:
                                        //     //     Curves.linear,
                                        //   ),
                                      ),

                                      // Container(
                                      //   width: SizeConfig
                                      //           .blockSizeHorizontal *
                                      //       35.0,
                                      //   height: 20,
                                      //   child: ScrollingText(
                                      //     text:
                                      //         '  ${docs[i]['Location']}',
                                      //     textStyle: TextStyle(
                                      //       fontSize: SizeConfig
                                      //               .blockSizeHorizontal *
                                      //           3.0,
                                      //     ),
                                      //     scrollAxis: Axis.horizontal,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: RaisedButton.icon(
                                      color: Colors.white,
                                      onPressed: () async {
                                        launchCaller('${docs[i]['Phone']}');
                                      },
                                      icon: Icon(
                                        Icons.call,
                                        color: Colors.greenAccent,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 5,
                                      ),
                                      label: Text(
                                        'Call',
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    2.8),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: RaisedButton.icon(
                                      color: Colors.white,
                                      onPressed: () async {
                                        Share.share(
                                            'Name:${docs[i]['Name']} \n Phone:${docs[i]['Phone']} \n From Ente Manjeri');
                                      },
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.greenAccent,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 5,
                                      ),
                                      label: Text(
                                        'Share',
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    2.8),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
