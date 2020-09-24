import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantStore/main.dart';
import 'package:plantStore/models/app.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/cart-screen.dart';
import '../screens/orders-screen.dart';
import '../Providers/auth-provider.dart';
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
  bool isSignedIn;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      isSignedIn = Provider.of<AuthProvider>(context, listen: false).isSignedIn;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void switchAuth() {
    Provider.of<AuthProvider>(context, listen: false).switchAuth();
    setState(() {
      isSignedIn = Provider.of<AuthProvider>(context, listen: false).isSignedIn;
    });
  }

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
                  'assets/images/ente manjeri.png',
                  height: 90,
                  fit: BoxFit.cover,
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
                  Navigator.pushNamed(
                      context,
                      isSignedIn
                          ? CartScreen.routename
                          : LoginScreen.routename);
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
                  Navigator.pushNamed(
                      context,
                      isSignedIn
                          ? OrdersScreen.routename
                          : LoginScreen.routename);
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
                    if (!isSignedIn) {
                      Navigator.pushNamed(context, LoginScreen.routename);
                    } else {
                      switchAuth();
                    }
                  },
                  leading: Icon(Icons.power_settings_new),
                  title: isSignedIn ? Text('Logout') : Text('Login')),
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
                      context, MaterialPageRoute(builder: (context) => App()));
                },
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: 40,
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.info),
                title: Text('About'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
