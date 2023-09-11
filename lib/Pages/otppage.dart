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
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class OTPActivity extends StatefulWidget {
  @override
  _OTPActivityState createState() => _OTPActivityState();
}
class Texts {
  final String result;
  final String id;


  Texts(this.result, this.id,);

  Texts.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'result': result,
    'id': id,
  };
}
class _OTPActivityState extends State<OTPActivity> {

  Future handleDynamicLinks() async {
    // STARTUP FROM DYNAMIC LINK LOGIC
    // Get initial dynamic link if the app is started using the link
    // प्रारंभिक डायनामिक लिंक प्राप्त करें यदि ऐप को लिंक का उपयोग करके शुरू किया गया है
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    // INTO FOREGROUND FROM DYDNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
          _handleDeepLink(dynamicLinkData);
        },

        onError: (OnLinkErrorException e) async {
          print('Dynamic Link Failed: ${e.message}');
        }
    );


  }



  void _handleDeepLink(PendingDynamicLinkData data){
    final Uri deepLink = data?.link;
    if(deepLink != null){
      print('_handleDeepLink | deepLink: $deepLink');
    }
  }
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

  String ID;
  String MoibleNo;
  String UserName;
  String Email;
  String Password;

  String City;
  String Area;
  String Society;
  String Tower;
  String Flat;
  String Flor;
  final dbhandler = DbStudentMamager.instance;

  void queryall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserName = prefs.getString('name');
    MoibleNo = prefs.getString('mobile');
    Email = prefs.getString('email');
    Password = prefs.getString('pass');

    City = prefs.getString('city');
    Area = prefs.getString('area');
    Society = prefs.getString('society');
    Tower = prefs.getString('tower');

    Flat = prefs.getString('flat');
    Flor = prefs.getString('floor');
    referal = prefs.getString('referal');

    print("name = " + UserName);
    print("mobile = " + MoibleNo);
    print("pass = " + Password);
    print("email = " + Email);

    print("City = " + City);
    print("Area = " + Area);
    print("Society = " + Society);
    print("Tower = " + Tower);

    print("Flat = " + Flat);
    print("Flor = " + Flor);
    verifyPhone();
  }

  String Message, referal;
  var error = new List<Error>();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
  addStringToSF(String mobile,String email, String id,String name,String address,String city ) async {
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
  String device_token ="";

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

            doAddition();

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
  void doAddition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      print("Home OTP page url = " );
      String address ="Flat: "+Flat+", " +" Floor: "+Flor+", " +" Tower: "+Tower+", "+Society +", "+Area+ ", "+City;
      String objText = '{"cdblock": "New_Signup", "mobile": "' +
          MoibleNo +
          '","name": "' +
          UserName +
          '","email": "' +
          Email +
          '","password": "' +
          Password +
          '","device_token": "' +
          device_token +
          '","city": "' +
          City +
          '", "address": "' +
          address +
          '", "riferalID": "'+
          prefs.getString('referal') +'"}';
      var url = baseUrl + "?req=" + objText;
      print("Home OTP page url = " + url);

      http.get(url).then((response) {
        setState(() {
          var values = response.body;
          print("Home OTP page Response url2 = " + values);

          var data = json.decode(response.body);
          var rest = data["response"] as List;

          print("Home OTP page Response as List url3 = " + rest.toString());

          List<Texts> tagObjs = rest.map((tagJson) => Texts.fromJson(tagJson)).toList();

          if(tagObjs[0].result =="SignUp Success"){
            addStringToSF(MoibleNo,Email, tagObjs[0].id,UserName,address,City);
          }else  if(tagObjs[0].result =="Customer already exist"){
            print("getresponse result 776 = ");

            Toast.show("Mobile number not registered", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
          }

//          List<Texts> tagObjs = rest.map((tagJson) => Texts.fromJson(tagJson)).toList();
//
//
//          addStringToSF(tagObjs[0].mobile,tagObjs[0].email, tagObjs[0].id,tagObjs[0].name,tagObjs[0].address,tagObjs[0].city);
        });
      });


//      http.get(url).then((response) {
//        setState(() async {
//          Iterable list = json.decode(response.body);
//          error = list.map((model) => Error.fromJson(model)).toList();
////          Toast.show("UserInfo Length = " + error.length.toString(), context,
////              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//
//          if (error.length > 0) {
//            print("Mobile No  2 = " + error.length.toString());
//            for (int i = 0; i < error.length; i++) {
//              Message = error[0].error;
//              print("Message No  2 = " + Message);
//              if (Message == "Success") {
//                print("Message No  2 Success = " + Message);
////                widget.onVerificationDone();
//                Toast.show("Registration Success.....", context,
//                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//              } else if (Message == "Already Exists.") {
////                widget.onVerificationDone();
//                Toast.show("Already Exists......", context,
//                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//              } else {
////                widget.onVerificationDone();
//                Toast.show("Already Exists......", context,
//                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//              }
//            }
//          } else {
//            print("Message No  2 Success = " + Message);
//            Toast.show("Please enter correct credentials.....", context,
//                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//          }
//        });
//      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    _firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> event) {},
        onMessage: (Map<String, dynamic> event) {},
        onResume: (Map<String, dynamic> event) {}
    );

    handleDynamicLinks();

    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true
    ));
    _firebaseMessaging.getToken().then((String msg){
      device_token = msg;
      print("Firebase Token = "+msg);
    });
//    Toast.show("Mobile 0 = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//    SharedPreferences myPrefs = await SharedPreferences.getInstance();
//    String mobile = myPrefs.getString('mobile');

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

      doAddition();
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
