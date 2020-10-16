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
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final _form = GlobalKey<FormState>();

  List<File> _selectedImages = [];
  String _name;
  String _address;
  String _phone;
  String _pin;
  Future<void> _saveForm() async {
    print('in');
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print('saved');

    if (_name.trim() == null || _address.trim() == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Please fill all the details'),
          content: Text(
              'Make sure you have entered Name, Timimg and uploaded your Photo'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      return;
    }

    print('SAVED');

    String url;

    if (_selectedImages.length > 0) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('contactImages')
          .child(_name + '.jpg');
      await ref.putFile(_selectedImages[0]).onComplete;

      url = await ref.getDownloadURL();
    } else {
      url = '';
    }
    print(url);

    //print(_addedExpense.title);
    //print(_addedExpense.category);
    //print(_addedExpense.day);
    Navigator.of(context).pop();
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
              .collection('List')
              .add({
            'Description': desc,
            'Name': name,
            'mainText': mainText,
            'photo': photo,
            'price': price,
            'productDetails': details,
            'name': _name,
            'address': _address,
            'phone': _phone,
            'pin': _pin,
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
            'name': _name,
            'address': _address,
            'phone': _phone,
            'pin': _pin,
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Contact',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveForm,
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        GestureDetector(
          onTap: () {
            // placeOrder(cartToShow, currUid);
            // Provider.of<ProductProvider>(context, listen: false).emptyCart();
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
