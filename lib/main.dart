import 'package:flutter/material.dart';
import 'package:ketot/scaffold/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เก๋เองจ้า', //ชื่อแอพบน appbar
      home: Authen(),
      debugShowCheckedModeBanner: false, //ปิดการโชว์ Debug
    );
  }
}
