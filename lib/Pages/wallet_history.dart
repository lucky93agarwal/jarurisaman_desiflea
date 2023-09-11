import 'package:delivoo/HomeOrderAccount/Home/UI/home.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/add_money.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


import 'package:delivoo/Pages/wallet_history.dart';
class WalletHistoryActivity extends StatefulWidget {
  @override
  _WalletHistoryActivityState createState() => _WalletHistoryActivityState();
}

class Balance {
  final String cur_balance;
  final String result;

  Balance(this.cur_balance,this.result);

  Balance.fromJson(Map<String, dynamic> json)
      : cur_balance = json['cur_balance'],
        result = json['result'];

  Map<String, dynamic> toJson() => {
        'cur_balance': cur_balance,
    'result': result,
      };
}

class WalletHistory {
  final String cur_balance;
  final String debit;
  final String credit;
  final String discription;
  final String transaction_type;
  final String date;
  final String result;

  WalletHistory(this.cur_balance, this.debit, this.credit, this.discription,
      this.transaction_type, this.date, this.result);

  WalletHistory.fromJson(Map<String, dynamic> json)
      : cur_balance = json['cur_balance'],
        debit = json['debit'],
        credit = json['credit'],
        discription = json['discription'],
        transaction_type = json['transaction_type'],
        date = json['date'],
        result = json['result'];

  Map<String, dynamic> toJson() => {
        'cur_balance': discription,
        'debit': debit,
        'credit': credit,
        'discription': discription,
        'transaction_type': transaction_type,
        'date': date,
        'result': result,
      };
}

var wallet = new List<WalletHistory>();
var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

class _WalletHistoryActivityState extends State<WalletHistoryActivity> {
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

        if(tagObjs[0].result == "No data get"){
          setState(() {
            print("url 9345 = " + "wallet[0].cur_balance");
            checkdatafound = true;
          });
        }else {
          addStringToSF(tagObjs[0].cur_balance);
          setState(() {
            _runapi_History();
          });
        }

      });
    });
  }
//  final DateFormat formatter = DateFormat('dd-MMM-yyyy');

  _runapi_History() async {
    print("UserID 2 = " + UserID);
    String objText = '{"cdblock": "wallet_history", "cust_id": ' + UserID + '}';
    var url = baseUrl + "?req=" + objText;
    print("url = " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("url 92 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("url 93 = " + rest.toString());

        wallet =
            rest.map((tagJson) => WalletHistory.fromJson(tagJson)).toList();
        print("url 933 = " + wallet[0].cur_balance);

        if(wallet[0].result == "No data get"){
          setState(() {
            print("url 9345 = " + "wallet[0].cur_balance");
            checkdatafound = true;
          });
        }




//        addStringToSF(tagObjs[0].cur_balance);
      });
    });
  }

  String TotalWallet = "0";
  String UserID;

  @override
  void initState() {

    super.initState();
    getUserID();
  }

  Column _buildItemsForListView(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Card(child:  Container(
          height: 50,
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: wallet[index].transaction_type == "Online Recharge"
                      ?
                  Image.asset(
                    "images/icons/arrowdown.png", //delivoo logo
                    height: 18,
                  )
                      :
                  (
                      wallet[index].transaction_type == "Welcome Offer"
                          ?
                  Image.asset(
                    "images/icons/arrowdown.png", //delivoo logo
                    height: 18,
                  )
                      :
                      (wallet[index].transaction_type == "Credit note"
                          ?
                      Image.asset(
                        "images/icons/arrowdown.png", //delivoo logo
                        height: 18,
                      )
                          :
                      (wallet[index].transaction_type == "Referral Bonus"
                          ?
                      Image.asset(
                        "images/icons/arrowdown.png", //delivoo logo
                        height: 18,
                      )
                          :
                      Image.asset(
                        "images/icons/arrowup.png", //delivoo logo
                        height: 18,
                      )
                      )
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 60,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child:
                          Text(
                            wallet[index].transaction_type,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            wallet[index].date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Color(0xff888888)),
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 30,
                  child: Text(wallet[index].credit == "0.00"?
                  "₹" +wallet[index].debit:"₹" +wallet[index].credit,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff7ac920)),
                  )),
            ],
          ),
        ),),

      ],
    );
  }
  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeOrderAccount()),
    );
  }
  bool checkdatafound = false;
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xff7AC920);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xff595d91);
    const walletcolor = const Color(0xffacacac);
    return new WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
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
                              builder: (context) => HomeOrderAccount()),
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
              flex: 2, // 60%
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                color: btncolor,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        alignment: Alignment.topLeft,
                        child: new Text(
                          "DesiFlea Wallet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Your current balance",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              TotalWallet.length == 0 ? "₹" +"0" : "₹" +TotalWallet,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6, // 60%
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 15,
                    child: SizedBox(
                      width: double.infinity,
                      height: 100.0,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddMoneyActivity()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(),
                          ),
                          color: backgroundcolor,
                          child: Text(
                            "Add Money",
                            style: TextStyle(
                              color: color,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 85,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Wallet History",
                          style: TextStyle(color: walletcolor, fontSize: 15),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 1, 5),
                          height: MediaQuery.of(context).size.height-404,
                          alignment: Alignment.topLeft,
                          child: checkdatafound?
                          new Center(child: Image.asset(
                            'images/logos/nowalletfound.png',
                            height: 300,
                            width: 300,
                          ),)


                              :Stack(
                            children: <Widget>[
                              ListView.builder(
                                  padding: EdgeInsets.only(top: 10),
                                  itemCount: wallet.length,
                                  itemBuilder: _buildItemsForListView)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );




















  }
}
