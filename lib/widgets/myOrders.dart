export 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/Providers/product-provider.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  final ordersToShow;
  final String currUid;
  MyOrders(this.ordersToShow, this.currUid);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(currUid)
            .collection('reviews')
            .snapshots(),
                  return Container(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {  },;
                });
  }
}
