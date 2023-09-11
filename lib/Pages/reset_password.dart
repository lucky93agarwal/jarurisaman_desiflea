
import 'dart:async';

import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Models/Error.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../API.dart';
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}
class Texts {
  final String result;



  Texts(this.result);

  Texts.fromJson(Map<String, dynamic> json)
      : result = json['status'];

  Map<String, dynamic> toJson() => {
    'status': result,

  };
}
class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confermPasswordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    _confermPasswordController.dispose();


    super.dispose();
  }
  var baseUrl = API.getAPIUrl();

  addStringToSF(String pass, String confpass) async {
    setState(() {
      _progress = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String objText = '{"cdblock": "reset_password", "pass": "' +
        pass + '", "user_id": "' +
        prefs.get("id") +
        '"}';
    var url = baseUrl + "?req=" + objText;

    print("Password Lucky Url YUYU = "+url);

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("Home OTP page Response url2 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeOrderAccount()),
        );
        print("Home OTP page Response as List url3 = " + rest.toString());

        List<Texts> tagObjs = rest.map((tagJson) => Texts.fromJson(tagJson)).toList();

        if(tagObjs[0].result =="1"){

        }else  if(tagObjs[0].result =="Customer already exist"){
          print("getresponse result 776 = ");

          Toast.show("Please try again", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }

//          List<Texts> tagObjs = rest.map((tagJson) => Texts.fromJson(tagJson)).toList();
//
//
        setState(() {
          _progress = false;
        });
//          addStringToSF(tagObjs[0].mobile,tagObjs[0].email, tagObjs[0].id,tagObjs[0].name,tagObjs[0].address,tagObjs[0].city);
      });
    });
  }
  String pass,confermPass;
  void doAddition() {
    setState(() {
      pass = _passwordController.text;
      confermPass = _confermPasswordController.text;


      addStringToSF(pass, confermPass);
    });
  }
  bool _progress = false;
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xffff791a);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xffFFFFFF);
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Container(
        child: new Stack(

          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0,left: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Please Enter",
                    style: TextStyle(color: black, fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Your New Password",
                    style: TextStyle(color: black, fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Don't worry! We'll not spam you.",
                    style: TextStyle(color: black, fontSize: 11),
                  ),
                ],
              ),

            ),

            new Positioned(
              child: Column(
                children: <Widget>[

                  SizedBox(height: 120,),
//                  Container(
//                    margin: const EdgeInsets.only(top: 50.0, left: 10),
//                    child: new Text(
//                      "",
//                      style: TextStyle(color: black, fontSize: 18,fontWeight: FontWeight.bold),
//                    ),
//                  ),


                  Column(

                    children: <Widget>[
                      EntryField(
                        controller: _passwordController,
                        label: 'Password',
                        keyboardType: TextInputType.text,
                      ),
                      EntryField(
                        controller: _confermPasswordController,
                        label: 'confirm password',
                        keyboardType: TextInputType.text,
                      ),

                    ],
                  ),





                ],
              ),
            ),
//             new Positioned(child: new Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: Image.asset(
//                 "images/logos/loginbackimgone.png", //delivoo logo
// //                height: 100.0,
//                 width: double.infinity,
//               ),
//             )),

            new Positioned( child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 70.0,
                child:  Column(children: [
                  Container(
                    width: double.infinity,
                    child: _progress
                        ? new LinearProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(
                          Colors.red),
                    )
                        : new Container(),
                  ),
                  BottomBar(text: "Continue",onTap: () {
                    if (_passwordController.text == '                             ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                            ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                           ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                          ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                         ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                        ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                       ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                      ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                     ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                    ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                   ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                  ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                 ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '                ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '               ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '              ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '             ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '            ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '           ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '          ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '         ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '        ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '       ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '      ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '     ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '    ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '   ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '  ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == ' ') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text == '') {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_passwordController.text.length == 0) {
                      Toast.show("Please enter you new password...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else if (_confermPasswordController.text.length == 0) {
                      Toast.show("Please enter your floor no..", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    }  else if (_confermPasswordController.text == _passwordController.text) {
                      doAddition();
                    } else {
                      Toast.show("confirm password not match..", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    }

                  }),
                  // RaisedButton(
                  //   onPressed: () {
                  //
                  //   },
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.only(
                  //     ),
                  //   ),
                  //   color: btncolor,
                  //   child: Text(
                  //     "Continue",
                  //     style: TextStyle(
                  //       color: color,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                ],),






              ),

            ),)
          ],
        ),
      ),

    );
  }
}
