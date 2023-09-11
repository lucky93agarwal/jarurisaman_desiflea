import 'package:delivoo/Pages/paytmpage.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:delivoo/Pages/wallet_history.dart';
import 'package:delivoo/Pages/add_money.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RazorpayScreen extends StatefulWidget {
  @override
  _RazorpayScreenState createState() => _RazorpayScreenState();
}

class Texts {
  final String result;
  final String id;
  final String balance;

  Texts(this.result, this.id, this.balance);

  Texts.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        id = json['id'],
        balance = json['balance'];

  Map<String, dynamic> toJson() => {
        'result': result,
        'id': id,
        'balance': balance,
      };
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  static const platform = const MethodChannel("razorpay_flutter");
  int TPrice = 0;
  Razorpay _razorpay;
  String TotalPrice = "";
  final dbhandler = DbStudentMamager.instance;
  var rowall;
  String Username;
  String Description;
  String Mobile;
  String Userid;
  String Transectionid;
  String Email;

  void firstqueryall() async {
    print("Lucky price = ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Userid = prefs.getString("id");
    Email = prefs.getString("email");
    Mobile = prefs.getString("mobile");
    Username = prefs.getString("name");
    TPrice = int.parse(prefs.getString("totalamount"));
    TotalPrice = prefs.getString("totalamount") + '00';

    print("Lucky price = " + TPrice.toString());
    print("Lucky price TotalPrice = " + TotalPrice);
     openCheckout(TotalPrice, Email, Mobile, Username);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                )
              ],),

            ],
          ),
        ),

        // Center(
        //     child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           RaisedButton(
        //             child: Text('RazorpayScreen'),
        //             onPressed: () {
        //               openCheckout(TotalPrice,Email,Mobile,Username);
        //             },
        //           ),
        //           RaisedButton(
        //             child: Text('Paytm'),
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => PaytmPageActivity()),
        //               );
        //             },
        //           ),
        //         ])
        //
        //
        // ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firstqueryall();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(
      String TotalPrice, String Email, String Mobile, String Username) async {
//    var options = {
//      'key': 'rzp_test_1DP5mmOlF5G5ag',
//      'amount': TotalPrice,
//      'name': Username,
//      'description': 'Fine T-Shirt',
//      'prefill': {'contact': Mobile, 'email': Email},
//      'external': {
//        'wallets': ['paytm']
//      }
//    };

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': TotalPrice,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
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

    _runapi();

    // Navigator.popAndPushNamed(context, PageRoutes.homePage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Toast.show("ERROR: " + response.code.toString() + " - " + response.message,
        context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, PageRoutes.homePage);

//    Fluttertoast.showToast(
//        msg: "ERROR: " + response.code.toString() + " - " + response.message,
//        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Toast.show("EXTERNAL_WALLET: " + response.walletName, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, PageRoutes.homePage);
//    Fluttertoast.showToast(
//        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  _runapi() async {
    String objText = '{"cdblock": "wallet_recharge_new", "cust_id": "' +
        Userid +
        '", "transaction_id": "' +
        Transectionid +
        '", "rupees": "' +
        TPrice.toString() +
        '"}';
    var url = baseUrl + "?req=" + objText;
    print("response = +  ===  " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        print("Wallet Razorpay response == " + rest.toString());

        List<Texts> tagObjs =
            rest.map((tagJson) => Texts.fromJson(tagJson)).toList();
        addStringToSF(tagObjs[0].balance);

        print("Wallet Razorpay == " + tagObjs[0].balance);
      });
    });
  }

  addStringToSF(String cur_balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Wallet', cur_balance);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WalletHistoryActivity()),
    );
  }
}
