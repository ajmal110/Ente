import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';
import '../widgets/newBustiming.dart';
import '../screens/cart-screen.dart';

class BusTimings extends StatelessWidget {
  final String cat;

  BusTimings(this.cat);

  void changePage(BuildContext context, String _cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => NewBus(cat),
      ),
    );
  }

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
            .collection('Bus Timings')
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
              child: Text('No Contacts to Display'),
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
                        // backgroundImage: NetworkImage(docs[i]['Photo']),
                        ),
                    title: Text(
                      docs[i]['Name'],
                    ),
                    trailing: Text(
                      '${docs[i]['Time']} ',
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
