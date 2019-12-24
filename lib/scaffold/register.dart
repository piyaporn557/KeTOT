import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketot/utility/my_style.dart';
import 'package:ketot/utility/normal_diaalog.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file; //สร้างตัวแปลรองรับimage
  String name, user, password;
  final formKey = GlobalKey<FormState>();

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
          child: TextFormField(onSaved: (String string){
            name = string.trim();
          },
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
          child: TextFormField(onSaved: (String string){
            user = string.trim();
          },
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
          child: TextFormField(onSaved: (String string){
            password = string.trim();
          },
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
      child: file == null
          ? Image.asset(
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
      onPressed: () {

        formKey.currentState.save();

        if (file == null) {
          normalDialog(
              context, 'ยังไม่เลือกรูปภาพ', 'กรุณาเลือกรูปภาพในแกลรี่');
        } 
        else if (name.isEmpty) {
          normalDialog(context, 'Name Blanh', 'Please type Your Name');
        }else if (user.isEmpty) {
          normalDialog(context, 'User Blanh', 'Please type Your User');
        }else if (password.length <= 5) {
           normalDialog(context, 'Password Weak', 'Please type Password More 6 Charactor');
        } else {
          uploadPictureToServer();
        } 
      },
    );
  }

  Future<void> uploadPictureToServer()async{

    Random random = Random();
    int i = random.nextInt(10000);
    String namePicture = 'avatar$i.jpg';
    print('namePicture = $namePicture');

    String urlAPI = 'https://www.androidthai.in.th/tot/saveFileKea.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, namePicture);
      FormData formData = FormData.from(map);

      Response response = await Dio().post(urlAPI, data: formData);
      print('response = $response');

    } catch (e) {
    }

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
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            mySizebox(),
            showAvatar(),
            showButton(),
            nameForm(),
            userForm(),
            passwordForm(),
          ],
        ),
      ),
    );
  }
}
