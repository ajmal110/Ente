import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantStore/screens/turf.dart';
import 'package:plantStore/Providers/call_provider.dart';
import '../models/product.dart';
import '../widgets/productTile.dart';
import 'cart-screen.dart';

class Turf1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turf'),
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
      body: StreamBuilder(
        stream: Firestore.instance.collection('Turf').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data.documents;
          if (docs.length == 0) {
            return Center(
              child: Text('No Contacts to display'),
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
                    builder: (ctx) => Turf(docs[i]),
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
                        // backgroundImage: NetworkImage(docs[i]['Photo']),
                      ),
                      title: Text(
                        docs[i]['Name'],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone : ${docs[i]['Phone']}\nLocation : ${docs[i]['Location']}',
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
            ),
          );
        },
      ),
    );
  }
}
