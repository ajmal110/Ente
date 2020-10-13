import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class AddReview extends StatefulWidget {
  String id;
  AddReview(this.id);
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _form = GlobalKey<FormState>();

  String _rev;
  String _rat;

  Future<void> _saveForm() async {
    print('in');
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print('saved');

    if (_rev.trim() == null) {
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
    print('***********');
    Firestore.instance
        .collection('online')
        .document(widget.id)
        .collection('reviews')
        .add({
      'review': _rev,
      'rating': _rat,
    });
    print('done');

    //print(_addedExpense.title);
    //print(_addedExpense.category);
    //print(_addedExpense.day);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Review',
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
                              labelText: 'Review',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter your Review';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _rev = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Rating',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter your Review';
                              } else if (double.parse(value) > 5.0) {
                                return 'Rating only upto 5.0';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _rat = value;
                            },
                          ),
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
