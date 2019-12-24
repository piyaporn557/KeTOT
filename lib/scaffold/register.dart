import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketot/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file; //สร้างตัวแปลรองรับimage

  // Method
  Widget mySizebox() {
    return SizedBox(
      width: 5.0,
      height: 16.0,
    );
  }

  Widget nameForm() {
    Color color = Colors.purple;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'English Only',
              helperText: 'Type Your Name in Blank',
              helperStyle: TextStyle(color: color),
              labelText: 'Name :',
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.account_circle,
                size: 36.0,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userForm() {
    Color color = Colors.green.shade900;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'English Only',
              helperText: 'Type Your User in Blank',
              helperStyle: TextStyle(color: color),
              labelText: 'User :',
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.email,
                size: 36.0,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordForm() {
    Color color = Colors.orange.shade900;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'more 6 Charactor',
              helperText: 'Type Your Password in Blank',
              helperStyle: TextStyle(color: color),
              labelText: 'Password :',
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.lock,
                size: 36.0,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget camaraButton() {
    return OutlineButton.icon(
      icon: Icon(Icons.add_a_photo),
      label: Text('Camara'),
      onPressed: () {
        camaraAndGalleryThread(ImageSource.camera);
      },
    );
  }

  Future<void> camaraAndGalleryThread(ImageSource imageSource) async {
    var objact = await ImagePicker.pickImage(
      source: imageSource,
      maxWidth: 800.0,
      maxHeight: 600.0,
    );

    setState(() {
      file = objact;
    });
  }

  Widget galleryButton() {
    return OutlineButton.icon(
      icon: Icon(Icons.add_a_photo),
      label: Text('Gallery'),
      onPressed: () {
        camaraAndGalleryThread(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        camaraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showAvatar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: file == null ? Image.asset(
              'images/avatar.png',
              fit: BoxFit.contain,
            )
          : Image.file(file),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      tooltip: 'Upload to Server',
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          registerButton(),
        ],
        backgroundColor: MyStyle().mainColor,
        title: Text('Register'),
      ),
      body: ListView(
        children: <Widget>[
          mySizebox(),
          showAvatar(),
          showButton(),
          nameForm(),
          userForm(),
          passwordForm(),
        ],
      ),
    );
  }
}
