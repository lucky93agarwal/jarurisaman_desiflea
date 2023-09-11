import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Models/UserInfo.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivoo/Routes/routes.dart';

//register page for registration of a new user
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _streetController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  String Address;
  String Street;
  String Pincode;
  String City;
  String State;

  String Userid;
  String Mobile;
  String Email;
  String Name;

  final dbhandler = DbStudentMamager.instance;

  void insertdata() async {
    var rowall = await dbhandler.queryall();
//    final count =  await dbhandler.firstEmpty();
    Length = rowall.length;
    print('Length = ' + Length.toString());
    rowall.forEach((row) {
      print(row);
      var _list = row.values.toList();
      UserID = _list[0].toString();
      Email = _list[1].toString();
      Mobile = _list[2].toString();
      Name = _list[3].toString();

      print('get UserID = ' + _list[0].toString());
    });
    Map<String, dynamic> rows = {
      DbStudentMamager.email: Email,
      DbStudentMamager.mobile: Mobile,
      DbStudentMamager.username: Name,
      DbStudentMamager.address: Address,
      DbStudentMamager.city: City,
      DbStudentMamager.state: State,
      DbStudentMamager.pincode: Pincode,
      DbStudentMamager.street: Street
    };

    final id = await dbhandler.insertaddress(rows);
//    Toast.show("categoryID = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//    Navigator.pushNamed(context, PageRoutes.viewCart);
    print(id);
    Toast.show("id = " + id.toString(), context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  var userInfo = new List<UserInfo>();

  void doAddition() {
    setState(() {
      Address = _addressController.text;
      Street = _streetController.text;
      Pincode = _pincodeController.text;
      City = _cityController.text;
      State = _stateController.text;

      print("Address = " + Address);
      print("Street = " + Street);
      print("Pincode = " + Pincode);
      print("City = " + City);
      print("State = " + State);
      print("UserID = " + UserID);

      insertdata();
    });
  }

  String UserID;
  int Length;

  void getUserID() async {
    var rowall = await dbhandler.queryall();
//    final count =  await dbhandler.firstEmpty();
    Length = rowall.length;
    print('Length = ' + Length.toString());
    rowall.forEach((row) {
      print(row);
      var _list = row.values.toList();
      UserID = _list[0].toString();

      print('get UserID = ' + _list[0].toString());
    });

//    print('get UserTable count = '+count.toString());
//    print('get UserTable length = '+rowall.length.toString());
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final address = TextFormField(
      controller: _addressController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'FULL Address',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final street = TextFormField(
      controller: _streetController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Street',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final city = TextFormField(
      controller: _cityController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'City',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final state = TextFormField(
      controller: _stateController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'State',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final pincode = TextFormField(
      controller: _pincodeController,
      autofocus: false,
      maxLength: 6,
      keyboardType: TextInputType.number,
//      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Pincode',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_addressController.text.length == 0) {
            Toast.show("Please enter you order address...", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else if (_streetController.text.length == 0) {
            Toast.show("Please enter order street...", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else if (_cityController.text.length == 0) {
            Toast.show("Please enter you city...", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else if (_stateController.text.length == 0) {
            Toast.show("Please enter you state...", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          } else if (_pincodeController.text.length == 0) {
            Toast.show("Please enter you Pincode...", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }else{
            doAddition();
          }
//          Navigator.pushNamed(context, PageRoutes.viewCart);
        },
        padding: EdgeInsets.all(12),
        color: Colors.green,
        child: Text('Continue', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Address Page',
          style: TextStyle(fontSize: 16.7),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            address,
            SizedBox(height: 8.0),
            street,
            SizedBox(height: 8.0),
            city,
            SizedBox(height: 8.0),
            state,
            SizedBox(height: 8.0),
            pincode,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}
