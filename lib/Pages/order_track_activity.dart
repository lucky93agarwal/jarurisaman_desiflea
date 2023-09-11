import 'dart:ui';

import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/delivery_timeline.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'add_money.dart';

class Order_Track_Activity extends StatefulWidget {
  final String created_at;
  final String invoice_num;
  final String order_code;
  final String order_status_id;

  final String total_quantity;
  final String total_amt;
  final String id;

  Order_Track_Activity({this.created_at,
    this.invoice_num,
    this.order_code,
    this.order_status_id,
    this.total_quantity,
    this.total_amt,
    this.id});

  @override
  _Order_Track_ActivityState createState() => _Order_Track_ActivityState();
}

class Citys {
  final String price;
  final String quantity;

  final String version_id;
  final String product_id;
  final String product_Name;
  final String imageURL;

  final String ver_capacity;
  final String ver_unit;
  final String ver_price;
  final String offer_price;

  Citys(this.price,
      this.quantity,
      this.version_id,
      this.product_id,
      this.product_Name,
      this.imageURL,
      this.ver_capacity,
      this.ver_unit,
      this.ver_price,
      this.offer_price);

  Citys.fromJson(Map<String, dynamic> json)
      : price = json['price'],
        quantity = json['quantity'],
        version_id = json['version_id'],
        product_id = json['product_id'],
        product_Name = json['product_Name'],
        imageURL = json['imageURL'],
        ver_capacity = json['ver_capacity'],
        ver_unit = json['ver_unit'],
        ver_price = json['ver_price'],
        offer_price = json['offer_price'];

  Map<String, dynamic> toJson() =>
      {
        'price': price,
        'quantity': quantity,
        'version_id': version_id,
        'product_id': product_id,
        'product_Name': product_Name,
        'imageURL': imageURL,
        'ver_capacity': ver_capacity,
        'ver_unit': ver_unit,
        'ver_price': ver_price,
        'offer_price': offer_price,
      };
}

var citys = new List<Citys>();
List<String> CalculatedPrice = [];

List<String> CalculatedValue = [
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0",
  "0"
];

List<int> numberofitems = [];
List<String> productid = [];

List<String> result = [];
List<String> ver_qty = [];
List<String> ver_name = [];
List<String> ver_delete = [];
List<String> ver_totalPrice = [];
List<String> ver_calculatePrice = [];

class _Order_Track_ActivityState extends State<Order_Track_Activity> {
  String Created_At;
  String Invoice_Num;
  String Order_Code;
  String Order_Status_Id;

  String Total_Quantity;
  String Total_Amt;
  String ButtonText = "TRACK ORDER";
  String Id;
  String UserID;
  String Uname = "";
  String UAddress = "";

  int totalprice = 0;

  //// get User id
  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print("Place Order UserID = ");

      UserID = prefs.getString('id');
      Uname = prefs.getString('name');
      UAddress = prefs.getString('address');

