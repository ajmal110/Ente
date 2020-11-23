import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final orderData;
  final orderId;

  OrderItem(this.orderData, this.orderId);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

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
        return StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(currUid)
              .collection('orders')
              .document(widget.orderId)
              .collection('List')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List order = snapshot.data.documents;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded ? min(order.length * 20.0 + 110, 200) : 95,
              child: Card(
                elevation: 10,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        DateFormat('dd/MM/yyyy hh:mm').format(
                            DateTime.parse(widget.orderData['DateTime'])),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                            _expanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        },
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      height:
                          _expanded ? min(order.length * 20.0 + 10, 100) : 0,
                      child: ListView(
                        children: order
                            .map(
                              (prod) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${prod['Name']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${prod['price'].toString()} x ${prod['quantity'].toString()} = ${prod['totalPrice'].toString()}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
