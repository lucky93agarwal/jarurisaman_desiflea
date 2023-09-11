import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/firstpage.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {

  final bool checklogin;
  RootPage({this.checklogin});


  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {

  Widget _waitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  String UserID;
  bool checklogin;


  void getUserID() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');
    if (UserID == null) {

      print('Length new Know =  1');

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FirstPage()),
      );

    }else {
      print('Length new Know =  2');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeOrderAccount()),
      );
    }




  }

  @override
  void initState() {
    super.initState();
    checklogin = widget.checklogin;

    getUserID();




  }
  @override
  Widget build(BuildContext context) {
    // TODO show login or home page depending on user login state





    return Scaffold();

  }
}