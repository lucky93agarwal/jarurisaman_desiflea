import 'dart:convert';

import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Pages/product_details_page.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'add_money.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:toast/toast.dart';
import 'package:delivoo/Pages/view_cart.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Pages/monthly.dart';
class SearchProductPage extends StatefulWidget {
  @override
  _SearchProductPageState createState() => _SearchProductPageState();
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
    this.category_id,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String category_id;
  String productId;
  String name;
  String description;
  String image1;
  int numberofitems = 0;
  List<ItemSec> items;

  factory ResponseSec.fromJson(Map<String, dynamic> json) => ResponseSec(
        category_id: json["category_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items:
            List<ItemSec>.from(json["items"].map((x) => ItemSec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": category_id,
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
    this.percentage,
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
  String percentage;
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
        percentage: json["percentage"],
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
        "percentage": percentage,
        "is_out_of_stock": isOutOfStock,
      };
}

var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }


  int TotalPrice = 0;

  int price = 0;

  int TotalItems = 0;
  int indexnew = 0;

  var productModelSec = new List<ResponseSec>();

  _runapis() async {
    String objText = '{"cdblock": "Search", "search": "' + searchdata + '"}';
    var url = baseUrl + "?req=" + objText;
    print("reset data from server url =" + url.toString());
    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        if (productModelSec.length > 0) {
          productModelSec.clear();
        }

        final ProductModelSec users = productModelFromJsons(response.body);
        productModelSec = users.response[0];
        print("reset data from server url =" + url.toString());

        visibilty = false;
      });
    });
  }

  String searchdata;

  void searchproduct(String reset) {
    setState(() {
      visibilty = true;
    });

    searchdata = _searchController.text;
    print("reset data from server 1 =" + searchdata.length.toString());
    if (searchdata.length >= 3) {
      print("reset data from server 2 =");
      _runapis();
    }
  }

  /// database
  final dbhandler = DbStudentMamager.instance;
  String UserID;

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

  String TotalWallet = "0";

  //// getUser ID in createuserTable Table in DataBase
  void getUserID() async {
    print("Insert Quer in else v=");
    var rowall = await dbhandler.firstqueryall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');
    TotalWallet = prefs.getString('Wallet');
    walletprice = int.parse(TotalWallet);
    print("UserID = " + UserID);

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  //// STore product in FirstTable in Database
  void firstinsertdata() async {
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
      DbStudentMamager.productqty: productqty
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

  String ProductPrice;
  String ProductId;
  String Qty;
  String TotalPricess;
  String ItemType;
  String ProductName;
  String ProductImg;
  String ProductType;
  bool visibilty = false;
  String productqty;

  FocusNode _focusNode = FocusNode();

  void doAddition(int index, int qty, int indexsecond) {
    setState(() {
      int TotalPricenew =
          (double.parse(productModelSec[index].items[0].offerPrice) *
                  productModelSec[index].numberofitems.toDouble())
              .toInt();
      print("TotalPricenew 2  = " + TotalPricenew.toString());
      print("Price  = " + productModelSec[index].items[0].offerPrice);
//
      print("indexnew = " + index.toString());
      print("Qty = " + productModelSec[index].numberofitems.toString());

      ProductType = "Single";
      ProductName = productModelSec[index].name;
      ProductImg = productModelSec[index].image1;
      ProductId = productModelSec[index].productId;
      ProductPrice = productModelSec[index].items[0].offerPrice;
      Qty = qty.toString();
      TotalPricess = TotalPricenew.toString();
      // productqty = productModelSec[index].items[0].verUnit +
      //     productModelSec[index].items[0].verCapacity;
      productqty = productModelSec[index].items[0].verCapacity +
          productModelSec[index].items[0].verUnit;

      //// Database api run
      firstqueryall();
    });
  }

  int walletprice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: kMainTextColor)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    color: Color(0xffEEEEEE),
                    height: 70,
                    child: Card(
                      color: Color(0xffEEEEEE),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: InkWell(
                              onTap: () {
                                _runapis();
                              },
                              child: Image.asset(
                                "images/icons/ic_search.png",
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 80,
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: 'Search'),
                              onChanged: searchproduct,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Expanded(
                              flex: 10,
                              child: visibilty
                                  ? SpinKitFadingCircle(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: index.isEven
                                                ? Colors.deepOrangeAccent
                                                : Colors.orange,
                                          ),
                                        );
                                      },
                                    )
                                  : new Container())
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 1, 10),
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: <Widget>[
                        ListView.builder(
                          padding: EdgeInsets.only(top: 1),
                          itemCount: productModelSec.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0,
                                              top: 20.0,
                                              right: 5.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailsPage(
                                                            P_Id:
                                                                productModelSec[
                                                                        index]
                                                                    .productId,
                                                            P_name:
                                                                productModelSec[
                                                                        index]
                                                                    .name,
                                                            P_description:
                                                                productModelSec[
                                                                        index]
                                                                    .description,
                                                            P_image1:
                                                                productModelSec[
                                                                        index]
                                                                    .image1,
                                                            P_verShortDesc:
                                                                productModelSec[
                                                                        index]
                                                                    .items[0]
                                                                    .verShortDesc,
                                                            P_verCapacity:
                                                                productModelSec[
                                                                        index]
                                                                    .items[0]
                                                                    .verCapacity,
                                                            P_verUnit:
                                                                productModelSec[
                                                                        index]
                                                                    .items[0]
                                                                    .verUnit,
                                                            P_verPrice:
                                                                productModelSec[
                                                                        index]
                                                                    .items[0]
                                                                    .verPrice,
                                                            P_offerPrice:
                                                                productModelSec[
                                                                        index]
                                                                    .items[0]
                                                                    .offerPrice,
                                                          )));
                                            },
                                            child: Image.network(
                                              productModelSec[index].image1,
//                                scale: 2.5,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 180,
                                                  child: Text(
                                                    productModelSec[index].name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 11,fontFamily: 'Raleway',color: Colors.black),
                                                  ),
                                                ),
                                                // Align(
                                                //   alignment: Alignment.topRight,
                                                //   child: InkWell(onTap: (){
                                                //     Navigator.push(
                                                //         context,
                                                //         MaterialPageRoute(
                                                //             builder: (context) => MonthlyActivity(P_Id: productModelSec[index]
                                                //                 .productId,
                                                //                 P_name: productModelSec[index]
                                                //                     .name,
                                                //                 P_description:
                                                //                 productModelSec[index]
                                                //                     .description,
                                                //                 P_image1: productModelSec[index]
                                                //                     .image1,
                                                //                 P_verShortDesc: productModelSec[index]
                                                //                     .items[0]
                                                //                     .verShortDesc,
                                                //                 P_verCapacity: productModelSec[index]
                                                //                     .items[0]
                                                //                     .verCapacity,
                                                //                 P_verUnit: productModelSec[index]
                                                //                     .items[0]
                                                //                     .verUnit,
                                                //                 P_verPrice: productModelSec[index]
                                                //                     .items[0]
                                                //                     .verPrice,
                                                //                 P_offerPrice: productModelSec[index]
                                                //                     .items[0]
                                                //                     .offerPrice,
                                                //                 walletprice:
                                                //                 walletprice
                                                //                     .toString(),
                                                //                 productQty: productModelSec[index].items[0].verCapacity +
                                                //                     productModelSec[index]
                                                //                         .items[0]
                                                //                         .verUnit
                                                //             )));
                                                //   },child:  Image.asset("images/icons/repeat.png",height: 30,width: 30,),),
                                                //
                                                //
                                                //
                                                // ),
                                              ],
                                            ),
                                            Stack(children: [
                                              Container(margin: const EdgeInsets.fromLTRB(100.0, 0, 0, 0),
                                                child: Text(
                                                  "",
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xffff791a)),
                                              ),),
                                            ],
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                                productModelSec[index]
                                                    .items[0]
                                                    .verCapacity +
                                                    productModelSec[index]
                                                        .items[0]
                                                        .verUnit,
                                                style: TextStyle(fontSize: 11,color: Colors.grey[500])

                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(children: [
                                              Text(
                                                  '\₹ ' +
                                                      productModelSec[index]
                                                          .items[0]
                                                          .offerPrice,
                                                  style: TextStyle(fontSize: 11,color: Colors.black)

                                              ),
                                              Text(
                                                '\₹ ' +
                                                    productModelSec[index]
                                                        .items[0]
                                                        .verPrice,
                                                // + _fetchUserInfo(productList[index]
                                                // .items[0]
                                                // .verPrice,productList[index]
                                                // .items[0]
                                                // .offerPrice

                                                style: bottomNavigationTextStyle
                                                    .copyWith(
                                                  fontSize: 11,
                                                  color: Colors.grey[500],
                                                  decoration:
                                                  TextDecoration.lineThrough,
                                                ),
                                              ),
                                              Text(
                                                productModelSec[index]
                                                    .items[0]
                                                    .percentage + "% OFF",
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey[500],
                                                ),
                                              )
                                            ],),

                                            SizedBox(
                                              height: 8.0,
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 20.0,
                                      bottom: 14,
                                      child: productModelSec[index]
                                                  .numberofitems ==
                                              0
                                          ? Container(
                                              height: 30.0,
                                              child: FlatButton(
                                                child: Text(
                                                  'Add',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                          color:
                                                              Color(0xffff791a),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                textTheme:
                                                    ButtonTextTheme.accent,
                                                onPressed: () {
                                                  setState(() {

                                                    int total = 0;
                                                    double totalproduct = productModelSec[index].numberofitems.toDouble();
                                                    totalproduct = totalproduct + 1.0;

                                                    int TotalPricenew = (double.parse(productModelSec[index].items[0].offerPrice) * 1.0).toInt();
                                                    total = TotalPrice;
                                                    total = total + TotalPricenew;
                                                    if (walletprice == 0) {
                                                      _onButtonPressed();
                                                    } else if (total > walletprice) {
                                                      _onButtonPressed();
                                                    } else {
                                                      productModelSec[index].numberofitems++;
                                                      doAddition(index, productModelSec[index].numberofitems, 0);
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
                                                      indexnew = index;
                                                      setState(() {
                                                        productModelSec[index]
                                                            .numberofitems--;
                                                        doAddition(
                                                            index,
                                                            productModelSec[
                                                                    index]
                                                                .numberofitems,
                                                            0);
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
                                                  Text(
                                                      productModelSec[index]
                                                          .numberofitems
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption),
                                                  SizedBox(width: 8.0),
                                                  InkWell(
                                                    onTap: () {
                                                      indexnew = index;
                                                      setState(() {

                                                        // doAddition(index, productModelSec[index].numberofitems, 0);
                                                        int total = 0;
                                                        double totalproduct = productModelSec[index].numberofitems.toDouble();
                                                        totalproduct = totalproduct + 1.0;

                                                        int TotalPricenew = (double.parse(productModelSec[index].items[0].offerPrice) * 1.0).toInt();
                                                        total = TotalPrice;
                                                        total = total + TotalPricenew;

                                                        if (walletprice == 0) {
                                                          _onButtonPressed();
                                                        } else if (total > walletprice) {
                                                          _onButtonPressed();
                                                        } else {
                                                          productModelSec[index].numberofitems++;
                                                          doAddition(index, productModelSec[index].numberofitems, 0);
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
                                  ],
                                ),
                                Divider(
                                  height: 5.0,
                                  color: Colors.black26,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
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
                        if (TotalItems == 0) {
                          Toast.show("Please select any product...", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewCart()),
                          );
                        }
                      },
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
        ],
      ),
    );
  }
}
