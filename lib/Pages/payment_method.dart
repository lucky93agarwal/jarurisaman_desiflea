import 'package:delivoo/Components/list_tile.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:delivoo/Models/ItemListinCart.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}


class _PaymentPageState extends State<PaymentPage> {
  String payment_response = '';
  bool loading = false;


  String Address;
  String Street;
  String Pincode;
  String City;
  String State;

  String Userid;
  String Mobile;
  String Email;
  String Name;
  String TotalPrice = "";
  final dbhandler = DbStudentMamager.instance;
  var subCategory = new List<ItemListinCart>();

  void firstqueryallnew() async {
    print("Total amount 3 = ");
    var price = await dbhandler.firsttotalprice();
    print("Total amount 2 = "+price);
    setState(() {
      TotalPrice = price.toString();
    });

    print("Total amount = "+TotalPrice);
  }
  void insertdata() async {
    var rowall = await dbhandler.queryalladdress();

    rowall.forEach((row) {

      var _list = row.values.toList();
      Userid = _list[0].toString();
      Email = _list[1].toString();
      Mobile = _list[2].toString();
      Name = _list[3].toString();

      Address = _list[4].toString();
      City = _list[5].toString();
      State = _list[6].toString();
      Pincode = _list[7].toString();
      Street = _list[8].toString();


    });


    var createDoc = <String, Object>{};
    var createDocsss = <String, Object>{};

    var rowalls = await dbhandler.firstqueryall();
    List<String> fixedLengthList = new List(rowalls.length);
    rowalls.forEach((row) {
      print(row);

//      fixedLengthList.add(row.toString());
      var _list = row.values.toList();



      String ProductId = _list[2].toString();
      createDoc['ProductId'] = ProductId;



      String Qty = _list[5].toString();
      createDoc['Qty'] = Qty;

      createDocsss['products '+_list[0].toString()]= createDoc;

    });




    var price = await dbhandler.firsttotalprice();

    TotalPrice = price.toString();
    print("subCategory = "+createDocsss.toString());
    print("UserID = "+Userid);
    print("Email = "+Email);
    print("Mobile = "+Mobile);
    print("Name = "+Name);

    print("Address = "+Address);
    print("City = "+City);
    print("State = "+State);
    print("Pincode = "+Pincode);
    print("Street = "+Street);

    print("TotalPrice = "+TotalPrice);





    var baseUrl = "http://supergrofer.com/demo/api/supergroferAPI.php?p=";
    var url = baseUrl + "Address&address=" + Address + "&street=" + Street +"&pincode=" + Pincode + "&city=" + City + "&state=" + State + "&userid=" + Userid+ "&name=" + Name + "&mobile=" + Mobile+"&oder="+createDocsss.toString();

    http.get(url).then((response) {
      setState(() async {
        Iterable list = json.decode(response.body);
        Navigator.popAndPushNamed(context, PageRoutes.orderPlaced);
      });
    });



  }
  @override
  void initState() {
    super.initState();

    firstqueryallnew();

  }



  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Payment Method',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kMainTextColor),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Amount to Pay \₹'+ TotalPrice,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: kDisabledColor),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//            color: kCardBackgroundColor,
//            child: Text('CARDS',
//                style: Theme
//                    .of(context)
//                    .textTheme
//                    .caption
//                    .copyWith(
//                    color: kDisabledColor,
//                    fontWeight: FontWeight.bold,
//                    letterSpacing: 0.67)),
//          ),
//          BuildListTile(
//            image: 'images/payment/payment_card.png',
//            text: 'Credit Card',
//          ),
//          BuildListTile(
//            image: 'images/payment/payment_card.png',
//            text: 'Debit Card',
//          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: kCardBackgroundColor,
            child: Text(
              'CASH',
              style: Theme
                  .of(context)
                  .textTheme
                  .caption
                  .copyWith(
                  color: kDisabledColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.67),
            ),
          ),
          BuildListTile(
            image: 'images/payment/payment_cod.png',
            text: 'Cash on Delivery',
            onTap: () =>
    insertdata(),

          ),
//          Container(
//            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//            color: kCardBackgroundColor,
//            child: Text(
//              'OTHER',
//              style: Theme
//                  .of(context)
//                  .textTheme
//                  .caption
//                  .copyWith(
//                  color: kDisabledColor,
//                  fontWeight: FontWeight.bold,
//                  letterSpacing: 0.67),
//            ),
//          ),

