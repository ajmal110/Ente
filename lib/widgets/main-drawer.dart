import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/main.dart';
import 'package:plantStore/models/app.dart';
import 'package:plantStore/screens/aboutsUs.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/cart-screen.dart';
import '../widgets/myOrders.dart';
import '../screens/login-screen.dart';
import '../screens/categories-screen.dart';

class MainDrawer extends StatefulWidget {
  // final FirebaseUser user;

  // MainDrawer({Key key, @required this.user})
  //     : assert(user != null),
  //       super(key: key);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16,
      child: Container(
        color: Color(0xff32AFA9),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                child: Image.asset(
                  'assets/images/EML.png',
                  height: 40,
                  fit: BoxFit.fitHeight,
                ),
                color: Color(0xff32AFA9),
              ),
            ),
            Container(
              height: 40,
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 40,
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, CategoriesScreen.routename);
                },
                leading: Icon(Icons.category),
                title: Text('Categories'),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 40,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.routename);
                },
                leading: Icon(Icons.shopping_cart),
                title: Text('My Cart'),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 40,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => MyOrders()));
                },
                leading: Icon(Icons.history),
                title: Text('My Orders'),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 40,
              child: ListTile(
                  onTap: () {
                    _firebaseAuth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppWelcome(),
                      ),
                    );
                  },
                  leading: Icon(Icons.power_settings_new),
                  title: Text('Logout')),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 40,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  );
                },
                leading: Icon(Icons.info),
                title: Text('About'),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    child: Text('Powered by:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.asset(
                        'assets/images/20200614_165332_0000.png',
                        height: 120,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
