import 'package:flutter/material.dart';
import 'package:ketot/models/user_model.dart';
import 'package:ketot/utility/my_style.dart';
import 'package:ketot/widget/show_infomation.dart';
import 'package:ketot/widget/show_listproduct.dart';

class MyService extends StatefulWidget {
  final UserModel userModel;
  MyService({Key key, this.userModel}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field
  UserModel myUserModel;
  Widget currentwidget = ShowListProduct();

  // Method
  @override
  void initState() {
    super.initState();
    myUserModel = widget.userModel;
    print('NameLogin = ${myUserModel.name}');
  }

  Widget menuShowList() {
    return ListTile(
      onTap: () {
        setState(() {
          currentwidget = ShowListProduct();
        });
        Navigator.of(context).pop();
      },
      leading: Icon(Icons.filter_1),
      title: Text('Show List Product'),
      subtitle: Text('แสดงรายการสินค้า'),
    );
  }

  Widget menuShowInfo() {
    return ListTile(onTap: (){
      setState(() {
        currentwidget = ShowImfomation();
      });
      Navigator.of(context).pop();
    },
      leading: Icon(Icons.filter_2),
      title: Text('Show Infomation'),
      subtitle: Text('แสดงข้อมูล'),
    );
  }

  Widget menuQRcode() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('QRcode'),
      subtitle: Text('สแกนคิวอาร์โค้ด'),
    );
  }

  Widget showNameLogin() {
    return Text(
      'Login By ${myUserModel.name}',
      style: MyStyle().h2Style,
    );
  }

  Widget showAvatar() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: ClipOval(
        child: Image.network(
          myUserModel.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ///ส่วนหัวของ Drawer
  Widget showHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/new-years.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          showAvatar(),
          showNameLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHeadDrawer(),
          menuShowList(),
          Divider(),
          menuShowInfo(),
          Divider(),
          menuQRcode(),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text('My Service'),
      ),
      body: currentwidget,
    );
  }
}
