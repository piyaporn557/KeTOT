import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketot/models/user_model.dart';
import 'package:ketot/utility/my_style.dart';
import 'package:ketot/utility/normal_diaalog.dart';

class AddNewProduct extends StatefulWidget {
  final UserModel userModel;
  AddNewProduct({Key key, this.userModel}) : super(key: key);

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  // Field
  File file;
  String product, detail, path, post, code;
  final formKey = GlobalKey<FormState>();
  UserModel myUsermodel;

  Widget camaraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36.0,
      ),
      onPressed: () {
        getPiture(ImageSource.camera);
      },
    );
  }

  Future<void> getPiture(ImageSource imageSource) async {
    var object = await ImagePicker.pickImage(
        source: imageSource, maxWidth: 800.0, maxHeight: 600.0);

    setState(() {
      file = object;
    });
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
      ),
      onPressed: () {
        getPiture(ImageSource.gallery);
      },
    );
  }

  // Method
  @override
  void initState() {
    super.initState();
    myUsermodel = widget.userModel;
    post = myUsermodel.name;
  }

  Widget nameForm() {
    return TextFormField(
      onSaved: (String string) {
        product = string.trim();
      },
      decoration: InputDecoration(labelText: 'Name Product'),
    );
  }

  Widget detailForm() {
    return TextFormField(
      onSaved: (String string) {
        detail = string.trim();
      },

      ///จำนวนบรรทัด
      maxLines: 3,

      ///typekeyboard
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(labelText: 'Detail Product'),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        camaraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file),
    );
  }

  Widget mainContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              showImage(),
              showButton(),
              nameForm(),
              detailForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text('Upload To Server'),
            color: MyStyle().mainColor,
            onPressed: () {
              formKey.currentState.save();
              if (file == null) {
                normalDialog(context, 'ยังไม่เลือกรูปภาพ', 'กรุณาเลือกรูปภาพ');
              } else if (product.isEmpty || detail.isEmpty) {
                normalDialog(context, 'มีช่องว่าง', 'กรุณากรอกข้อมูล');
              } else {
                uploadImage();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> uploadImage() async {
    String url = 'http://androidthai.in.th/tot/savePicture.php';

    Random random = Random();
    int i = random.nextInt(10000);
    String nameImage = 'pic$i.jpg';
    path = 'http://androidthai.in.th/tot/Product/$nameImage';
    code = 'code$i';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameImage);
      FormData data = FormData.from(map);
      await Dio().post(url, data: data).then((objact) {
        insertProductToMySQL();
        print('อัพโหลดเรียบร้อย');
      });
    } catch (e) {}
  }

  Future<void> insertProductToMySQL()async{
    
    String url = 'http://androidthai.in.th/tot/addProductKea.php?isAdd=true&Product=$product&Detail=$detail&Path=$path&Post=$post&Code=$code';

    Response response = await Dio().get(url);
    var result = response.data;
    if (result.toString() == 'true') {
      Navigator.of(context).pop();
    } else {
      normalDialog(context, 'บันทักไม่สำเร็จ', 'กรุณาลองใหีกครั้ง');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text('Add New Product'),
      ),
      body: Stack(
        children: <Widget>[
          mainContent(),
          uploadButton(),
        ],
      ),
    );
  }
}
