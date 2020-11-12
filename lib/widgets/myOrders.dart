export 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/Providers/product-provider.dart';
import 'package:plantStore/widgets/orderItem.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}
// sdsf
class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final currUid = snap.data.uid;
        print(currUid);
        return StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(currUid)
              .collection('orders')
              .orderBy('DateTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final orderData = snapshot.data.documents;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Your Orders',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: orderData.length == 0
                  ? Center(
                      child: Text('No Orders Yet!'),
                    )
                  : ListView.builder(
                      itemCount: orderData.length,
                      itemBuilder: (ctx, i) =>
                          OrderItem(orderData[i], orderData[i].documentID),
                    ),
            );
          },
        );
      },
    );
  }
}
