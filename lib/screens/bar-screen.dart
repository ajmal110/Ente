import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main-drawer.dart';
import './home.dart';
import './wishlist.dart';
import './profile.dart';
import './cart-screen.dart';
import './login-screen.dart';

class BarScreen extends StatefulWidget {
  @override
  _BarScreenState createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  int selectedPageIndex = 0;

  void _pageIndex(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  List pages;

  @override
  void initState() {
    pages = [
      HomeScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ente Manjeri',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon:
                  Icon(Icons.shopping_cart, color: Colors.grey[200], size: 25),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routename);
              },
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).primaryColorDark,
        currentIndex: selectedPageIndex,
        onTap: _pageIndex,
        showSelectedLabels: false,
        selectedIconTheme: IconThemeData(size: 40),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person), title: Text('Profile')),
        ],
      ),
      body: pages[selectedPageIndex],
    );
  }
}
