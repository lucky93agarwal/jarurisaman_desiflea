import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Pages/ForgotPassOTPPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivoo/Pages/reset_pass_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}
class Texts {
  final String status;


  Texts(this.status);

  Texts.fromJson(Map<String, dynamic> json)
      : status = json['status'];

  Map<String, dynamic> toJson() => {
    'status': status,
  };
}
class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _mobileController = TextEditingController();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
  String Mobile;
  _runapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String objText = '{"cdblock": "verify_mobile", "mobile": "' +
        Mobile +

        '"}';
    var url = baseUrl + "?req=" + objText;
    print("getresponse url = " + url.toString());

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("getresponse = " + rest.toString());

        if(rest.toString() == "[{status: 1}]"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassOTPPage(mobiles: _mobileController.text)),
          );
        }else {
          Toast.show("Invalid mobile number", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        }







        // if (tagObjs[0].result == "Invalid Password") {
        //   print("getresponse result 786 = ");
        //
        //   Toast.show("Invalid Password", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        //   setState(() {
        //     _progress = false;
        //   });
        // } else if (tagObjs[0].result == "Mobile number not registered") {
        //   print("getresponse result 776 = ");
        //
        //   Toast.show("Mobile number not registered", context,
        //       duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        //   setState(() {
        //     _progress = false;
        //   });
        // } else {
        //   addStringToSF(tagObjs[0].mobile, tagObjs[0].email, tagObjs[0].id,
        //       tagObjs[0].name, tagObjs[0].address, tagObjs[0].city);
        // }
      });
    });
  }
  void doAddition() {
    setState(() {
      Mobile = _mobileController.text;


      _runapi();
    });
  }
  @override
  void dispose() {
    _mobileController.dispose();



    super.dispose();
  }
  String ButtonText = "Continue";
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
              margin: const EdgeInsets.only(top: 50.0, left: 10),
              child: new Text(
                "Forgot Password",
                style: TextStyle(
                    color: black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            new Positioned(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
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
                        controller: _mobileController,
                        label: 'Mobile Number',
                        image: 'images/icons/ic_phone.png',
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),

                    ],
                  ),
                ],
              ),
            ),
            new Positioned(
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Image.asset(
                    "images/logos/loginbackimgone.png", //delivoo logo
//                height: 100.0,
                    width: double.infinity,
                  ),
                )),
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 70.0,
                  child: Column(children: [

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

                    BottomBar(
                      text: ButtonText,
                      onTap: () {
                        if (_mobileController.text.length == 0) {
                          Toast.show("Please enter you mobile number...", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                        }else {
                          setState(() {
                            _progress = true;
                          });
                          doAddition();
                        }
                      },
                    ),

                  ],),




                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
