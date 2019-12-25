import 'package:flutter/material.dart';
import 'package:ketot/models/user_model.dart';
import 'package:ketot/scaffold/add_new_product.dart';
import 'package:ketot/utility/my_style.dart';

class ShowListProduct extends StatefulWidget {

  final UserModel userModel;
  ShowListProduct({Key key, this.userModel}):super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field
  UserModel myUsermodel;

  // Method
  @override
  void initState(){
    super.initState();
    myUsermodel = widget.userModel;
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
                    return AddNewProduct(userModel: myUsermodel,);
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
        ],
      ),
    );
  }
}
