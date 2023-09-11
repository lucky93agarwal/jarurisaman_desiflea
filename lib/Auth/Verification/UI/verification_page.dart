import 'dart:async';

import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:delivoo/Models/Error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



//Verification page that sends otp to the phone number entered on phone number page
class VerificationPage extends StatelessWidget {
  final VoidCallback onVerificationDone;

  VerificationPage(this.onVerificationDone);

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
      body: OtpVerify(onVerificationDone),
    );
  }
}

//otp verification class
class OtpVerify extends StatefulWidget {
  final VoidCallback onVerificationDone;

  OtpVerify(this.onVerificationDone);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
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









  String ID;
  String MoibleNo;
  String UserName;
  String Email;
  String Password;
  final dbhandler = DbStudentMamager.instance;
  void queryall() async {
    var rowall = await dbhandler.queryall();
    rowall.forEach((row){

      print(row);
      var _list = row.values.toList();
      Email = _list[2].toString();
      MoibleNo = _list[3].toString();
      UserName = _list[4].toString();
      Password = _list[5].toString();
      print('mobile = '+_list[3].toString());
    });
    print('length = '+rowall.length.toString());
    verifyPhone();
  }
  String Message;
  var error = new List<Error>();
  void doAddition() {
    setState(() {


      print("Mobile No ");
      var baseUrl = "http://gpslab.in/jarurisaman/admin/api/index.php?p=";
      var url = baseUrl + "Register&name=" + UserName + "&mobile=" + MoibleNo+"&email="+Email+"&password="+Password;

      http.get(url).then((response) {
        setState(() async {
          Iterable list = json.decode(response.body);
          error = list.map((model) => Error.fromJson(model)).toList();
//          Toast.show("UserInfo Length = " + error.length.toString(), context,
//              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

          if(error.length >0) {
            print("Mobile No  2 = " +error.length.toString());
            for (int i = 0; i < error.length; i++) {
              Message = error[0].error;
              print("Message No  2 = " +Message);
              if(Message == "Success"){
                print("Message No  2 Success = " +Message);
                widget.onVerificationDone();
                Toast.show("Registration Success.....", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }else if(Message == "Already Exists."){
                widget.onVerificationDone();
                Toast.show("Already Exists......", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }else{
                widget.onVerificationDone();
                Toast.show("Already Exists......", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
            }

          }else {
            print("Message No  2 Success = " +Message);
            Toast.show("Please enter correct credentials.....", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        });
      });
    });
  }
  @override
  void initState() {
    super.initState();
//    Toast.show("Mobile 0 = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//    SharedPreferences myPrefs = await SharedPreferences.getInstance();
//    String mobile = myPrefs.getString('mobile');

    queryall();

  }

  String verificationId;
  String smsOTP;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

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
          phoneNumber: "+91"+MoibleNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            Toast.show("verId = " + verId, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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

//  Future<bool> smsOTPDialog(BuildContext context) {
//    return showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context) {
//          return new AlertDialog(
//            title: Text('Enter SMS Code'),
//            content: Container(
//              height: 85,
//              child: Column(children: [
//                TextField(
//                  onChanged: (value) {
//                    this.smsOTP = value;
//                  },
//                ),
//                (errorMessage != ''
//                    ? Text(
//                        errorMessage,
//                        style: TextStyle(color: Colors.red),
//                      )
//                    : Container())
//              ]),
//            ),
//            contentPadding: EdgeInsets.all(10),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Done'),
//                onPressed: () {
//                  _auth.currentUser().then((user) {
//                    if (user != null) {
////                      Navigator.of(context).pop();
//
////                      Navigator.of(context).pushReplacementNamed('/homepage');
//
//                    } else {
//                      signIn();
//                    }
//                  });
//                },
//              )
//            ],
//          );
//        });
//  }

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
      doAddition();

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
        BottomBar(
            text: "Continue",
            onTap: () {
              if(_controller.text.length !=0) {
                if(_controller.text.length ==6) {
                  this.smsOTP = _controller.text;
                  widget.onVerificationDone();
                  _auth.currentUser().then((user) {
                    if (user != null) {
//                      Navigator.of(context).pop();
                      doAddition();

//                      Navigator.of(context).pushReplacementNamed('/homepage');

                    } else {
                      signIn();
                    }
                  });
                }else{
                  Toast.show("PLease Enter Valid OTP "  , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              }else{
                Toast.show("PLease Enter Valid OTP "  , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
//                  _verificationBloc.add(SubmittedEvent(
//                      _controller.text, widget.name, widget.email));
            }),
      ],
    );
  }
}
