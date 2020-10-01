import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:getwidget/getwidget.dart';
import '../screens/taxi.dart';
import '../screens/taxi-product-display.dart';
import '../models/product.dart';
import '../Providers/product-provider.dart';
import '../screens/product-display-screen.dart';
import '../screens/categories-screen.dart';
import '../screens/subcategories-screen.dart';

class LocTile extends StatelessWidget {
  final parent;
  final category;
  final path;
  final loc;
  LocTile(this.parent, this.category, this.path, this.loc);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (loc == null) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    content: Text('Please Select Location'),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ));
        } else if (parent == 'Taxi') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => Taxi(parent,category,loc),
            ),
          );
        }
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: GFCard(
              color: Theme.of(context).primaryColorLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
              elevation: 8,
              imageOverlay: AssetImage(
                path,
              ),
              borderRadius: BorderRadius.circular(20),
              boxFit: BoxFit.cover,
            ),
          ),

          Text(
            category,
            softWrap: true,
            style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.grey[800],
                letterSpacing: 1.3,
                fontSize: 10),
          ),

          // title: GFListTile(
          //   description: Container(
          //     alignment: AlignmentDirectional.bottomCenter,
          //     padding: EdgeInsets.all(1),
          //     color: Colors.transparent,
          //     child: Text(
          //       category,
          //       softWrap: true,
          //       style: TextStyle(
          //           fontFamily: 'OpenSans',
          //           color: Colors.white,
          //           letterSpacing: 1.3,
          //           fontSize: 10),
          //     ),
          //   ),
          // ),

          // content: Container(
          //   alignment: AlignmentDirectional.bottomCenter,
          //   padding: EdgeInsets.all(8),
          //   color: Colors.black54,
          //   child: Text(
          //     category,
          //     softWrap: true,
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontStyle: FontStyle.italic,
          //         letterSpacing: 0,
          //         fontSize: 17),
          //   ),
          // ),
        ],
      ),
    );
  }
}
