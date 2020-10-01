import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';
import '../widgets/productTile.dart';
import '../screens/cart-screen.dart';

class GovtInstitutions extends StatelessWidget {
  final String cat;

  GovtInstitutions(this.cat);

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
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Govt Institutions')
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
                        // backgroundImage: NetworkImage(docs[i]['Photo']),
                        ),
                    title: Text(
                      docs[i]['Location'],
                    ),
                    subtitle: Text(
                      'Phone No : ${docs[i]['Phone']}',
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
