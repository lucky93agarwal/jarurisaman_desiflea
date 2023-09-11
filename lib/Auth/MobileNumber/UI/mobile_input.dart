import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:delivoo/Auth/login_navigator.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Locale/locales.dart';
import 'package:delivoo/Models/UserInfo.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:delivoo/Routes/routes.dart';
class MobileInput extends StatefulWidget {
  @override
  _MobileInputState createState() => _MobileInputState();
}

class _MobileInputState extends State<MobileInput> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  final dbhandler = DbStudentMamager.instance;

  void insertdata() async {
    print("id  = ");


    Map<String, dynamic> row = {
      DbStudentMamager.userid: ID,
      DbStudentMamager.email: Email,
      DbStudentMamager.mobile: MoibleNo,
      DbStudentMamager.username: Name,
      DbStudentMamager.password:""
    };

    final id = await dbhandler.insert(row);


    Navigator.pushNamed(context, LoginRoutes.verification);
    print("id in Login page = "+id.toString());
    Navigator.popAndPushNamed(
        context, PageRoutes.homeOrderAccountPage);

//    Toast.show("categoryID = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);




  }

  void queryall() async {
    var rowall = await dbhandler.queryall();
    rowall.forEach((row) {
      print(row);
      var _list = row.values.toList();
      print('mobile = ' + _list[2].toString());
    });
    print('length = ' + rowall.length.toString());
  }

  //MobileBloc _mobileBloc;
  String isoCode;

  String MoibleNo;
  String Password;

  String Name;
  String Email;
  String ID;

  @override
  void initState() {
    super.initState();
    //_mobileBloc = BlocProvider.of<MobileBloc>(context);
  }

  var userInfo = new List<UserInfo>();

  void doAddition() {
    setState(() {
      MoibleNo = _controller.text;
      Password = _passwordcontroller.text;

      print("Mobile No ");
      var baseUrl = "http://gpslab.in/jarurisaman/admin/api/index.php?p=";
      var url = baseUrl + "Login&mobile=" + MoibleNo + "&password=" + Password;

      http.get(url).then((response) {
        setState(() async {
          Iterable list = json.decode(response.body);
          userInfo = list.map((model) => UserInfo.fromJson(model)).toList();
          Toast.show("UserInfo Length = " + userInfo.length.toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

          if(userInfo.length >0) {
            for (int i = 0; i < userInfo.length; i++) {
              Name = userInfo[0].name;
              ID = userInfo[0].id;
              Email = userInfo[0].email;
              MoibleNo = userInfo[0].mobile;
              print("Name ="+Name);
              print("ID = "+ID);
              print("Email =  "+Email);
              print("Mobile No "+MoibleNo);


              insertdata();
            }
          }else {
            Toast.show("Please enter correct credentials.....", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Visibility(
                    visible: false,
                    child: CountryCodePicker(
                      onChanged: (value) {
                        isoCode = value.code;
                      },
                      builder: (value) => buildButton(value),
                      initialSelection: '+1',
                      textStyle: Theme.of(context).textTheme.caption,
                      showFlag: false,
                      showFlagDialog: true,
                      favorite: ['+91', 'US'],
                    ),
                  ),

                  Text(
                    "+91 ",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  //takes phone number as input
                  Expanded(
                    child: EntryField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      hint: AppLocalizations.of(context).mobileText,
                      maxLength: 10,
                      border: InputBorder.none,
                    ),
                  ),

                  //if phone number is valid, button gets enabled and takes to register screen
                ],
              ),
              Row(
                children: <Widget>[
                  //takes phone number as input
                  Expanded(
                    child: EntryField(
                      controller: _passwordcontroller,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: false,
                      hint: 'Enter password',
                      maxLength: 100,
                      border: InputBorder.none,
                    ),
                  ),

                  //if phone number is valid, button gets enabled and takes to register screen
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {


                        if(_controller.text.length ==0){
                          Toast.show("Please enter you mobile number..." , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                        }else if(_passwordcontroller.text.length ==0){
                          Toast.show("Please enter you Password..." , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                        }else{
                          doAddition();
                        }

//                        Navigator.pushNamed(context, LoginRoutes.registration);
//              _mobileBloc.add(SubmittedEvent(
//                  isoCode: isoCode, mobileNumber: _controller.text));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: queryall,
                    child: Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, LoginRoutes.registration);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void goToNextScreen(
      bool isRegistered, String normalizedPhoneNumber, BuildContext context) {
    if (isRegistered) {
      Navigator.pushNamed(
        context,
        LoginRoutes.verification,
      );
    } else {
      Navigator.pushNamed(
        context,
        LoginRoutes.registration,
      );
    }
  }

  buildButton(CountryCode isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context).textTheme.caption,
        ),
//        IconButton(
//          icon: Icon(Icons.arrow_drop_down),
//        ),
      ],
    );
  }
}
