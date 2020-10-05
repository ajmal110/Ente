import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/screens/VehiSkil.dart';
import 'package:provider/provider.dart';

import 'package:getwidget/getwidget.dart';
import '../screens/productDisplay-subcat.dart';
import '../screens/govtInstitutions.dart';
import '../screens/DocProfShop.dart';
import '../models/product.dart';
import '../Providers/product-provider.dart';
import '../screens/product-display-screen.dart';
import '../screens/categories-screen.dart';
import '../screens/subcategories-screen.dart';
import '../screens/busTimings.dart';

class CategoryTile2 extends StatelessWidget {
  final parent;
  final category;
  final path;
  CategoryTile2(this.parent, this.category, this.path);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (parent == 'Bus Timings') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => BusTimings(category)),
          );
        } else if (parent == 'Govt Institutions') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => GovtInstitutions(category)),
          );
        } else if (parent == 'My Doctor' ||
            parent == 'Professionals' ||
            parent == 'Shopping') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => DocProfShop(parent, category)),
          );
        } else if (parent == 'Vehicles' || parent == 'Skilled Workers' || parent == 'Blood Bank') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => VehiSkill(parent, category)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ProductDisplaySubcat(parent, category)),
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
