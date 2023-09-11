import 'dart:convert';

import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Pages/add_money.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:toast/toast.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Pages/view_cart.dart';

class ProductDetailsPage extends StatefulWidget {
  final String P_Id;
  final String P_name;
  final String P_description;
  final String P_image1;

  final String P_verShortDesc;
  final String P_verCapacity;
  final String P_verUnit;
  final String P_verPrice;
  final String P_offerPrice;
  final String walletprice;
  final String productQty;

  ProductDetailsPage(
      {this.P_Id,
      this.P_name,
      this.P_description,
      this.P_image1,
      this.P_verShortDesc,
      this.P_verCapacity,
      this.P_verUnit,
      this.P_verPrice,
      this.P_offerPrice,
      this.walletprice,
      this.productQty});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

ProductModelSec productModelFromJsons(String str) =>
    ProductModelSec.fromJson(json.decode(str));

class ProductModelSec {
  ProductModelSec({
    this.response,
  });

  List<List<ResponseSec>> response;

  factory ProductModelSec.fromJson(Map<String, dynamic> json) =>
      ProductModelSec(
        response: List<List<ResponseSec>>.from(json["response"].map((x) =>
            List<ResponseSec>.from(x.map((x) => ResponseSec.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ResponseSec {
  ResponseSec({
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemSec> items;

  factory ResponseSec.fromJson(Map<String, dynamic> json) => ResponseSec(
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items:
            List<ItemSec>.from(json["items"].map((x) => ItemSec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ItemSec {
  ItemSec({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemSec.fromJson(Map<String, dynamic> json) => ItemSec(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

var productModelSec = new List<ResponseSec>();

var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String P_ID;
  String P_Name;
  String P_Description;
  String P_Image1;
  String P_VerShortDesc;
  String P_VerCapacity;
  String P_VerUnit;
  String P_VerPrice;
  String P_OfferPrice;
  String P_off;

  String WalletPrice;

  void getUserID() async {
    var rowall = await dbhandler.firstqueryall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });
  }

  _runapithree() async {
    String objText = '{"cdblock": "HomeRandomProducts"}';
    var url = baseUrl + "?req=" + objText;

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        final ProductModelSec users = productModelFromJsons(response.body);
        productModelSec = users.response[0];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserID();

    P_ID = widget.P_Id;
    P_Name = widget.P_name;
    P_Description = widget.P_description;
    P_Image1 = widget.P_image1;
    P_VerShortDesc = widget.P_verShortDesc;
    P_VerCapacity = widget.P_verCapacity;
    P_VerUnit = widget.P_verUnit;

    P_VerPrice = widget.P_verPrice;
    P_OfferPrice = widget.P_offerPrice;
    WalletPrice = widget.walletprice;
    productqty = widget.productQty;

    double off = double.parse(P_VerPrice) - double.parse(P_OfferPrice);
    double per = (off * 100) / double.parse(P_VerPrice);

    P_off = per.toStringAsFixed(2).toString();
    _runapithree();
  }

  int TotalPrice = 0;

  int price = 0;

  int TotalItems = 0;
  int indexnew = 0;

  /// database
  final dbhandler = DbStudentMamager.instance;
  String UserID;
  String ProductPrice;
  String ProductId;
  String Qty;
  String TotalPricess;
  String ItemType;
  String ProductName;
  String ProductImg;
  String ProductType;
  int numberofitems = 0;

  //// get Product ID in createuserTable Table in DataBase
  void firstqueryall() async {
    // get all row in the table
    var rowall = await dbhandler.firstqueryall();

    //// check row on the table is null or not
    if (rowall.length.toString() != "0") {
      print('table length 2 = ' + rowall.length.toString());
      print("ProductId  = " + ProductId.toString());
//      int _list =  await dbhandler.checkrow(int.parse(ProductId));

      int count = 0;
      count = await dbhandler.checkrow(int.parse(ProductId));
      print("row  = " + count.toString());
      if (count == null) {
        count = 0;
      }
      print("count = " + count.toString());

      if (count >= 1) {
        print('UPdate Query........');
        updatedb();
      } else {
        print('Insert Query........');
        firstinsertdata();
      }

      rowall.forEach((row) {
        print(row);
      });
    } else {
      print('Insert Quer in else');

      firstinsertdata();
    }
  }

  /// update database
  void updatedb() async {
    Map<String, dynamic> row = {
      DbStudentMamager.userid: UserID,
      DbStudentMamager.productid: ProductId,
      DbStudentMamager.productname: ProductName,
      DbStudentMamager.productimg: ProductImg,
      DbStudentMamager.qty: Qty,
      DbStudentMamager.price: ProductPrice,
      DbStudentMamager.itemtype: ProductType,
      DbStudentMamager.totalprice: TotalPricess,
      DbStudentMamager.productqty: productqty
    };

    print("id  = " + ProductId);

    final id = await dbhandler.firstupdate(
        int.parse(ProductId), int.parse(Qty), int.parse(TotalPricess), row);

//    var rowall = await dbhandler.firstqueryall();
//    TotalItems = rowall.length.toInt();
    print("id update = " + id.toString());

    var rowall = await dbhandler.firstqueryall();

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });

//    Toast.show("id update = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  //// getUser ID in createuserTable Table in DataBase

  //// STore product in FirstTable in Database
  void firstinsertdata() async {
//    Toast.show("categoryID = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    print("UserID = " + UserID);
    print("ProductId = " + ProductId);
    print("ProductName = " + ProductName);
    print("ProductImg = " + ProductImg);

    print("Qty = " + Qty);
    print("ProductPrice = " + ProductPrice);

//    print("ItemType = "+ProductType);
    print("TotalPricess = " + TotalPricess);
    Map<String, dynamic> row = {
      DbStudentMamager.userid: UserID,
      DbStudentMamager.productid: ProductId,
      DbStudentMamager.productname: ProductName,
      DbStudentMamager.productimg: ProductImg,
      DbStudentMamager.qty: Qty,
      DbStudentMamager.price: ProductPrice,
      DbStudentMamager.itemtype: "Single",
      DbStudentMamager.totalprice: TotalPricess,
      DbStudentMamager.productqty:productqty
    };

    final id = await dbhandler.firstinsert(row);

    print("id = " + id.toString());
    var rowall = await dbhandler.firstqueryall();

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });

//    print(id);
//    Toast.show("id = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  String productqty;
  void doAddition(int qty) {
    setState(() {
      int TotalPricenew =
          (double.parse(P_OfferPrice) * numberofitems.toDouble()).toInt();
      print("TotalPricenew 2  = " + TotalPricenew.toString());
      print("Price  = " + P_OfferPrice);
//

      print("Qty = " + numberofitems.toString());

      ProductType = "Single";
      ProductName = P_Name;
      ProductImg = P_Image1;
      ProductId = P_ID;
      ProductPrice = P_OfferPrice;
      Qty = qty.toString();
      TotalPricess = TotalPricenew.toString();
      productqty = P_VerCapacity +
          P_VerUnit;
      print("product Chewck DataBase == "+productqty);
      //// Database api run
      firstqueryall();
    });
  }

  Column _buildItemsForListView(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Card(
          color: Color(0xffF2F7F9),
          child: InkWell(
            onTap: () {
              print("ProductDetailsPage productId == "+productModelSec[index].productId);
              print("ProductDetailsPage name == "+productModelSec[index].name);
              print("ProductDetailsPage description == "+productModelSec[index].description);
              print("ProductDetailsPage image1 == "+productModelSec[index].image1);
              print("ProductDetailsPage verShortDesc == "+productModelSec[index].items[0].verShortDesc);
              print("ProductDetailsPage verCapacity == "+productModelSec[index].items[0].verCapacity);
              print("ProductDetailsPage verUnit == "+productModelSec[index].items[0].verUnit);

              print("ProductDetailsPage verPrice == "+productModelSec[index].items[0].verPrice);
              print("ProductDetailsPage offerPrice == "+productModelSec[index].items[0].offerPrice);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                            P_Id: productModelSec[index].productId,
                            P_name: productModelSec[index].name,
                            P_description: productModelSec[index].description,
                            P_image1: productModelSec[index].image1,
                            P_verShortDesc:
                                productModelSec[index].items[0].verShortDesc,
                            P_verCapacity:
                                productModelSec[index].items[0].verCapacity,
                            P_verUnit: productModelSec[index].items[0].verUnit,
                            P_verPrice:
                                productModelSec[index].items[0].verPrice,
                            P_offerPrice:
                                productModelSec[index].items[0].offerPrice,
                        walletprice: WalletPrice
                            .toString(),
                          )));
            },
            child: Container(
                height: 130,
                width: 130,
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.05),
                          offset: Offset(0, 5),
                          blurRadius: 5)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: Image.network(
                          productModelSec[index].image1,
                          height: 80,
                          width: 80,
                        )),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          productModelSec[index].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: 11, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Container _buildBottomNavigationMenu() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  color: Color(0xffF2F2F2),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Low on balance",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "You are low on balance, please recharge to continue shopping.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMoneyActivity()),
                        );
                      },
                      color: Color(0xffff791a),
                      child: const Text('Add Money Now',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
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
            height: 300,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: Text(
                P_Name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kMainTextColor),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 280,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //       image: NetworkImage(P_Image1),
                        //       fit: BoxFit.cover
                        //   ) ,
                        // ),
                        child: Image.network(P_Image1),
                      ),
                      Divider(
                        color: Color(0xff888888),
                      ),
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Text(
                                  P_Name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 25,
                                child: Text(
                                  "₹ " + P_VerPrice,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                flex: 25,
                                child: Text(
                                  "₹ " + P_OfferPrice,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )),
                      Divider(
                        color: Color(0xff888888),
                      ),
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          height: 45,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 35,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    P_off + "% OFF",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffff791a)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 40,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    P_VerCapacity + P_VerUnit,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 30,
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: numberofitems == 0
                                      ? Container(
                                          height: 30.0,
                                          child: FlatButton(
                                            child: Text(
                                              'Add',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: Color(0xffff791a),
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            textTheme: ButtonTextTheme.accent,
                                            onPressed: () {
                                              setState(() {

                                                int total = 0;
                                                double totalproduct = numberofitems.toDouble();
                                                totalproduct =totalproduct + 1.0;

                                                int TotalPricenew = (double.parse(P_OfferPrice) * 1.0).toInt();

                                                print("TotalPrice by time TotalPricenew = " + TotalPricenew.toString());

                                                total = TotalPrice;
                                                print("TotalPrice by time TotalPrice = " + TotalPrice.toString());
                                                total = total + TotalPricenew;
                                                print("TotalPrice by time total = " + total.toString());
                                                print("TotalPrice by time WalletPrice = " + WalletPrice.toString());

                                                if (int.parse(WalletPrice) == 0) {
                                                  print("ProductDetailsPage 10 == ");
                                                  _onButtonPressed();
                                                } else if (total > int.parse(WalletPrice)) {
                                                  print("ProductDetailsPage 12 == ");
                                                  _onButtonPressed();
                                                } else {
                                                  print("ProductDetailsPage 13 == ");
                                                  numberofitems++;
                                                  doAddition(numberofitems);
                                                }
                                              });
                                            },
                                          ),
                                        )
                                      : Container(
                                          height: 30.0,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 11.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffff791a)),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    int total = 0;
                                                    double totalproduct =
                                                        numberofitems
                                                            .toDouble();
                                                    totalproduct =
                                                        totalproduct + 1.0;

                                                    int TotalPricenew =
                                                        (double.parse(
                                                                    P_OfferPrice) *
                                                                totalproduct)
                                                            .toInt();

                                                    print(
                                                        "TotalPrice by time TotalPricenew = " +
                                                            TotalPricenew
                                                                .toString());

                                                    total = TotalPrice;
                                                    total =
                                                        total + TotalPricenew;
                                                    print(
                                                        "TotalPrice by time total = " +
                                                            total.toString());
                                                    if (int.parse(
                                                            WalletPrice) ==
                                                        0) {
                                                      _onButtonPressed();
                                                    } else if (total >
                                                        int.parse(
                                                            WalletPrice)) {
                                                      _onButtonPressed();
                                                    } else {
                                                      numberofitems--;
                                                      doAddition(numberofitems);
                                                    }

//                                                AddTotalPrice();
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
                                              Text(numberofitems.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              SizedBox(width: 8.0),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {

                                                    double totalproduct = numberofitems.toDouble();
                                                    totalproduct = totalproduct + 1.0;

                                                    int TotalPricenew = (double.parse(P_OfferPrice) * 1.0).toInt();

                                                    print("TotalPrice by time TotalPricenew = " + TotalPricenew.toString());
                                                    int total = 0;
                                                    total = TotalPrice;
                                                    print("TotalPrice by time TotalPrice = " + TotalPrice.toString());
                                                    total = total + TotalPricenew;
                                                    print("TotalPrice by time total = " + total.toString());
                                                    print("TotalPrice by time WalletPrice = " + WalletPrice.toString());
                                                    if (int.parse(WalletPrice) == 0) {
                                                      _onButtonPressed();
                                                    } else if (total > int.parse(WalletPrice)) {
                                                      _onButtonPressed();
                                                    } else {
                                                      numberofitems++;
                                                      doAddition(numberofitems);
                                                    }

//                                                AddTotalPrice();
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
                                        ),
                                ),
                                // Positioned(
                                //   right: 20.0,
                                //   bottom: 14,
                                //   child:
                                // ),
                              ),
                            ],
                          )),
                      Divider(
                        color: Color(0xff888888),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Description :",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          P_Description,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Discover More Product :",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 1, 10),
                        height: 150,
                        alignment: Alignment.topLeft,
                        child: Stack(
                          children: <Widget>[
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(top: 1),
                                itemCount: productModelSec.length,
                                itemBuilder: _buildItemsForListView),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'images/icons/ic_cart wt.png',
                        height: 19.0,
                        width: 18.3,
                      ),
                      SizedBox(width: 20.7),
                      Text(
                        TotalPrice == 0
                            ? '0 items | 0 Total Price'
                            : TotalItems.toString() +
                                ' items | \₹ ' +
                                (TotalPrice).toString(),
                        style: bottomBarTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          if(TotalItems == 0){
                            Toast.show("Please select any product...", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCart()),
                            );
                          }

                        }
                           ,
                        child: Text(
                          'View Cart',
                          style: Theme.of(context).textTheme.caption.copyWith(
                              color: Color(0xffff791a),
                              fontWeight: FontWeight.bold),
                        ),
                        textTheme: ButtonTextTheme.accent,
                        disabledColor: Colors.white,
                      ),
                    ],
                  ),
                  color: Color(0xffff791a),
                  height: 60.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
