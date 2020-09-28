import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/productTile.dart';
import '../screens/cart-screen.dart';

class ProductDisplay extends StatelessWidget {
  final String appBarTitle;

  ProductDisplay(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
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
      body: null
    );
  }
}
