import 'package:delivoo/Auth/Verification/UI/verification_page.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Pages/otppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpActivity extends StatefulWidget {
  @override
  _SignUpActivityState createState() => _SignUpActivityState();
}

class CheckMoible {
  final String error;

  CheckMoible(this.error);

  CheckMoible.fromJson(Map<String, dynamic> json) : error = json['error'];

  Map<String, dynamic> toJson() => {
        'error': error,
      };
}

class CheckEmail {
  final String error;

  CheckEmail(this.error);

  CheckEmail.fromJson(Map<String, dynamic> json) : error = json['error'];

  Map<String, dynamic> toJson() => {
        'error': error,
      };
}

class _SignUpActivityState extends State<SignUpActivity> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String Name;
  String Mobile;
  String Pass;
  String Email;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  addStringToSF(String Name, String Mobile, String Pass, String Email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', Name);
    prefs.setString('mobile', Mobile);
    prefs.setString('pass', Pass);
    prefs.setString('email', Email);

    print("name = " + prefs.getString('name'));
    print("mobile = " + prefs.getString('mobile'));
    print("pass = " + prefs.getString('pass'));
    print("email = " + prefs.getString('email'));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTPActivity()),
    );
  }

  void doAddition() {
    setState(() {
      Name = _nameController.text;
      Mobile = _mobileController.text;
      Pass = _passwordController.text;
      Email = _emailController.text;

      addStringToSF(Name, Mobile, Pass, Email);
    });
  }

  String countmobile;
  String countemail;

  void searchproduct(String reset) {
    countmobile = _mobileController.text;
    if (countmobile.length >= 10) {
      _runapismobile();
    }
  }

  void searchemailproduct(String email) {
    print("reset data from server url =");
    _runapisemail();
  }

  int checknumber = 0;
  int checkemail = 0;
  int checkpassword = 0;
  bool visibilty = false;

  _runapisemail() async {
    setState(() {
      visibilty = true;
    });
    String objText =
        '{"cdblock": "CheckEmail", "email": "' + _emailController.text + '"}';
    var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
    var url = baseUrl + "?req=" + objText;
    print("reset data from server url =" + url.toString());
    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        print("getresponse = " + rest.toString());

        List<CheckEmail> tagObjs =
            rest.map((tagJson) => CheckEmail.fromJson(tagJson)).toList();

        if (tagObjs[0].error == "Customer already exist") {
          setState(() {
            checkemail = 1;
          });

          visibilty = false;
        }else {
          setState(() {
            checkemail = 0;
          });
          visibilty = false;
        }
      });
    });


  }

  _runapismobile() async {
    setState(() {
      visibilty = true;
    });
    String objText =
        '{"cdblock": "CheckMobile", "mobile": "' + countmobile + '"}';
    var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
    var url = baseUrl + "?req=" + objText;
    print("reset data from server url =" + url.toString());
    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        print("getresponse = " + rest.toString());

        List<CheckMoible> tagObjs =
            rest.map((tagJson) => CheckMoible.fromJson(tagJson)).toList();

        if (tagObjs[0].error == "Customer already exist") {
          checknumber = 1;
          visibilty = false;
        }else {
          checknumber = 0;
          visibilty = false;
        }
      });
    });
  }

  void searchpasswordproduct(String email) {
    bool checkpass = validateStructure(email);
    if (checkpass) {
      print("reset data from checkpass =  True");
      setState(() {
        checkpassword = 0;
      });

    } else {
      setState(() {
        checkpassword = 1;
      });

      print("z =  False");
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }


  String Continue ="Continue";

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
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Please Enter",
                    style: TextStyle(
                        color: black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Your Mobile Number",
                    style: TextStyle(
                        color: black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
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
                  SizedBox(
                    height: 120,
                  ),
//                  Container(
//                    margin: const EdgeInsets.only(top: 50.0, left: 10),
//                    child: new Text(
//                      "",
//                      style: TextStyle(color: black, fontSize: 18,fontWeight: FontWeight.bold),
//                    ),
//                  ),

                Container(  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Column(
                  children: <Widget>[
                    EntryField(
                      controller: _nameController,
                      label: 'Name',
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: _mobileController,
                      onChanged: searchproduct,
                      style: TextStyle(
                          color:
                          checknumber == 0 ? Colors.black : Colors.red),
                      decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        labelStyle: new TextStyle(
                            color:
                            checknumber == 0 ? Colors.black : Colors.red),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Row(children: [


                      // Expanded(flex:1,child: visibilty
                      //     ? new SpinKitThreeBounce(
                      //   itemBuilder:
                      //       (BuildContext context, int index) {
                      //     return DecoratedBox(
                      //       decoration: BoxDecoration(
                      //         color: index.isEven
                      //             ? Colors.white
                      //             : Colors.white,
                      //       ),
                      //     );
                      //   },
                      // )
                      //     : new Container())
                    ],
                    ),

                    Align(
                        alignment: Alignment.centerLeft,

                        child: Container(margin: const EdgeInsets.fromLTRB(20, 5, 0, 5),child:  Text(
                          checknumber == 0
                              ? ""
                              : "Mobile number is already registered",
                          style: TextStyle(fontSize: 8, color: Colors.red),
                          textAlign: TextAlign.left,
                        ),)

                    ),
                    TextField(
                      controller: _passwordController,
                      onChanged: searchpasswordproduct,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Row(
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //   child:

                        // ),
                        // Expanded(
                        //     flex: 1,
                        //     child: InkWell(
                        //       onTap: () {
                        //         showDialog(
                        //           context: context,
                        //           builder: (context) => new AlertDialog(
                        //             title: new Text('Password Validation'),
                        //             content: new Text(
                        //                 '1. Minimum 1 Upper case.\n 2. Minimum 1 Upper case.\n 3. Minimum 1 Numeric Number. \n4. Minimum 1 Special Character.'),
                        //           ),
                        //         );
                        //       },
                        //       child: Image.asset("images/logos/infoicon.png"),
                        //     )),
                      ],
                    ),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //
                    //     child: Container(margin: const EdgeInsets.fromLTRB(20, 5, 0, 5),child:  Text(
                    //       checkpassword == 0
                    //           ? ""
                    //           : "Please chose a strong password which contain Minimum 1 Upper case, Minimum 1 lowercase, Minimum 1 Numeric Number, Minimum 1 Special Character",
                    //       style: TextStyle(fontSize: 8, color: Colors.red),
                    //       textAlign: TextAlign.left,
                    //     ),)
                    //
                    // ),
                    TextField(
                      controller: _emailController,
                      onChanged: searchemailproduct,
                      style: TextStyle(
                          color: checkemail == 0 ? Colors.black : Colors.red),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelStyle: new TextStyle(
                            color:
                            checkemail == 0 ? Colors.black : Colors.red),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Container(margin: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                        child:  Text(
                          checkemail == 0
                              ? ""
                              : "Email is already registered",
                          style: TextStyle(fontSize: 8, color: Colors.red),
                          textAlign: TextAlign.left,
                        ),
                      ),

                    ),
                  ],
                ),),


                  SizedBox(
                    height: 130,
                  ),

                  // new Positioned(
                  //     child: new Align(
                  //   alignment: FractionalOffset.bottomCenter,
                  //   child: Image.asset(
                  //     "images/logos/loginbackimgone.png", //delivoo logo
                  //     height: 300.0,
                  //     width: double.infinity,
                  //   ),
                  // )),
                ],
              ),
            ),
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 70.0,
                  child:








                  RaisedButton(
                    onPressed: () {
                      if (_nameController.text.length == 0) {
                        Toast.show("Please enter you tower...", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      } else if (_mobileController.text.length == 0) {
                        Toast.show("Please enter your mobile..", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      } else if (_passwordController.text.length == 0) {
                        Toast.show("Please enter your password..", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      } else if (_emailController.text.length == 0) {
                        Toast.show("Please enter your email..", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      } else if (checknumber == 1) {
                        Toast.show(
                            "Mobile number is already registered.", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (checkemail == 1) {
                        Toast.show(
                            "Email number is already registered.", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      }else {
                        Continue = "Please Wait";
                        doAddition();
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(),
                    ),
                    color: btncolor,
                    child: Text(
                      Continue,
                      style: TextStyle(
                        color: color,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