//          BuildListTile(
//            image: 'images/payment/paytm.png',
//            text: 'Paytm',
//            onTap: () {
////              Navigator.popAndPushNamed(
////                  context, PageRoutes.paymentMethodsss);
////              generateCheckSum();
////              generateTxnToken(2);
//            },
//          ),
//          BuildListTile(
//            image: 'images/payment/payment_payu.png',
//            text: 'Rrazorpay',
//            onTap: (){
//              Navigator.popAndPushNamed(context, PageRoutes.razorpayMethodss);
//            },
//          ),
          Expanded(
            child: Container(
              color: kCardBackgroundColor,
            ),
          )
        ],
      ),
    );
  }




//  void generateTxnToken(int mode) async {
//    setState(() {
//      loading = true;
//    });
//    String orderId = DateTime.now().millisecondsSinceEpoch.toString();
//
//    String callBackUrl =
//        'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=' + orderId;
//
//    var url =
//        'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken' +
//            "?mid=" +
//            "CzhfJl80935025168369" +
//            "&key_secret=" +
//            "!Eu3euJJ8YH5gkM5" +
//            "&website=" +
//            "WEBSTAGING" +
//            "&orderId=" +
//            orderId +
//            "&amount=" +
//            "51" +
//            "&callbackUrl=" +
//            callBackUrl +
//            "&custId=" +
//            "122" +
//            "&mode=" +
//            mode.toString();
//
//    final response = await http.get(url);
//
//    print("Response is");
//    print(response.body);
//    String txnToken = response.body;
//    setState(() {
//      payment_response = txnToken;
//    });
//
//    var paytmResponse = Paytm.payWithPaytm(
//      "CzhfJl80935025168369",
//      orderId,
//      txnToken,
//      "10",
//      callBackUrl,
//    );
//
//    paytmResponse.then((value) {
//      print(value);
//      setState(() {
//        loading = false;
//        payment_response = value.toString();
//      });
//    });
//  }
//}


//  void generateCheckSum() async {
//    var url = 'https://us-central1-mrdishant-4819c.cloudfunctions.net/generateCheckSum';
//
//    String orderId = DateTime
//        .now()
//        .millisecondsSinceEpoch
//        .toString();
//
//    //Please use your parameters here
//    //CHANNEL_ID etc provided to you by paytm
//
//    final response = await http.post(url, headers: {
//      "Content-Type": "application/x-www-form-urlencoded"
//    }, body: {
//      "mid": "CzhfJl80935025168369",
//      "CHANNEL_ID": "WEB",
//      'INDUSTRY_TYPE_ID': 'Retail',
//      'WEBSITE': 'APPSTAGING',
//      'PAYTM_MERCHANT_KEY': '!Eu3euJJ8YH5gkM5',
//      'TXN_AMOUNT': '10',
//      'ORDER_ID': orderId,
//      'CUST_ID': '122',});
//
//    //for Testing(Stagging) use this
//
//    //https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=
//
//    //https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=
//
//    String callBackUrl = 'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=' +
//        orderId;
//    String txnToken = response.body;
//    print("Response :" + response.body);
//
//    print("statusCode :" + response.statusCode.toString());
//
//    //Parameters are like as per given below
//
//    // Testing (Staging or Production) if true then Stagginh else Production
//    // MID provided by paytm
//    // ORDERID your system generated order id
//    // CUSTOMER ID
//    // CHANNEL_ID provided by paytm
//    // AMOUNT
//    // WEBSITE provided by paytm
//    // CallbackURL (As used above)
//    // INDUSTRY_TYPE_ID provided by paytm
//    // checksum generated now
//
//    //Testing Credentials
//    //Mobile number: 7777777777
//    //OTP: 489871
//
//    var paytmResponse = Paytm.startPaytmPayment(
//        false,
//        "ParloS79006455919746",
//        orderId,
//        "122",
//        "WAP",
//        "10",
//        'APPSTAGING',
//        callBackUrl,
//        'Retail',
//        response.body);
//
//    paytmResponse.then((value) {
//      setState(() {
//        payment_response = value.toString();
//      });
//    });
//  }
}




