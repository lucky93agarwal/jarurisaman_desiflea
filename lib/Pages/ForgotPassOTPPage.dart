

import 'dart:async';

import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/forgotpassword.dart';
import 'package:delivoo/Pages/reset_password.dart';
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


class ForgotPassOTPPage extends StatefulWidget {
  final String mobiles;
  ForgotPassOTPPage({this.mobiles});
  @override
  _ForgotPassOTPPageState createState() => _ForgotPassOTPPageState();
}

class _ForgotPassOTPPageState extends State<ForgotPassOTPPage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _controller = TextEditingController();


  // VerificationBloc _verificationBloc;
  bool isDialogShowing = false;
  int _counter = 60;
  Timer _timer;

  _startTimer() {
    //shows timer
    _counter = 60; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }
  String MoibleNo;

  void queryall() async {

    verifyPhone();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MoibleNo = widget.mobiles;

    _startTimer();
    queryall();
  }
  String verificationId;
  String smsOTP;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
      (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();

      // doAddition();
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> verifyPhone() async {
//    Toast.show("Mobile = 1", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
//      smsOTPDialog(context).then((value) {
//        print('sign in');
//      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + MoibleNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            Toast.show("verId = " + verId, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
//        smsOTPDialog(context).then((value) {
//          print('sign in = ' + error.code + ' message  =  ' + error.message);
//        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  Future<void> verifyPhoneNumber() async {
    //verify phone number method using otp
//    Toast.show("Mobile 1 = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//    SharedPreferences myPrefs = await SharedPreferences.getInstance();
//    String mobile = myPrefs.getString('mobile');
//    print("Mobilexxx = "+mobile);

    _startTimer();
    verifyPhone();
    //int resendToken;
    //_verificationBloc = BlocProvider.of<VerificationBloc>(context);
//    FirebaseAuth.instance.verifyPhoneNumber(
//      phoneNumber: widget.phoneNumber,
//      timeout: Duration(seconds: 5),
//      verificationCompleted: (AuthCredential authCredential) =>
//          _verificationBloc.add(VerificationSuccessEvent(
//              authCredential, widget.name, widget.email)),
//
//      //This callback would gets called when verification is done automatically
//      verificationFailed: (AuthException authException) =>
//          _verificationBloc.add(VerificationFailureEvent(authException)),
//      codeSent: (String verId, [int forceCodeResend]) {
//        resendToken = forceCodeResend;
//        _verificationBloc.add(PhoneCodeSentEvent(verId));
//      },
//      codeAutoRetrievalTimeout: (String verId) =>
//          _verificationBloc.add(CodeAutoRetrievalTimeoutEvent(verId)),
//      forceResendingToken: resendToken,
//    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
  bool _progress = false;

  void ClickBottom(){
    if (_controller.text.length != 0) {
      if (_controller.text.length == 6) {
        this.smsOTP = _controller.text;
//                    widget.onVerificationDone();
        _auth.currentUser().then((user) {
          setState(() {
            _progress = true;
          });
          if (user != null) {

            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPasswrod(mobiles: MoibleNo)));

          } else {
            signIn();
          }
        });
      } else {
        Toast.show("PLease Enter Valid OTP ", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      Toast.show("PLease Enter Valid OTP ", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Verification',
          style: TextStyle(fontSize: 16.7),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Divider(
            color: kCardBackgroundColor,
            thickness: 8.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Enter verification code we've sent on given number.",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 22, color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 20.0),
            child: EntryField(
              controller: _controller,
              readOnly: false,
              label: 'ENTER VERIFICATION CODE',
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  '$_counter sec',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(side: BorderSide.none),
                  padding: EdgeInsets.all(24.0),
                  disabledTextColor: kDisabledColor,
                  textColor: kMainColor,
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 16.7,
                    ),
                  ),
                  onPressed: _counter < 1
                      ? () {
                    verifyPhoneNumber();
                  }
                      : null),
            ],
          ),
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
              text: "Continue",
              onTap: () {
                ClickBottom();
                ClickBottom();
                ClickBottom();

//                  _verificationBloc.add(SubmittedEvent(
//                      _controller.text, widget.name, widget.email));
              }),
        ],
      ),
    );
  }
}
