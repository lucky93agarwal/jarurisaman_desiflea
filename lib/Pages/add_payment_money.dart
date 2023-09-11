import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Pages/success_page.dart';
import 'package:delivoo/Pages/faile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:delivoo/Models/RazorpayScreen.dart';
import 'package:toast/toast.dart';

import 'package:flutter/services.dart';

// import 'package:flutterpaytm/flutterpaytm.dart';
import 'package:http/http.dart';
import 'package:paytm/paytm.dart';

import 'dart:async';

class Add_Payment_Money extends StatefulWidget {
  final String Amount;

  Add_Payment_Money({this.Amount});

  @override
  _Add_Payment_MoneyState createState() => _Add_Payment_MoneyState();
}

class _Add_Payment_MoneyState extends State<Add_Payment_Money> {
  String amount = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = widget.Amount;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String Username;
  String Description;
  String Mobile;
  String Userid;
  String Transectionid;
  String Email;
  Razorpay _razorpay;

  void openCheckout(
      String TotalPrice, String Email, String Mobile, String Username) async {
// Testing     rzp_test_1DP5mmOlF5G5ag

    // Live      rzp_live_JABoRha1G9nMAk
    var options = {
      'key': 'rzp_live_JABoRha1G9nMAk',
      'amount': TotalPrice,
      'name': Username,
      'description': 'DesiFlea',
      'prefill': {'contact': Mobile, 'email': Email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Toast.show("SUCCESS: " + response.paymentId, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    print("SUCCESS paymentId: " + response.paymentId);
//    print("SUCCESS : " + response.orderId);
    Transectionid = response.paymentId;
    payment_response='""';
    _runapiss();

    // Navigator.popAndPushNamed(context, PageRoutes.homePage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Toast.show("ERROR: " + response.code.toString() + " - " + response.message,
        context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Transaction_Failed_Page(message:response.message)),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Toast.show("EXTERNAL_WALLET: " + response.walletName, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

//    Fluttertoast.showToast(
//        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  String TransectionType = "";

  _runapiss() async {
    print("response = +  =Userid ==  " + Userid);
    print("response = +  =Transectionid==  " + Transectionid);
    print("response = +  =TransectionType==  " + TransectionType);
    print("response = +  =amount==  " + amount.toString());
    print("response = +  =payment_response==  " + payment_response);
    String objText = '{"cdblock": "wallet_recharge_new", "cust_id": "' +
        Userid +
        '", "transaction_id": "' +
        Transectionid +
        '", "type": "' +
        TransectionType +
        '", "rupees": "' +
        amount.toString() +
        '", "response": ' +
        payment_response +
        '}';
    var url = baseUrl + "?req=" + objText;
    print("response = +  ===  " + url);

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        print("Wallet Razorpay response == " + rest.toString());

        List<Texts> tagObjs =
            rest.map((tagJson) => Texts.fromJson(tagJson)).toList();

        if(TransectionType =="Paytm"){
          if(Statuss == "TXN_SUCCESS"){
            addStringToSFss(tagObjs[0].balance);
          }else {
            String messagenew = "Your payment has been declined by your bank. Please try again or use a different method to complete the payment.";
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Transaction_Failed_Page(message:messagenew)),
            );
          }
        }else {
          addStringToSFss(tagObjs[0].balance);
        }

        print("Wallet Razorpay == " + tagObjs[0].balance);
      });
    });
  }

  addStringToSFss(String cur_balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Wallet', cur_balance);


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Success_Page(tID:Transectionid)),
    );
  }

  void firstqueryall() async {
    print("Lucky price = ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Userid = prefs.getString("id");
    Email = prefs.getString("email");
    Mobile = prefs.getString("mobile");
    Username = prefs.getString("name");

    openCheckout(amount + '00', Email, Mobile, Username);
  }

  String mid = "WpDNND26080035687606";

  void sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print("Lucky price TotalPrice = " + amount);
      prefs.setString('totalamount', amount);

      firstqueryall();
    });
  }

  String payment_response = null;
  String Statuss;
  void generateTxnToken(int mode) async {
    setState(() {
      TransectionType = "Paytm";
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Userid = prefs.getString("id");
    Email = prefs.getString("email");
    Mobile = prefs.getString("mobile");
    Username = prefs.getString("name");
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    // testing mode
    // String callBackUrl = 'https://securegw-stage.paytm.in' +
    //     '/theia/paytmCallback?ORDER_ID=' +
    //     orderId;

    // live mode
    String callBackUrl = 'https://securegw.paytm.in' +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    // testing mode
    // var body = json.encode({
    //   "mid": "nBsDVx13367243282783",
    //   "key_secret": "J!mU6Zsc9D0pvnp7",
    //   "website": "WEBSTAGING",
    //   "orderId": orderId,
    //   "amount": amount.toString(),
    //   "callbackUrl": callBackUrl,
    //   "custId": "125",
    //   "mode": mode.toString(),
    //   "testing":  "0"
    // });
    print("Response is Userid " + Userid);
    print("Response is callBackUrl " + callBackUrl);
    // live mode

    var body = json.encode({
      "mid": "WpDNND26080035687606",
      "key_secret": "I65CsJpGqqOzyE5J",
      "website": "DEFAULT",
      "orderId": orderId,
      "amount": amount.toString(),
      "callbackUrl": callBackUrl,
      "custId": Userid,
      // "mode": mode.toString(),
      "testing": "1"
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(
          mid, orderId, txnToken, amount.toString(), callBackUrl, false);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          Transectionid = "";
          payment_response = value.toString();

          String Sec_response =
              payment_response.substring(0, payment_response.length - 32);

          payment_response = Sec_response.substring(11);
          print("LuckyAGarwal YUYTU" + value.toString());
          if(value.toString() == '{errorMessage: onBackPressedCancelTransaction, error: true}'){
            String messagenew = " onBackPressedCancelTransaction.";
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Transaction_Failed_Page(message:messagenew)),
            );
          }else {
            String Sec_responsex = payment_response.substring(0, payment_response.length - 278);

            String final_responsex = Sec_responsex.substring(220);

            Statuss = final_responsex;
            print("LuckyCodieng Status = "+final_responsex);

            String Sec_responsexw = payment_response.substring(0, payment_response.length - 396);

            String final_responsexw = Sec_responsexw.substring(78);

            print("LuckyCodieng id = "+final_responsexw);
            Transectionid = final_responsexw;
            _runapisss();
          }

        });
      });
    } catch (e) {
      print(e);
    }
  }

  bool prog = false;

  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xfff2f2f2);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xff595d91);
    const walletcolor = const Color(0xffacacac);
    const buttoncolor = const Color(0xff7ac920);
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 50, 0, 5),
            alignment: Alignment.topLeft,
            child: Text(
              "You are doing a top up of ₹" + amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            alignment: Alignment.topLeft,
            child: Text(
              "Choose a payment method",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 25.0,
                  width: 90.0,
                  child: Image(
                    image: AssetImage(""),

                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(onTap: (){
                  setState(() {
                    prog = true;
                  });
                  generateTxnToken(1);
                },child: Container(
                  height: 25.0,
                  width: 90.0,
                  child:


                  Image(
                    image: AssetImage("images/icons/paytmicon.png"),

                  ),
                ),),



              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        prog = true;
                      });
                      generateTxnToken(1);
                    },
                    child: Text(
                      "Paytm",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 2,
              //   child: Container(
              //     height: 15.0,
              //     width: 15.0,
              //     child: Image(
              //      // image: AssetImage("images/icons/righticon.png"),
              //       image: AssetImage(""),
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 25.0,
                  width: 90.0,
                  child: Image(
                    image: AssetImage(""),

                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(onTap: (){
                  setState(() {
                    prog = true;
                    TransectionType = "Razorpay";
                  });

                  sendData();
    },child: Container(
                  height: 45.0,
                  width: 90.0,
                  child: InkWell(onTap: (){
                    setState(() {
                      prog = true;
                      TransectionType = "Razorpay";
                    });

                    sendData();
                  },child:  Image(
                    image: AssetImage("images/icons/razorpay.png"),

                  ),),



                ),),



              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child:


                  InkWell(
                    onTap: () {
                      setState(() {
                        prog = true;
                        TransectionType = "Razorpay";
                      });

                      sendData();
                    },
                    child: Text(
                      "Credit Card and Debit Card (Razorpay)",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: prog
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).hintColor),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Future<void> _runapisss() async {
    print("Lucky YuYU Response is 3 " + payment_response);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Userid = prefs.getString("id");
    Email = prefs.getString("email");
    Mobile = prefs.getString("mobile");
    Username = prefs.getString("name");
    _runapiss();
  }
}
