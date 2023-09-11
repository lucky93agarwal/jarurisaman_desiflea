
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/changePassword.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivoo/Components/bottom_bar.dart';
class LoginPageActivity extends StatefulWidget {


  const LoginPageActivity({
    Key key,

  }) : super(key: key);

  @override
  _LoginPageActivityState createState() => _LoginPageActivityState();
}

//class Lang {
//  final List<dynamic> response;
//
//  Lang(this.response);
//
//  Lang.fromJson(Map<String, dynamic> json) : response = json['response'];
//
//  Map<String, dynamic> toJson() => {
//        'response': response,
//      };
//}

class Texts {
  final String result;
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String address;
  final String city;

  Texts(this.result, this.id, this.name, this.mobile, this.email, this.address,
      this.city);

  Texts.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        id = json['id'],
        name = json['name'],
        mobile = json['mobile'],
        email = json['email'],
        address = json['address'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
        'result': result,
        'id': id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'address': address,
        'city': city,
      };
}

class _LoginPageActivityState extends State<LoginPageActivity> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  addStringToSF(String mobile, String email, String id, String name,
      String address, String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', mobile);
    prefs.setString('email', email);
    prefs.setString('id', id);
    prefs.setString('name', name);
    prefs.setString('address', address);
    prefs.setString('city', city);
    prefs.setString('deeplink', "https://gpslab.page.link/?"+
        "link=https:https://play.google.com/store/apps/details?id=cheekolite.gpslab.com?"+id+
        "&apn="+"desiflea.gpslab.com"+
        "&st="+"DesiFlea Online Grocery App"+
        "&sd="+"Feel Desi"+
        "&si="+"https://desiflea.com/admin/api/desiflea_logo.png");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeOrderAccount()),
    );
  }

  String ButtonText = "Continue";
  _runapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String objText = '{"cdblock": "Login", "mobile": "' +
        Mobile +
        '", "password": "' +
        Password +
        '", "riferalID": "' +
        prefs.getString('referal') +
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

        List<Texts> tagObjs = rest.map((tagJson) => Texts.fromJson(tagJson)).toList();
        print("getresponse result = " + tagObjs[0].result.toString());

        if (tagObjs[0].result == "Invalid Password") {
          print("getresponse result 786 = ");

          Toast.show("Invalid Password", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          setState(() {
            _progress = false;
          });
        } else if (tagObjs[0].result == "Mobile number not registered") {
          print("getresponse result 776 = ");

          Toast.show("Mobile number not registered", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          setState(() {
            _progress = false;
          });
        } else {
          addStringToSF(tagObjs[0].mobile, tagObjs[0].email, tagObjs[0].id,
              tagObjs[0].name, tagObjs[0].address, tagObjs[0].city);
        }
      });
    });
  }

  void doAddition() {
    setState(() {
      Mobile = _mobileController.text;
      Password = _passController.text;

      _runapi();
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passController.dispose();


    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




    _firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> event) {},
        onMessage: (Map<String, dynamic> event) {},
        onResume: (Map<String, dynamic> event) {}
    );

    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true
    ));
    _firebaseMessaging.getToken().then((String msg){
      print("Firebase Token = "+msg);
    });



  }

  String Mobile;
  String Password;

  bool _progress = false;
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xff7AC920);
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
                "Log in",
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
                      EntryField(
                        controller: _passController,
                        label: 'Your Password',
                        image: 'images/icons/pass.png',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      InkWell(onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePassword()),
                        );
                      },child:  Center(child: Text('                                                      Forgot password?',style: TextStyle(fontSize: 12,),),),),
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
                        } else if (_passController.text.length == 0) {
                          Toast.show("Please enter your password..", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                        } else {
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
