import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:getwidget/getwidget.dart';
import '../models/product.dart';
import '../Providers/product-provider.dart';
import '../screens/categories-screen.dart';
import '../screens/categories-screen.dart';
import '../screens/subcategories-screen.dart';
import '../screens/product-display-screen.dart';

class CategoryTile extends StatelessWidget {
  final isSubCat;
  final category;
  final path;
  CategoryTile(this.isSubCat, this.category, this.path);

  List<Map<String, Object>> subCatList = [];

  @override
  Widget build(BuildContext context) {
    List<Product> productOfCategory =
        Provider.of<ProductProvider>(context).productOfCategory(category);

    return GestureDetector(
      onTap: () {
        if (category == 'more') {
          Navigator.of(context).pushNamed(CategoriesScreen.routename);
        } else if (category == 'News' || category == 'Turf') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ProductDisplay(category, productOfCategory),
            ),
          );
        } else {
          if (isSubCat) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDisplay(category, productOfCategory),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SubCategoriesScreen(category),
              ),
            );
          }
        }
      },
      child: GFCard(
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        elevation: 8,
        imageOverlay: AssetImage(
          path,
        ),
        borderRadius: BorderRadius.circular(40),
        boxFit: BoxFit.cover,
        title: GFListTile(
          description: Container(
            alignment: AlignmentDirectional.bottomCenter,
            padding: EdgeInsets.all(1),
            color: Colors.transparent,
            child: Text(
              category,
              softWrap: true,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                  letterSpacing: 1.3,
                  fontSize: 10),
            ),
          ),
        ),
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
      ),
    );
  }
}
