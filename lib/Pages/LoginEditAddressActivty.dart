import 'package:delivoo/Components/entry_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'dart:convert';
import 'package:delivoo/Components/bottom_bar.dart';


class LoginEditAddressActivty extends StatefulWidget {

  final String CityName;
  final String AreaName;
  final String Cityid;
  final String Areaid;
  final String SocietyID;

  final String SocietyName;
  LoginEditAddressActivty({this.CityName,this.Cityid, this.AreaName, this.Areaid, this.SocietyName, this.SocietyID});
  @override
  _LoginEditAddressActivtyState createState() => _LoginEditAddressActivtyState();

}
class Texts {
  final String result;
  final String status;
  final String address;


  Texts(this.result, this.status, this.address);

  Texts.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        status = json['status'],
        address = json['address'];

  Map<String, dynamic> toJson() => {
    'result': result,
    'status': status,
    'address': address,

  };
}
class _LoginEditAddressActivtyState extends State<LoginEditAddressActivty> {
  final TextEditingController _towerController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _flatController = TextEditingController();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  String Tower;
  String Floor;
  String Flat;

  // addStringToSF(String Tower, String Floor, String Flat) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   prefs.setString('tower', Tower);
  //   prefs.setString('floor', Floor);
  //   prefs.setString('flat', Flat);
  //
  //   print("tower = " + prefs.getString('tower'));
  //   print("floor = " + prefs.getString('floor'));
  //   print("flat = " + prefs.getString('flat'));
  //
  // }


  String cityName,cityID,areaName, areaID, societyName,societyID, UserID;
  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserID();
    cityName = widget.CityName;
    areaName = widget.AreaName;
    societyName = widget.SocietyName;


    cityID = widget.Cityid;
    areaID = widget.Areaid;
    societyID = widget.SocietyID;

    print("Check Address Update cityName = = ="+cityName.toString());
    print("Check Address Update areaName = = ="+areaName.toString());
    print("Check Address Update societyName = = ="+societyName.toString());

    print("Check Address Update cityID = = ="+cityID.toString());
    print("Check Address Update areaID = = ="+areaID.toString());
    print("Check Address Update societyID = = ="+societyID.toString());


  }

  _runapi() async {
    String objText = '{"cdblock": "change_address", "city": "' +
        cityID +
        '", "user_id": "' +
        UserID +
        '", "area": "' +
        areaID +
        '", "society": "' +
        societyID +
        '", "tower": "' +
        Tower +
        '", "floor_id": "' +
        Floor +
        '", "flat": "' +
        Flat +'"}';
    var url = baseUrl + "?req=" + objText;



    print("Check Address Update = = ="+url.toString());

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("Check Address Update = = ="+values.toString());
        var data = json.decode(response.body);
        var rest = data["response"] as List;


        print("Check Address Update rest = = ="+rest.toString());
        // List<Texts> tagObjs =
        // rest.map((tagJson) => Texts.fromJson(tagJson)).toList();
        //
        // print("Check Address Update address = = ="+tagObjs[0].address.toString());
        String Address =  "Flat: "+Flat+", " +" Floor: "+Floor+", " +" Tower: "+Tower+", "+societyName +", "+areaName+ ", "+cityName;
        setState(() {
          _progress = false;
        });

        addStringToSF(Address);
        print("Check Address Update Address = = ="+Address);


      });
    });




  }
  addStringToSF(address) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('address', address);


    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeOrderAccount()),
    );







  }
  void doAddition() {
    setState(() {
      Tower = _towerController.text;
      Floor = _floorController.text;
      Flat = _flatController.text;

      _runapi();
    });
  }

  String Button = "Submit";

  @override
  void dispose() {
    _towerController.dispose();
    _floorController.dispose();
    _flatController.dispose();

    super.dispose();
  }

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

                      ),
                    ],
                  ),





                ],
              ),
            ),
            new Positioned(child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: Image.asset(
                "images/logos/loginbackimgone.png", //delivoo logo
//                height: 100.0,
                width: double.infinity,
              ),
            )),

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

                  BottomBar(
                    text: Button,
                    onTap: () {
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
                        setState(() {
                          _progress = true;
                        });
                        Button = "Please Wait";
                        doAddition();
                      }
                    },
                  ),

                ],),











                // RaisedButton(
                //   onPressed: () {
                //
                //     if (_towerController.text.length == 0) {
                //       Toast.show("Please enter you tower...", context,
                //           duration: Toast.LENGTH_SHORT,
                //           gravity: Toast.BOTTOM);
                //     } else if (_floorController.text.length == 0) {
                //       Toast.show("Please enter your floor no..", context,
                //           duration: Toast.LENGTH_SHORT,
                //           gravity: Toast.BOTTOM);
                //     }  else if (_flatController.text.length == 0) {
                //       Toast.show("Please enter your flat no..", context,
                //           duration: Toast.LENGTH_SHORT,
                //           gravity: Toast.BOTTOM);
                //     } else {
                //       Button = "Please Wait";
                //       doAddition();
                //     }
                //
                //   },
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //     ),
                //   ),
                //   color: btncolor,
                //   child: Text(
                //     Button,
                //     style: TextStyle(
                //       color: color,
                //       fontSize: 15,
                //     ),
                //   ),
                // ),
              ),

            ),)
          ],
        ),
      ),

    );
  }
}
