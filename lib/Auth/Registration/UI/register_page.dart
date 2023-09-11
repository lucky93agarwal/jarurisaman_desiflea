import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Models/UserInfo.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

import '../../login_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

//register page for registration of a new user
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Register',
          style: TextStyle(fontSize: 16.7),
        ),
      ),

      //this column contains 3 textFields and a bottom bar
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    // _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String MoibleNo;
  String Email;
  String Name;
  String Password;


  final dbhandler = DbStudentMamager.instance;
  void insertdata() async {

    Map<String, dynamic> row = {
      DbStudentMamager.userid: "123456",
      DbStudentMamager.email: Email,
      DbStudentMamager.mobile: MoibleNo,
      DbStudentMamager.username: Name,
      DbStudentMamager.password: Password,
    };

    final id = await dbhandler.insert(row);
//    Toast.show("categoryID = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    Navigator.pushNamed(context, LoginRoutes.verification);
    print("id in Registertion page = "+id.toString());
    Toast.show("id = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  var userInfo = new List<UserInfo>();
  void doAddition() {
    setState(() {
      MoibleNo = _mobileController.text;
      Name = _nameController.text;
      Email = _emailController.text;
      Password = _passwordController.text;

      insertdata();


      Toast.show("categoryID = ", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//      Navigator.pushNamed(context, LoginRoutes.verification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              //name textField
              EntryField(
                textCapitalization: TextCapitalization.words,
                controller: _nameController,
                label: 'FULL NAME',
                image: 'images/icons/ic_name.png',
              ),
              //email textField
              EntryField(
                textCapitalization: TextCapitalization.none,
                controller: _emailController,
                label: 'EMAIL ADDRESS',
                image: 'images/icons/ic_mail.png',
                keyboardType: TextInputType.emailAddress,
              ),

              //phone textField
              EntryField(
                controller: _mobileController,
                label: 'PHONE NUMBER',
                image: 'images/icons/ic_phone.png',
                keyboardType: TextInputType.number,
              ),

              EntryField(
                controller: _passwordController,
                label: 'PASSWORD',
                image: 'images/icons/ic_phone.png',
                keyboardType: TextInputType.emailAddress,
              ),

              Text(
                "We'll send verification code on above given number.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),

        //continue button bar
        BottomBar(
            text: "Continue",
            onTap: () {
              if(_mobileController.text.length ==0){
                Toast.show("Please enter you mobile number..." , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }else if(_nameController.text.length ==0){
                Toast.show("Please enter you name..." , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }else if(_emailController.text.length ==0){
                Toast.show("Please enter you email..." , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }else if(_passwordController.text.length ==0){
                Toast.show("Please enter you password..." , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }else {
                doAddition();
              }
//              Navigator.pushNamed(context, LoginRoutes.verification);
            })
      ],
    );
  }
}