      print("Place Order UserID = " + UserID);
    });

    _runapi();
  }

  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";


  /// get History Details api
  _runapi() async {
    String objText = '{"cdblock": "order_history_details", "cust_id": ' +
        UserID +
        ', "order_id": ' +
        Id +
        '}';

    var url = baseUrl + "?req=" + objText;
    print("url = " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("cheange order url2 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        if (citys.length > 0) {
          citys.clear();
        }
        if (CalculatedPrice.length > 0) {
          CalculatedPrice.clear();
        }
        if (numberofitems.length > 0) {
          numberofitems.clear();
        }

        if (productid.length > 0) {
          productid.clear();
        }
        if (ver_name.length > 0) {
          ver_name.clear();
        }
        if (ver_qty.length > 0) {
          ver_qty.clear();
        }

        if (ver_delete.length > 0) {
          ver_delete.clear();
        }
        if (ver_totalPrice.length > 0) {
          ver_totalPrice.clear();
        }
        if (ver_calculatePrice.length > 0) {
          ver_calculatePrice.clear();
        }

        if (result.length > 0) {
          result.clear();
        }

        print("cheange order response = " + rest.toString());

        citys = rest.map((tagJson) => Citys.fromJson(tagJson)).toList();

        print("cheange order length = " + citys.length.toString());
        for (int i = 0; i < citys.length; i++) {
          totalprice = int.parse(citys[i].quantity) *
              (double.parse(citys[i].offer_price)).toInt();
          visibilityObs.add(false);

          CalculatedPrice.add(totalprice.toString());
          numberofitems.add(int.parse(citys[i].quantity));
        }
      });
    });
  }

  bool OneCheck = false;
  bool TwoCheck = false;
  bool ThreeCheck = false;

  String SecTotalA;
  String TotalPriceForAllProduct;
  String TotalPrice;
  List<bool> visibilityObs = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> visibilityObsTwo = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool visibilityObssec = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Created_At = widget.created_at;
    Invoice_Num = widget.invoice_num;
    Order_Code = widget.order_code;
    Order_Status_Id = widget.order_status_id;
    Total_Quantity = widget.total_quantity;
    Total_Amt = widget.total_amt;
    SecTotalA = Total_Amt;
    TotalPrice = Total_Amt;
    Id = widget.id;

    getUserID();
  }

  void doAdditiondelete(String price, String qty, String name, String img,
      String id, String RealQTY, String CalculatPrice, String Total) {
    setState(() {
      double totalp = double.parse(price);
      SecTotalA = (double.parse(SecTotalA) - totalp).toString();
      TotalPriceForAllProduct = SecTotalA;
      TotalPrice = TotalPriceForAllProduct;

      if (productid.length != 0) {
        if (productid.contains(id)) {
          for (int i = 0; i < productid.length; i++) {
            if (productid[i] == id) {
              ver_qty.insert(i, qty);
              ver_calculatePrice.insert(i, CalculatPrice);
            }
          }
        } else {
          productid.add(id);
          ver_name.add(name);
          ver_qty.add(qty);
          ver_delete.add("1");
          ver_totalPrice.add(Total);
          ver_calculatePrice.add(CalculatPrice);
        }
      } else {
        ButtonText = "Submit";
        productid.add(id);
        ver_name.add(name);
        ver_qty.add(qty);
        ver_delete.add("1");
        ver_totalPrice.add(Total);
        ver_calculatePrice.add(CalculatPrice);
      }
    });
  }


  // after submit click run api
  void CalulateValue() async {
    String Delete;
    String objTextss;
    int totalqty = 0;
    for (int i = 0; i < productid.length; i++) {
      totalqty = totalqty + int.parse(ver_qty[i]);

      objTextss = '{"id": "' +
          productid[i] +
          '", "ver_qty": "' +
          ver_qty[i] +
          '", "ver_name": "' +
          ver_name[i] +
          '", "ver_delete": "' +
          ver_delete[i] +
          '", "ver_totalPrice": "' +
          ver_totalPrice[i] +
          '", "ver_calculatePrice": "' +
          ver_calculatePrice[i] +
          '"}';
      print("this is new world two = " + objTextss);

      result.add(objTextss);
    }
    String TotalQTY = (int.parse(Total_Quantity) - totalqty).toString();
    if (TotalPriceForAllProduct == "0.0") {
      Delete = "1";
    } else {
      Delete = "0";
    }
    String objText = '{"cdblock": "order_cancel", "id": "' +
        UserID +
        '", "order_id": "' +
        Id +
        '", "invoice_num": "' +
        Invoice_Num +
        '", "TotalPrice": "' +
        TotalPriceForAllProduct +
        '", "Delete": "' +
        Delete +
        '", "OldTotalPrice": "' +
        Total_Amt +
        '", "TotalQty": "' +
        TotalQTY +
        '", "item": ' +
        result.toString() +
        '}';

    var url = baseUrl + "?req=" + objText;
    print("response v url = " + url);
    http.get(url).then((response) {
      setState(() {
        print("response = " + response.body);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeOrderAccount()),
        );
      });
    });

    print("this is new world = " + objText);
  }

  void doAddition(String price, String qty, String name, String img, String id,
      String RealQTY, String CalculatPrice, String Total, String Symbole) {
    print("WalletLuckyWalletv price  =  " + price);
    print("WalletLuckyWalletv  qty =  " + qty);
    print("WalletLuckyWalletv name  =  " + name);
    print("WalletLuckyWalletv img  =  " + img);
    print("WalletLuckyWalletv id  =  " + id);
    print("WalletLuckyWalletv RealQTY  =  " + RealQTY);
    print("WalletLuckyWalletv CalculatPrice  =  " + CalculatPrice);
    print("WalletLuckyWalletv Total  =  " + Total);
    print("WalletLuckyWalletv Symbole  =  " + Symbole);
    setState(() {
      double totalp = double.parse(price);

      if (Symbole == "Add") {
        SecTotalA = (double.parse(SecTotalA) + totalp).toString();

        TotalPriceForAllProduct = SecTotalA;

        TotalPrice = TotalPriceForAllProduct;
      } else {
        SecTotalA = (double.parse(SecTotalA) - totalp).toString();
        TotalPriceForAllProduct = SecTotalA;
        TotalPrice = TotalPriceForAllProduct;
      }

      if (productid.length != 0) {
        if (productid.contains(id)) {
          for (int i = 0; i < productid.length; i++) {
            if (productid[i] == id) {
              ver_qty.insert(i, qty);
              ver_calculatePrice.insert(i, CalculatPrice);
            }
          }
        } else {
          productid.add(id);
          ver_name.add(name);
          ver_qty.add(qty);
          ver_delete.add("0");
          ver_totalPrice.add(Total);
          ver_calculatePrice.add(CalculatPrice);
        }
      } else {
        ButtonText = "Submit";

        productid.add(id);
        ver_name.add(name);
        ver_qty.add(qty);

        ver_delete.add("0");
        ver_totalPrice.add(Total);
        ver_calculatePrice.add(CalculatPrice);
      }
    });
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    print("cheange order index = " + index.toString());
    return Card(
      child: Column(
        children: [
          Container(
            height: 120,
            child: Row(
              children: [
                Expanded(flex: 25, child: Image.network(citys[index].imageURL)),
                Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            citys[index].product_Name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            citys[index].ver_capacity +" "+
                                citys[index].ver_unit +
                                " x " +
                                citys[index].quantity,
                            style: TextStyle(fontSize: 11, color: Colors.black),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "For You: ₹" + citys[index].offer_price,
                            style: TextStyle(fontSize: 11, color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 60, 0),
                          alignment: Alignment.topLeft,
                          width: 100,
                          child: Order_Status_Id == "Order Received" ?
                          (numberofitems[index] == 0
                              ? Container(
                            alignment: Alignment.topLeft,
                            height: 30.0,
                            child: FlatButton(
                              child: Text(
                                'Add',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                    color: Color(0xffff791a),
                                    fontWeight: FontWeight.bold),
                              ),
                              textTheme: ButtonTextTheme.accent,
                              onPressed: () {
                                setState(() {
                                  visibilityObsTwo[index] = true;
                                  numberofitems[index]++;
                                  ButtonText = "Submit";
                                  double totalpr = double.parse(
                                      (numberofitems[index])
                                          .toString()) *
                                      double.parse(
                                          citys[index].offer_price);
                                  CalculatedValue[index] =
                                      totalpr.toString();

                                  int total = int.parse(
                                      citys[index].quantity) *
                                      (double.parse(
                                          citys[index].offer_price))
                                          .toInt();
                                  doAddition(
                                      citys[index].offer_price,
                                      numberofitems[index].toString(),
                                      citys[index].product_Name,
                                      citys[index].imageURL,
                                      citys[index].product_id,
                                      citys[index].quantity,
                                      totalpr.toString(),
                                      total.toString(),
                                      "Add");
                                });
                              },
                            ),
                          )
                              : Container(
                            height: 30.0,
                            padding:
                            EdgeInsets.symmetric(horizontal: 11.0),
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: Color(0xffff791a)),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      visibilityObsTwo[index] = true;
                                      ButtonText = "Submit";
                                      numberofitems[index]--;
                                      double totalpr = double.parse(
                                          (numberofitems[index])
                                              .toString()) *
                                          double.parse(
                                              citys[index].offer_price);
                                      CalculatedValue[index] =
                                          totalpr.toString();

                                      int total = int.parse(
                                          citys[index].quantity) *
                                          (double.parse(citys[index]
                                              .offer_price))
                                              .toInt();
                                      doAddition(
                                          citys[index].offer_price,
                                          numberofitems[index].toString(),
                                          citys[index].product_Name,
                                          citys[index].imageURL,
                                          citys[index].product_id,
                                          citys[index].quantity,
                                          totalpr.toString(),
                                          total.toString(),
                                          "minus");
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xffff791a),
                                    size: 20.0,
                                    //size: 23.3,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text(numberofitems[index].toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption),
                                SizedBox(width: 8.0),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      visibilityObsTwo[index] = true;
                                      ButtonText = "Submit";
                                      if (int.parse(
                                          citys[index].quantity) >
                                          numberofitems[index]) {
                                        numberofitems[index]++;
                                        double totalpr = double.parse(
                                            (numberofitems[index])
                                                .toString()) *
                                            double.parse(
                                                citys[index].offer_price);
                                        CalculatedValue[index] =
                                            totalpr.toString();

                                        int total = int.parse(
                                            citys[index].quantity) *
                                            (double.parse(citys[index]
                                                .offer_price))
                                                .toInt();
                                        doAddition(
                                            citys[index].offer_price,
                                            numberofitems[index]
                                                .toString(),
                                            citys[index].product_Name,
                                            citys[index].imageURL,
                                            citys[index].product_id,
                                            citys[index].quantity,
                                            totalpr.toString(),
                                            total.toString(),
                                            "Add");
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xffff791a),
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ))
                              : new Container(),
                        ),

                        // Container(
                        //   width: 100,
                        //   alignment: Alignment.topLeft,
                        //
                        //   child: visibilityObs[index]
                        //       ? new Positioned(
                        //     right: 0.0,
                        //     bottom: 0,
                        //     child: numberofitems[index] == 0
                        //         ? Container(
                        //       height: 30.0,
                        //       child: FlatButton(
                        //         child: Text(
                        //           'Add',
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .caption
                        //               .copyWith(
                        //               color: Color(
                        //                   0xffff791a),
                        //               fontWeight:
                        //               FontWeight
                        //                   .bold),
                        //         ),
                        //         textTheme:
                        //         ButtonTextTheme.accent,
                        //         onPressed: ()
                        //         {
                        //           setState(() {
                        //             numberofitems[index]++;
                        //
                        //             double totalpr = double.parse((numberofitems[index]).toString()) * double.parse(citys[index].offer_price);
                        //             CalculatedValue[index] = totalpr.toString();
                        //
                        //             int total = int.parse(citys[index].quantity) *
                        //                 (double.parse(citys[index].offer_price)).toInt();
                        //             doAddition(citys[index].offer_price,
                        //                 numberofitems[index].toString(),
                        //                 citys[index].product_Name,
                        //                 citys[index].imageURL,
                        //                 citys[index].product_id,
                        //                 citys[index].quantity,
                        //                 totalpr.toString(),
                        //                 total.toString(),
                        //                 "Add");
                        //           });
                        //         },
                        //       ),
                        //     )
                        //         : Container(
                        //       height: 30.0,
                        //
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 11.0),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(
                        //             color:
                        //             Color(0xffff791a)),
                        //         borderRadius:
                        //         BorderRadius.circular(
                        //             30.0),
                        //       ),
                        //       child: Row(
                        //         children: <Widget>[
                        //           InkWell(
                        //             onTap: () {
                        //               setState(() {
                        //                 numberofitems[
                        //                 index]--;
                        //                 double totalpr = double.parse(
                        //                     (numberofitems[
                        //                     index])
                        //                         .toString()) *
                        //                     double.parse(citys[
                        //                     index]
                        //                         .offer_price);
                        //                 CalculatedValue[
                        //                 index] =
                        //                     totalpr
                        //                         .toString();
                        //
                        //                 int total = int.parse(
                        //                     citys[index]
                        //                         .quantity) *
                        //                     (double.parse(citys[
                        //                     index]
                        //                         .offer_price))
                        //                         .toInt();
                        //                 doAddition(
                        //                     citys[index]
                        //                         .offer_price,
                        //                     numberofitems[
                        //                     index]
                        //                         .toString(),
                        //                     citys[index]
                        //                         .product_Name,
                        //                     citys[index]
                        //                         .imageURL,
                        //                     citys[index]
                        //                         .product_id,
                        //                     citys[index]
                        //                         .quantity,
                        //                     totalpr
                        //                         .toString(),
                        //                     total
                        //                         .toString(),
                        //                     "minus");
                        //               });
                        //             },
                        //             child: Icon(
                        //               Icons.remove,
                        //               color:
                        //               Color(0xffff791a),
                        //               size: 20.0,
                        //               //size: 23.3,
                        //             ),
                        //           ),
                        //           SizedBox(width: 8.0),
                        //           Text(
                        //               numberofitems[index]
                        //                   .toString(),
                        //               style:
                        //               Theme.of(context)
                        //                   .textTheme
                        //                   .caption),
                        //           SizedBox(width: 8.0),
                        //           InkWell(
                        //             onTap: () {
                        //               setState(() {
                        //                 if (int.parse(citys[index].quantity) > numberofitems[index]) {
                        //                   numberofitems[index]++;
                        //                   double totalpr = double.parse((numberofitems[index]).toString()) * double.parse(citys[index].offer_price);
                        //                   CalculatedValue[index] =totalpr.toString();
                        //
                        //                   int total = int.parse(citys[index].quantity) *
                        //                       (double.parse(citys[index].offer_price)).toInt();
                        //                   doAddition(citys[index].offer_price,
                        //                       numberofitems[index].toString(),
                        //                       citys[index].product_Name,
                        //                       citys[index].imageURL,
                        //                       citys[index].product_id,
                        //                       citys[index].quantity,
                        //                       totalpr.toString(),
                        //                       total.toString(),
                        //                       "Add");
                        //                 }
                        //               });
                        //             },
                        //             child: Icon(
                        //               Icons.add,
                        //               color:
                        //               Color(0xffff791a),
                        //               size: 20.0,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   )
                        //       : new Container(),
                        // ),

                        // Expanded(
                        //   flex: 5,
                        //   child: Column(
                        //     children: [
                        //
                        //     ],
                        //   ),
                        // ),

                        // Expanded(
                        //     flex: 5,
                        //     child: Container(child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //
                        //
                        //       ],
                        //     ),)
                        //
                        //
                        //
                        //
                        //
                        //
                        //
                        //
                        // ),
                      ],
                    )),
                Expanded(
                  flex: 25,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: [
                              // Expanded(
                              //   flex: 5,
                              //   child: InkWell(
                              //     onTap: () {
                              //       setState(() {
                              //         ButtonText = "Submit";
                              //         visibilityObsTwo[index] = true;
                              //         if (visibilityObs[index]) {
                              //           visibilityObs[index] = false;
                              //         } else {
                              //           visibilityObs[index] = true;
                              //         }
                              //       });
                              //     },
                              //     child:
                              //
                              //
                              //
                              //
                              //     Image.asset(
                              //       'images/icons/editicon.png',
                              //       height: 19.0,
                              //       width: 18.3,
                              //       alignment: Alignment.center,
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Order_Status_Id == "Order Received"
                                    ? new InkWell(
                                  onTap: () {
                                    setState(() {
                                      ButtonText = "Submit";
                                      int total =
                                          int.parse(citys[index].quantity) *
                                              (double.parse(
                                                  citys[index].offer_price))
                                                  .toInt();
                                      doAdditiondelete(
                                          total.toString(),
                                          citys[index].quantity,
                                          citys[index].product_Name,
                                          citys[index].imageURL,
                                          citys[index].product_id,
                                          citys[index].quantity,
                                          "0",
                                          total.toString());
                                      citys.removeAt(index);
                                    });
                                  },
                                  child: visibilityObsTwo[index]
                                      ? new Container()
                                      : new Image.asset(
                                    'images/icons/deleteicon.png',
                                    height: 19.0,
                                    width: 18.3,
                                    alignment: Alignment.center,
                                  ),
                                )
                                    : new Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  visibilityObsTwo[index]
                                      ? "₹ " + CalculatedValue[index]
                                      : "₹ " + CalculatedPrice[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                // Text(
                                //   "₹ " + CalculatedValue[index],
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //   ),
                                // ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  var black = const Color(0xff000000);
  int num = 0;
  bool newdata = false;


  ///Order Traking API to open bottom popup
  Container _buildBottomNavigationMenu() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    Invoice_Num,
                    style:
                    orderMapAppBarTextStyle.copyWith(letterSpacing: 0.07),
                  ),
                  subtitle: Text(
                    Total_Quantity + ' items | \ ₹' + Total_Amt,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6
                        .copyWith(
                        fontSize: 11.7,
                        letterSpacing: 0.06,
                        color: Color(0xffc1c1c1)),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          Order_Status_Id,
                          style: orderMapAppBarTextStyle.copyWith(
                              color: kMainColor),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShowcaseDeliveryTimeline()));
                        },
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        Created_At,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6
                            .copyWith(
                            fontSize: 11.7,
                            letterSpacing: 0.06,
                            color: Color(0xffc1c1c1)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Column(
                    children: [
                      Order_Status_Id == "Order Received" ?
                      new ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            isFirst: true,
                            indicatorStyle: const IndicatorStyle(
                              width: 20,
                              color: Color(0xFFff791a),
                              padding: EdgeInsets.all(6),
                            ),
                            endChild: const _RightChild(

                              asset: 'assets/delivery/order_placed.png',
                              title: 'Order Received',
                              message: 'We have received your order.',
                            ),
                            beforeLineStyle: const LineStyle(
                              color: Color(0xFF27AA69),
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            indicatorStyle: const IndicatorStyle(
                              width: 20,
                              color: Color(0xFF27AA69),
                              padding: EdgeInsets.all(6),
                            ),
                            endChild: const _RightChild(
                              disabled: true,
                              asset: 'assets/delivery/order_confirmed.png',
                              title: 'Order Accepted',
                              message: 'We are packing your order.',
                            ),
                            beforeLineStyle: const LineStyle(
                              color: Color(0xFF27AA69),
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            indicatorStyle: const IndicatorStyle(
                              width: 20,
                              color: Color(0xFF27AA69),
                              padding: EdgeInsets.all(6),
                            ),
                            endChild: const _RightChild(
                              disabled: true,
                              asset: 'assets/delivery/order_processed.png',
                              title: 'Order Delivered',
                              message: 'Order successfully delivered.',
                            ),
                            beforeLineStyle: const LineStyle(
                              color: Color(0xFF27AA69),
                            ),
                            afterLineStyle: const LineStyle(
                              color: Color(0xFFDADADA),
                            ),
                          ),
                        ],
                      ) :

                      (
                          Order_Status_Id == "Order Accepted" ?
                          new ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                isFirst: true,
                                indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFF27AA69),
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: const _RightChild(
                                  disabled: true,
                                  asset: 'assets/delivery/order_placed.png',
                                  title: 'Order Received',
                                  message: 'We have received your order.',
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xFF27AA69),
                                ),
                              ),
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFFff791a),
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: const _RightChild(
                                  asset: 'assets/delivery/order_confirmed.png',
                                  title: 'Order Accepted',
                                  message: 'We are packing your order.',
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xFF27AA69),
                                ),
                              ),
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFF27AA69),
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: const _RightChild(
                                  disabled: true,
                                  asset: 'assets/delivery/order_processed.png',
                                  title: 'Order Delivered',
                                  message: 'Order successfully delivered.',
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xFF27AA69),
                                ),
                                afterLineStyle: const LineStyle(
                                  color: Color(0xFFDADADA),
                                ),
                              ),
                            ],
                          ) :
                          new ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                isFirst: true,
                                indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFF27AA69),
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: const _RightChild(
                                  disabled: true,
                                  asset: 'assets/delivery/order_placed.png',
                                  title: 'Order Received',
                                  message: 'We have received your order.',
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xFF27AA69),
                                ),
                              ),
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFF27AA69),
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: const _RightChild(
                                  disabled: true,
                                  asset: 'assets/delivery/order_confirmed.png',
                                  title: 'Order Accepted',
                                  message: 'We are packing your order.',
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xFF27AA69),
                                ),
                              ),
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFFff791a),
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: const _RightChild(
                                  asset: 'assets/delivery/order_processed.png',
                                  title: 'Order Delivered',
                                  message: 'Order successfully delivered.',
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Color(0xFF27AA69),
                                ),
                                afterLineStyle: const LineStyle(
                                  color: Color(0xFFDADADA),
                                ),
                              ),
                            ],
                          )

                      )

                      ,
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 420,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPage()),
    );
  }

  bool _progress = false;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          appBar: AppBar(
            title: Text('Orders Tracking',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex:10,
                child: ListTile(
                  title: Text(
                    Invoice_Num,
                    style: orderMapAppBarTextStyle.copyWith(
                        letterSpacing: 0.07),
                  ),
                  subtitle: Text(
                    Total_Quantity + ' items | \ ₹' + Total_Amt,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6
                        .copyWith(
                        fontSize: 11.7,
                        letterSpacing: 0.06,
                        color: Color(0xffc1c1c1)),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Order_Status_Id,
                        style: orderMapAppBarTextStyle.copyWith(
                            color: kMainColor),
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        Created_At,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6
                            .copyWith(
                            fontSize: 11.7,
                            letterSpacing: 0.06,
                            color: Color(0xffc1c1c1)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xff888888),
              ),
              Expanded(
                flex:10,
                child:  Row(
                  children: [
                    Expanded(
                      flex: 65,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 2, 1),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Uname,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 2, 1),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              UAddress,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff888888),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 45,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 2, 1),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Order Status",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffff791a)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 2, 1),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Order_Status_Id,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xff888888),
              ),
              Expanded(
                flex: 77,
                child: Column(
                  children: [




                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 1, 0),
                      height: MediaQuery.of(context).size.height-350,
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: <Widget>[
                          ListView.builder(
                              padding: EdgeInsets.only(top: 10),
                              itemCount: citys.length,
                              itemBuilder: _buildItemsForListView),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 13,
                child: Column(
                  children: [
                    Expanded(
                      flex: 25,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Total Price",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "₹" + TotalPrice,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 75,
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
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
                              text: ButtonText,
                              onTap: () {
                                if (ButtonText == "TRACK ORDER") {
                                  OneCheck = true;
                                  _onButtonPressed();
                                } else {
                                  ButtonText = "Please Wait";
                                  setState(() {
                                    _progress = true;
                                  });
                                  CalulateValue();
                                }
                              },
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )


    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFBABABA)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFD5D5D5)
                      : const Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
