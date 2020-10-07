import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantStore/Providers/phone_auth.dart';
import 'package:plantStore/models/app.dart';
import 'package:provider/provider.dart';
import 'package:plantStore/screens/home.dart';
import './screens/bar-screen.dart';
import './screens/cart-screen.dart';
import './screens/orders-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/categories-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/login-screen.dart';
import 'Providers/order-provider.dart';
import './Providers/product-provider.dart';
import './screens/product-detail-screen.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plantStore/Providers/pushNotifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationService.instance.start();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryColor: Color(0xff32AFA9),
          accentColor: Colors.white,
          splashColor: Color(0xffE7F0C3),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.rubikTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: AppWelcome(),
        routes: {
          HomeScreen.routename: (ctx) => HomeScreen(),
          CartScreen.routename: (ctx) => CartScreen(),
          OrdersScreen.routename: (ctx) => OrdersScreen(),
          LoginScreen.routename: (ctx) => LoginScreen(),
          CategoriesScreen.routename: (ctx) => CategoriesScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()
        },
      ),
    );
  }
}
