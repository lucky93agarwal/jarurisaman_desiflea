import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/area.dart';
import 'package:delivoo/Pages/city.dart';
import 'package:delivoo/Pages/firstpage.dart';
import 'package:delivoo/Pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class LoginAddressActivty extends StatefulWidget {
  @override
  _LoginAddressActivtyState createState() => _LoginAddressActivtyState();
}

class _LoginAddressActivtyState extends State<LoginAddressActivty> {
  final TextEditingController _towerController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _flatController = TextEditingController();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  String Tower;
  String Floor;
  String Flat;

  addStringToSF(String Tower, String Floor, String Flat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('tower', Tower);
    prefs.setString('floor', Floor);
    prefs.setString('flat', Flat);

    print("tower = " + prefs.getString('tower'));
    print("floor = " + prefs.getString('floor'));
    print("flat = " + prefs.getString('flat'));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpActivity()),
    );
  }
  void doAddition() {
    setState(() {
      Tower = _towerController.text;
      Floor = _floorController.text;
      Flat = _flatController.text;

      addStringToSF(Tower, Floor,Flat);
    });
  }
  @override
  void dispose() {
    _towerController.dispose();
    _floorController.dispose();
    _flatController.dispose();

    super.dispose();
  }
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
                    "Your Address",
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
                        controller: _towerController,
                        label: 'Tower',
                        keyboardType: TextInputType.text,
                      ),
                      EntryField(
                        controller: _floorController,
                        label: 'Floor number',
                        keyboardType: TextInputType.number,
                      ),
                      EntryField(
                        controller: _flatController,
                        label: 'Flat number',
                        keyboardType: TextInputType.number,
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
                child:  RaisedButton(
                  onPressed: () {

                    if (_towerController.text == '                             ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                            ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                           ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                          ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                         ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                        ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                       ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                      ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                     ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                    ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                   ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                  ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                 ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '                ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '               ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '              ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '             ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '            ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '           ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '          ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '         ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '        ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '       ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '      ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '     ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '    ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '   ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '  ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == ' ') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text == '') {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else
                    if (_towerController.text.length == 0) {
                      Toast.show("Please enter you tower...", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else if (_floorController.text.length == 0) {
                      Toast.show("Please enter your floor no..", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    }  else if (_flatController.text.length == 0) {
                      Toast.show("Please enter your flat no..", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    } else {
                      doAddition();
                    }

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                    ),
                  ),
                  color: btncolor,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

            ),)
          ],
        ),
      ),

    );
  }
}
