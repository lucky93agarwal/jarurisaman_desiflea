import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Pages/wallet_history.dart';
import 'package:delivoo/Pages/add_payment_money.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:delivoo/Models/RazorpayScreen.dart';
import 'package:toast/toast.dart';

class AddMoneyActivity extends StatefulWidget {
  @override
  _AddMoneyActivityState createState() => _AddMoneyActivityState();
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
class _AddMoneyActivityState extends State<AddMoneyActivity> {
  final TextEditingController _moenyController = TextEditingController();
  String AddPrice = "1000";

  @override
  void dispose() {
    _moenyController.dispose();

    super.dispose();
  }

  String TotalWallet = "0";
  String UserID;

  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    print("UserID = " + UserID);
    setState(() {
      _runapi();
    });
  }

  addStringToSF(String cur_balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Wallet', cur_balance);

    print("Wallet = " + prefs.getString('Wallet'));

    setState(() {
      TotalWallet = prefs.getString('Wallet');
    });
  }

  _runapi() async {
    print("UserID 2 = " + UserID);
    String objText =
        '{"cdblock": "wallet_totalprice", "cust_id": ' + UserID + '}';
    var url = baseUrl + "?req=" + objText;
    print("url = " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("url2 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("url3 = " + rest.toString());

        List<Balance> tagObjs =
            rest.map((tagJson) => Balance.fromJson(tagJson)).toList();
        addStringToSF(tagObjs[0].cur_balance);
      });
    });
  }

  String TotalPrice;
  String Username;
  String Description;
  String Mobile;
  String Userid;
  String Transectionid;
  String Email;
  int TPrice = 0;
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

  void sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      TotalPrice = _moenyController.text;
      print("Lucky price TotalPrice = " + TotalPrice);
      prefs.setString('totalamount', TotalPrice);

      firstqueryall();
    });
  }
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

    _runapiss();

    // Navigator.popAndPushNamed(context, PageRoutes.homePage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Toast.show("ERROR: " + response.code.toString() + " - " + response.message,
        context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);


//    Fluttertoast.showToast(
//        msg: "ERROR: " + response.code.toString() + " - " + response.message,
//        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Toast.show("EXTERNAL_WALLET: " + response.walletName, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

//    Fluttertoast.showToast(
//        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  _runapiss() async {
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
        addStringToSFss(tagObjs[0].balance);

        print("Wallet Razorpay == " + tagObjs[0].balance);
      });
    });
  }

  addStringToSFss(String cur_balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Wallet', cur_balance);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WalletHistoryActivity()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _moenyController.text = '1000';
  }
  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WalletHistoryActivity()),
    );
  }
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xfff2f2f2);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xff595d91);
    const walletcolor = const Color(0xffacacac);
    const buttoncolor = const Color(0xff7ac920);

    return new WillPopScope(
      onWillPop: _onWillPop,









      child: new Scaffold(
        backgroundColor: backgroundcolor,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 50.0, left: 10),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletHistoryActivity()),
                        );
                      },
                      child: Image.asset(
                        "images/logos/iconsleft.png", //delivoo logo
                        height: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0, left: 10),
                    child: new InkWell(
                      onTap: () {},
                      child: Text(
                        "Wallet",
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 9,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      height: 45,
                      color: btncolor,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                "Your balance",
                                style: TextStyle(fontSize: 11, color: black),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                TotalWallet.length == 0
                                    ? "₹" + "0"
                                    : "₹" + TotalWallet,
                                style: TextStyle(fontSize: 18, color: black),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 400,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            height: 30,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Top_up your account",
                              style: TextStyle(fontSize: 11, color: black),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 60,
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 01,
                                    child: Text(
                                      "₹",
                                      style:
                                      TextStyle(fontSize: 15, color: black),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 39,
                                    child: EntryField(
                                      controller: _moenyController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 60,
                                    child: SizedBox(),
                                  ),
                                ],
                              )),
                          Container(height: 36,child: Row(

                            children: <Widget>[
                              Expanded(
                                flex: 25,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      AddPrice = '250';
                                      _moenyController.text = '250';
                                    });
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    margin:
                                    const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    color: btncolor,
                                    child: Text(
                                      "₹ 250",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 25,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      AddPrice = '500';
                                      _moenyController.text = '500';
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    margin:
                                    const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    color: btncolor,
                                    child: Text(
                                      "₹ 500",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 25,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      AddPrice = '1000';
                                      _moenyController.text = '1000';
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    margin:
                                    const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    color: btncolor,
                                    child: Text(
                                      "₹ 1000",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 25,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      AddPrice = '3000';
                                      _moenyController.text = '3000';
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    margin:
                                    const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    color: btncolor,
                                    child: Text(
                                      "₹ 3000",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),),

                          Container(
                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                            child: RaisedButton(
                              onPressed: () {
                                TotalPrice = _moenyController.text;
                                print("wallet price = " + TotalPrice);

                                FocusScope.of(context).requestFocus(new FocusNode());
                                // if(int.parse(TotalPrice) >249){
                                if(int.parse(TotalPrice) >0){
                                  // sendData();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Add_Payment_Money(Amount: TotalPrice)),
                                  );
                                }else {
                                  Toast.show("*NOTE:- Add a minimum amount of Rs 250.", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }


                              },
                              color: buttoncolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(),
                              ),
                              child: Text(
                                "Add Money",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );










  }
}
