import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantStore/Providers/call_provider.dart';
import 'package:plantStore/models/size_config.dart';
import 'package:plantStore/widgets/newVehiSkil.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product.dart';

import 'cart-screen.dart';

class VehiSkill extends StatelessWidget {
  final String parent;
  final String cat;

  VehiSkill(this.parent, this.cat);

  void changePage(BuildContext context, String _cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => NewBus(parent, cat),
      ),
    );
  }

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
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart, color: Colors.grey[200], size: 25),
        //     onPressed: () {
        //       Navigator.pushNamed(context, CartScreen.routename);
        //     },
        //   )
        // ],
      ),
      persistentFooterButtons: <Widget>[
        GestureDetector(
          onTap: () {
            changePage(context, cat);
          },
          child: Container(
            color: Color(0xffE7F0C3),
            height: 59,
            width: 900,
            child: Center(
              child: Text(
                '+ Add My Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff32AFA9),
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        )
      ],
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(parent)
            .document(cat)
            .collection('List')
            .orderBy('Name')
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
                  padding: const EdgeInsets.all(3.0),
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
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.phoneSquare,
                              color: Colors.greenAccent,
                              size: SizeConfig.blockSizeHorizontal * 4.5,
                            ),
                            Text(
                              '  ${docs[i]['Phone']}',
                              softWrap: true,
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: RaisedButton.icon(
                            //       color: Colors.white,
                            //       onPressed: () async {
                            //         launchCaller('${docs[i]['Phone']}');
                            //       },
                            //       icon: Icon(
                            //         Icons.call,
                            //         color: Colors.greenAccent,
                            //       ),
                            //       label: Text(
                            //         'Call',
                            //         style: TextStyle(
                            //           color: Colors.greenAccent,
                            //         ),
                            //       )),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 5.0),
                            //   child: RaisedButton.icon(
                            //       color: Colors.white,
                            //       onPressed: () async {
                            //         Share.share(
                            //             'Name:${docs[i]['Name']} \n Phone:${docs[i]['Phone']} \n From Ente Manjeri');
                            //       },
                            //       icon: Icon(
                            //         Icons.share,
                            //         color: Colors.greenAccent,
                            //         size: SizeConfig.blockSizeHorizontal * 5,
                            //       ),
                            //       label: Text(
                            //         'Share',
                            //         style: TextStyle(
                            //             color: Colors.greenAccent,
                            //             fontSize:
                            //                 SizeConfig.blockSizeHorizontal *
                            //                     2.8),
                            //       )),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  launchCaller('${docs[i]['Phone']}');
                                },
                                child: Image.asset(
                                  'assets/images/49.png',
                                  height: 25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Share.share(
                                      'Name:${docs[i]['Name']} \n Phone:${docs[i]['Phone']} \n From Ente Manjeri');
                                },
                                child: Image.asset(
                                  'assets/images/50.png',
                                  height: 25,
                                ),
                              ),
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
