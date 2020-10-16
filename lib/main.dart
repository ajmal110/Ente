import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantStore/Providers/phone_auth.dart';
import 'package:plantStore/models/app.dart';
import 'package:plantStore/screens/news.dart';
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
          News.routename: (ctx) => News()
        },
      ),
    );
  }
}

String _homeScreenText = "Waiting for token...";
bool _topicButtonsDisabled = false;
final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
final TextEditingController _topicController =
    new TextEditingController(text: 'topic');
final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final String itemId = message['id'];
  final Item item = _items.putIfAbsent(itemId, () => new Item(itemId: itemId))
    ..status = message['status'];
  return item;
}

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => new _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  void _navigateToItemDetail(Map<String, dynamic> message) {
    final String pagechooser = message['status'];
    Navigator.pushNamed(context, pagechooser);
  }

//CLEAR TOPIC
  void _clearTopicText() {
    setState(() {
      _topicController.text = "";
      _topicButtonsDisabled = true;
    });
  }

//DIALOGUE
  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

//WIDGET WHICH IS GOING TO BE CALLED IN THE ABOVE DIALOGUE
  Widget _buildDialog(BuildContext context, Item item) {
    return new AlertDialog(
        content: new Text("Item ${item.itemId} has been updated"),
        actions: <Widget>[
          new FlatButton(
            child: const Text('CLOSE'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          new FlatButton(
            child: const Text('SHOW'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ]);
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
      onMessage: (Map<String, dynamic> message) async {
        _showItemDialog(message);
      },
    );

//GETTING TOKEN FOR TESTING MANUALY
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Push Messaging Demo'),
        ),
        body: new Material(
          child: new Column(
            children: <Widget>[
              new Center(
                child: new Text(_homeScreenText),
              ),
              new Row(children: <Widget>[
                new Expanded(
                  child: new TextField(
                      controller: _topicController,
                      onChanged: (String v) {
                        setState(() {
                          _topicButtonsDisabled = v.isEmpty;
                        });
                      }),
                ),
                new FlatButton(
                  child: const Text("subscribe"),
                  onPressed: _topicButtonsDisabled
                      ? null
                      : () {
                          _firebaseMessaging
                              .subscribeToTopic(_topicController.text);
                          _clearTopicText();
                        },
                ),
                new FlatButton(
                  child: const Text("unsubscribe"),
                  onPressed: _topicButtonsDisabled
                      ? null
                      : () {
                          _firebaseMessaging
                              .unsubscribeFromTopic(_topicController.text);
                          _clearTopicText();
                        },
                ),
              ])
            ],
          ),
        ));
  }
}

//THREE DUMMY CLASSES FOR TESTING PURPOSE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PAGE1

//THIS IS THE CLASS WHICH IS USED TO PARSE THE INFORMATION
class Item {
  Item({this.itemId});
  final String itemId;
  StreamController<Item> _controller = new StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;
  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<Null>> routes = <String, Route<Null>>{};
  Route<Null> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => new MaterialPageRoute<Null>(
        settings: new RouteSettings(name: routeName),
        builder: (BuildContext context) => new News(),
      ),
    );
  }
}
