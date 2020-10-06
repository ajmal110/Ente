import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantStore/screens/news1.dart';

import '../models/product.dart';
import '../widgets/productTile.dart';
import 'cart-screen.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
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
        stream: Firestore.instance.collection('News').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data.documents;
          if (docs.length == 0) {
            return Center(
              child: Text('No News to display'),
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
                    builder: (ctx) => News1(docs[i]),
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
                      title: Text(
                        docs[i]['Heading'],
                      ),
                      subtitle: Expanded(
                        child: Text(
                          docs[i]['Description'],
                          softWrap: true,
                        ),
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
