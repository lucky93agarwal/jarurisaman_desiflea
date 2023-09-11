
import 'package:delivoo/Pages/changePassword.dart';
import 'package:delivoo/Pages/city.dart';
import 'package:delivoo/Pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivoo/dialogs/exit_confirmation_dialog.dart';
import 'dart:io';
import 'package:delivoo/database/DbStudentMamager.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // STARTUP FROM DYNAMIC LINK LOGIC
    // Get initial dynamic link if the app is started using the link
    // प्रारंभिक डायनामिक लिंक प्राप्त करें यदि ऐप को लिंक का उपयोग करके शुरू किया गया है
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    // INTO FOREGROUND FROM DYDNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      _handleDeepLink(dynamicLinkData);
    }, onError: (OnLinkErrorException e) async {
      print('Dynamic Link Failed: ${e.message}');
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deepLink: $deepLink');
      String string = deepLink.toString();

      List<String> result = string.split(
          "https:https://play.google.com/store/apps/details?id=cheekolite.gpslab.com?");

      returnValue = result[result.length - 1];

      print('_handleDeepLink | 786876 deepLink: ' + returnValue);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('referal', returnValue);

      print('_handleDeepLink | 76 deepLink: ' + prefs.getString('referal'));
      return returnValue;
    } else {
      print('_handleDeepLink | 786876 deepLink: else ');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('referal', "0");
    }
  }
}

String returnValue;

class _FirstPageState extends State<FirstPage> {


  String referal;

  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    DeleteAPI();




    prefs.setString("checkpopup", "0");





  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DynamicLinkService().handleDynamicLinks();
  }

  Future<void> data() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPageActivity()),
    );
  }

  final dbhandler = DbStudentMamager.instance;

  void DeleteAPI() async {
    print('delete row  2 = ');
    var rowall = await dbhandler.deleteLoginResponse();
    print('delete row = ' + rowall.toString());
  }

  Future<bool> _onWillPop() {
    getUserID();
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                  exit(0);
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    const color = const Color(0xffFFFFFF);
    const btncolor = const Color(0xffff791a);
    const logincolor = const Color(0xff359ece);
    const textcolor = const Color(0xffD5D5D5);

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: color,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //Center Column contents vertically,
          crossAxisAlignment: CrossAxisAlignment.center,
          //Center Column contents horizontally,
          children: <Widget>[
            Image.asset(
              "images/logos/applogo.png", //delivoo logo
              height: 200.0,
              width: 200,
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CityActivity()),
                    );
                  },
                  color: btncolor,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            // InkWell(onTap: (){
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => ChangePassword()),
            //   );
            // },child:  Center(child: Text('                                                      Forgot password?',style: TextStyle(fontSize: 12,),),),),

            // SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              //Center Row contents vertically,
              children: <Widget>[
                Text(
                  "Have an account?",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                InkWell(
                  onTap: () {
                    data();
                  },
                  child: Text(
                    " LOG IN",
                    style: TextStyle(
                      color: logincolor,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            //   child: Text(
            //     "I JUST WANNA EXPLORE",
            //     style: TextStyle(
            //       color: textcolor,
            //       fontSize: 11,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
