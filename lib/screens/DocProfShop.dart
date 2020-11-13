import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantStore/Providers/call_provider.dart';
import 'package:plantStore/screens/DocProfShop1.dart';
import 'package:plantStore/widgets/newDocProfShop.dart';

import '../models/product.dart';
import 'cart-screen.dart';

class DocProfShop extends StatelessWidget {
  final String parent;
  final String cat;

  DocProfShop(this.parent, this.cat);
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
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            cat,
            style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
          ),
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
            .collection('List').orderBy('Name')
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
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => DocProfShop1(docs[i]),
                        ),
                      ),
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
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Phone:\n ${docs[i]['Phone']}\n \n Location:\n ${docs[i]['Location']}',
                                        softWrap: true,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: RaisedButton.icon(
                                          color: Colors.white,
                                          onPressed: () async {
                                            launchCaller('${docs[i]['Phone']}');
                                          },
                                          icon: Icon(
                                            Icons.call,
                                            color: Colors.greenAccent,
                                          ),
                                          label: Text(
                                            'Call',
                                            style: TextStyle(
                                              color: Colors.greenAccent,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}
