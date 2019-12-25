import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ketot/models/product_model.dart';
import 'package:ketot/models/user_model.dart';
import 'package:ketot/scaffold/add_new_product.dart';
import 'package:ketot/utility/my_style.dart';

class ShowListProduct extends StatefulWidget {
  final UserModel userModel;
  ShowListProduct({Key key, this.userModel}) : super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field
  UserModel myUsermodel;
  List<ProductModel> productModels = List();

  // Method
  @override
  void initState() {
    super.initState();
    myUsermodel = widget.userModel;
    readAllProductThread();
  }

  Future<void> readAllProductThread() async {
    String url = 'http://androidthai.in.th/tot/getAllProductKea.php';

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('result ====>>> $result');

    for (var map in result) {
      ProductModel productModel = ProductModel.fromJson(map);
      setState(() {
        productModels.add(productModel);
      });
    }
  }

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(productModels[index].path),fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget showProduct(int index) {
    return Text(
      productModels[index].product,
      style: MyStyle().h2Style,
    );
  }

  Widget showDetail(int index) {
    String string = productModels[index].detail;
    if (string.length >= 40) {
      string = string.substring(0, 39);
      string = '$string ...';
    }

    return Text(string);
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showProduct(index),
          showDetail(index),
        ],
      ),
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
    );
  }

  Widget addProductButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                backgroundColor: MyStyle().mainColor,
                child: Icon(Icons.add),
                onPressed: () {
                  ////กดแล้วเปลี่ยนหน้า
                  MaterialPageRoute materialPageRoute =
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return AddNewProduct(
                      userModel: myUsermodel,
                    );
                  });
                  Navigator.of(context).push(materialPageRoute);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          addProductButton(),
          showListView(),
        ],
      ),
    );
  }
}
