import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class NewBus extends StatefulWidget {
  final cat;
  NewBus(this.cat);
  @override
  _NewBusState createState() => _NewBusState();
}

class _NewBusState extends State<NewBus> {
  final _form = GlobalKey<FormState>();

  List<File> _selectedImages = [];
  String _name;
  String _time;

  Future<void> _picViaGallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (imageFile == null) {
      return;
    }
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    setState(() {
      _selectedImages.add(savedImage);
    });
  }

  Future<void> _picViaCamera() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    if (imageFile == null) {
      return;
    }
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    setState(() {
      _selectedImages.add(savedImage);
    });
  }

  Future<void> _takePicture() async {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Select Image From.....'),
        actions: <Widget>[
          FlatButton(
            child: Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              _picViaCamera();
            },
          ),
          FlatButton(
            child: Text('Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              _picViaGallery();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    print('in');
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print('saved');

    if (_name.trim() == null || _time.trim() == null) {
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
    Navigator.of(context).pop();
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

    Firestore.instance
        .collection('Bus Timings')
        .document(widget.cat)
        .collection('List')
        .add({
      'Name': _name,
      'Time': _time,
      'Photo': url,
    });
    print('done');

    //print(_addedExpense.title);
    //print(_addedExpense.category);
    //print(_addedExpense.day);
  }

  @override
  Widget build(BuildContext context) {
    createThanksDialog() {
      FocusScope.of(context).unfocus();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: new Text(
                'Are you sure about the details you entered?',
                style: TextStyle(fontSize: 18),
              ),
              content: new Text(
                'if not pls go back and ensure all the details entered are correct',
                style: TextStyle(fontSize: 13),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Continue"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _saveForm();
                  },
                ),
                new FlatButton(
                  child: Text("Go back"),
                  onPressed: () {
                    // setState(() {
                    //   _name = null;
                    //   _time = null;
                    //   _location = null;
                    //   _phone = null;
                    //   _selectedImages = [];
                    // });
                    // _form.currentState.reset();
                    Navigator.of(context).pop();
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
          'Add Contact',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () => createThanksDialog(),
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
                            decoration: InputDecoration(
                              labelText: 'Enter Timing',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please Enter Timing';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _time = value;
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'ADD Your Photo',
                          style: TextStyle(
                            color: Colors.purple[800],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _selectedImages.length == 0
                                  ? _takePicture
                                  : null,
                              child: Card(
                                elevation: 20,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.width * .4,
                                  child: _selectedImages.length == 0
                                      ? Center(
                                          ///place image
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.photo_camera,
                                                color: Colors.grey,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                              ),
                                              Text(
                                                'Add Image',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Image.file(
                                          _selectedImages[0],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                ),
                              ),
                            ),
                          ],
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
