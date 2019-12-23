import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field

  // Method
  Widget mySizebox() {
    return SizedBox(
      width: 5.0,
      height: 16.0,
    );
  }

  Widget signInButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.cyan.shade700,
      child: Text(
        'Sing In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Text('Sing Up'),
      onPressed: () {},
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        mySizebox(),
        signUpButton(),
      ],
    );
  }

  Widget userForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'User :'),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password :'),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ke TOT',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.green.shade600,
        fontFamily: 'Oswald',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, Colors.blue.shade700],
          radius: 1.0,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                mySizebox(),
                showAppName(),
                userForm(),
                passwordForm(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
