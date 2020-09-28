import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/productTile.dart';
import '../screens/cart-screen.dart';

class TaxiProductDisplay extends StatefulWidget {
  final String appBarTitle;
  final String location;

  TaxiProductDisplay({
    @required this.appBarTitle,
    @required this.location,
  });

  @override
  _TaxiProductDisplayState createState() => _TaxiProductDisplayState();
}

class _TaxiProductDisplayState extends State<TaxiProductDisplay> {
  @override
  void initState() {
    if (widget.location == null) {
      Navigator.pop(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
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
      body: Center(
        child: Text(widget.location),
      ),
    );
  }
}
