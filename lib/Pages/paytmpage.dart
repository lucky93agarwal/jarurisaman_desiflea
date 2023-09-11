import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutterpaytm/flutterpaytm.dart';
import 'package:http/http.dart';
import 'package:paytm/paytm.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PaytmPageActivity extends StatefulWidget {
  @override
  _PaytmPageActivityState createState() => _PaytmPageActivityState();
}

class _PaytmPageActivityState extends State<PaytmPageActivity> {
  // FlutterPaytm paytm = FlutterPaytm();
  String payment_response = null;
  void generateTxnToken(int mode) async {

    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = 'https://securegw-stage.paytm.in' +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": mid,
      "key_secret": "J!mU6Zsc9D0pvnp7",
      "website": website,
      "orderId": orderId,
      "amount": "21.0",
      "callbackUrl": callBackUrl,
      "custId": "125",
      "mode": mode.toString(),
      "testing":  "0"
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
          mid, orderId, txnToken, "1.0", callBackUrl, true);

      paytmResponse.then((value) {
        print(value);
        setState(() {

          payment_response = value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }
  Map<dynamic, dynamic> response;
  String checksumURL = "Your Checksum generator URL Here";
  String mid = "nBsDVx13367243282783";
  String verificationURL = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=";
  String CALLBACK = "https://desiflea.com/payment_callback.php";
  String industryType = "Retail";
  String website = "WEBSTAGING";
  bool isTesting = true;
  String customerIDnew="15";
  String amountnew="200.00";
  String orderIDnew="15";

  // Future<void> doPayment() async {
  //   print("LuckyYUYU Response :" +  "  orderIDnew = "+ orderIDnew);
  //   print("LuckyYUYU Response :" +  "  customerIDnew = "+customerIDnew);
  //   print("LuckyYUYU Response :" + "  amountnew = "+amountnew);
  //   Map<dynamic, dynamic> res;
  //   String orderID = "15";
  //   String customerID = customerIDnew;
  //   String amount = amountnew;
  //   try {
  //     res = await paytm.startPayment(
  //         orderId: orderID, customerId: customerID, amount: amount);
  //   } on PlatformException {
  //     res['error'] = true;
  //     res['result'] = "PLATFORM EXCEPTION";
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     response = res;
  //   });
  // }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    String payment_response = null;



    void generateCheckSum() async {
     var url = 'https://us-central1-mrdishant-4819c.cloudfunctions.net/generateCheckSum';

      String orderId = DateTime.now().millisecondsSinceEpoch.toString();
      orderIDnew = orderId;

      final response = await http.post(url, headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      }, body: {
        "mid": "nBsDVx13367243282783",
        "CHANNEL_ID": "WAP",
        'INDUSTRY_TYPE_ID': 'Retail',
        'WEBSITE': "WEBSTAGING",
        'PAYTM_MERCHANT_KEY': 'J!mU6Zsc9D0pvnp7',
        'TXN_AMOUNT': "1.00",
        'ORDER_ID': "ORDERID_002",
        'CUST_ID': "CUST_002",
      });

      checksumURL = response.body;
      print("LuckyYUYU Response :" + response.body);

      var paytmResponse = Paytm.payWithPaytm(
          "nBsDVx13367243282783",
          "ORDERID_002",
          checksumURL,
          "1.00",
          verificationURL,
          false);

      paytmResponse.then((value) {
        setState(() {

        });
        print(value);
      });




    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paytm example app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


          RaisedButton(
            onPressed: () {

              // generateCheckSum();
              generateTxnToken(1);
            },
            color: Colors.blue,
            child: Text(
              "Pay Now",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

}
