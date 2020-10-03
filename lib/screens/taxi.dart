import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantStore/Providers/call_provider.dart';

import '../models/product.dart';
import '../widgets/productTile.dart';
import '../screens/cart-screen.dart';

class Taxi extends StatelessWidget {
  final String parent;
  final String cat;
  final String loc;

  Taxi(this.parent, this.cat, this.loc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routename);
            },
          )
        ],
      ),
      persistentFooterButtons: <Widget>[
        GestureDetector(
          onTap: () {},
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
            .collection('Taxi')
            .document(cat)
            .collection(loc)
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
                      // backgroundImage: NetworkImage(docs[i]['Photo']),
                    ),
                    title: Text(
                      docs[i]['Name'],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          'Phone: ${docs[i]['Phone No']}',
                        ),
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
