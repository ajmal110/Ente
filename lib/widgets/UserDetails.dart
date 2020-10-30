import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:plantStore/Providers/product-provider.dart';
import 'package:provider/provider.dart';

class NewUser extends StatefulWidget {
  final cartToShow;
  final currUid;
  NewUser(this.cartToShow, this.currUid);
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final _form = GlobalKey<FormState>();

  String _name;
  String _address;
  String _phone;
  String _pin;

  int _test = 0;
  Future<void> _saveForm() async {
    print('in');
    setState(() {
      _test = 0;
    });
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      setState(() {
        _test = 1;
      });
      return;
    }
    _form.currentState.save();
    print('saved');

    print('SAVED');

    //print(_addedExpense.title);
    //print(_addedExpense.category);
    //print(_addedExpense.day);
  }

  @override
  Widget build(BuildContext context) {
    void placeOrder(List cartToShow, String currUid) {
      String orderid = '';
      cartToShow.forEach((item) {
        final String desc = item['Description'];
        final String name = item['Name'];
        final String mainText = item['mainText'];
        final String photo = item['photo'];
        final String price = item['price'];
        final String details = item['productDetails'];

        if (orderid.trim() == '') {
          final id1 = Firestore.instance
              .collection('users')
              .document(currUid)
              .collection('orders')
              .document()
              .documentID;
          orderid = id1;
          Firestore.instance
              .collection('users')
              .document(currUid)
              .collection('orders')
              .document(orderid)
              .setData({
            'Name': _name,
            'Address': _address,
            'PIN code': _pin,
            'PhoneNo': _phone,
            'DateTime': DateTime.now().toIso8601String(),
          });
          Firestore.instance
              .collection('users')
              .document(currUid)
              .collection('orders')
              .document(orderid)
              .collection('List')
              .add({
            'Description': desc,
            'Name': name,
            'mainText': mainText,
            'photo': photo,
            'price': price,
            'productDetails': details,
          });
        } else {
          Firestore.instance
              .collection('users')
              .document(currUid)
              .collection('orders')
              .document(orderid)
              .collection('List')
              .add({
            'Description': desc,
            'Name': name,
            'mainText': mainText,
            'photo': photo,
            'price': price,
            'productDetails': details,
          });
        }
      });
    }

    createThanksDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text(
                'Thank you for placing your order :)',
                style: TextStyle(fontSize: 18),
              ),
              content: new Text(
                'Our Executive will contact you soon regarding the order.',
                style: TextStyle(fontSize: 13),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Continue"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(NewUser);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    createAlertDialog(BuildContext context) {
      _saveForm();
      print('*************$_test');
      if (_test == 1) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Please fill all the details'),
            content: Text(
                'Make sure you have entered Name, Address, PIN and entered your Phone No'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
          ),
        );
        return null;
      }
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text(
                'Are you sure?',
                style: TextStyle(fontSize: 18),
              ),
              content: new Text(
                'You are about to place your order. To continue press confirm',
                style: TextStyle(fontSize: 13),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Confirm"),
                  onPressed: () {
                    createThanksDialog(context);
                    placeOrder(widget.cartToShow, widget.currUid);
                    Provider.of<ProductProvider>(context, listen: false)
                        .emptyCart();
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
        ),
      ),
      persistentFooterButtons: <Widget>[
        GestureDetector(
          onTap: () {
            createAlertDialog(context);
          },
          child: Container(
            color: Color(0xffE7F0C3),
            height: 59,
            width: 900,
            child: Center(
              child: Text(
                'Place Order',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff32AFA9),
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        )
      ],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _form,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Address',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter your address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _address = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Area Pincode',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter your area pincode';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _pin = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter Phone Number',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter Phone Number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _phone = value;
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
