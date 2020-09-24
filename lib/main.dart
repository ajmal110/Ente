import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantStore/Providers/phone_auth.dart';
import 'package:provider/provider.dart';
import 'package:plantStore/screens/home.dart';
import './screens/bar-screen.dart';
import './screens/cart-screen.dart';
import './screens/orders-screen.dart';
import './screens/categories-screen.dart';
import './screens/login-screen.dart';
import './Providers/auth-provider.dart';
import 'Providers/order-provider.dart';
import './Providers/product-provider.dart';
import './Providers/offer-provider.dart';
import './screens/product-detail-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OfferProvider(),
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
        home: PhoneLogin(),
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
