import 'package:delivoo/Pages/reset_pass_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordStartingPage extends StatefulWidget {
  @override
  _ResetPasswordStartingPageState createState() =>
      _ResetPasswordStartingPageState();
}

class _ResetPasswordStartingPageState extends State<ResetPasswordStartingPage> {
  getmobileno() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Mobile = prefs.getString("mobile");
    });

  }
  String Mobile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


     getmobileno();
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
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0,left: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Reset Password",
                    style: TextStyle(color: black, fontSize: 25,fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 100,
                  ),

                  Center(child: Column(children: [
                    Text(
                      "We are going to send OTP on your registered mobile number",
                      style: TextStyle(color: black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Mobile,
                      style: TextStyle(color: black, fontSize: 17),
                    ),
                  ],),),





                ],
              ),

            ),
            // new Positioned(
            //   child: Column(
            //     children: <Widget>[
            //
            //       SizedBox(height: 120,),
            //
            //
            //       Column(
            //
            //         children: <Widget>[
            //
            //
            //         ],
            //       ),
            //
            //
            //
            //
            //
            //     ],
            //   ),
            // ),
            new Positioned( child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 70.0,
                child:  RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPassOTPPage()),
                    );

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                    ),
                  ),
                  color: btncolor,
                  child: Text(
                    "Send OTP",
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
