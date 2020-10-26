import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/cart-screen.dart';

class ProductDisplaySubcat extends StatelessWidget {
  final String parent;
  final String cat;

  ProductDisplaySubcat(this.parent, this.cat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cat),
          centerTitle: true,
          actions: [
            // IconButton(
            //   icon: Icon(Icons.search),
            //   onPressed: () {},
            // ),
            IconButton(
              icon:
                  Icon(Icons.shopping_cart, color: Colors.grey[200], size: 25),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routename);
              },
            )
          ],
        ),
        body: null);
  }
}
