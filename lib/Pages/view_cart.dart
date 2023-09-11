import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Models/ItemListinCart.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/home.dart';
import 'package:delivoo/Models/ProductList.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Pages/order_placed.dart';
import 'dart:convert';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'dart:math';
import 'add_money.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

List<DropdownMenuItem<String>> listDrop = [];

void loadData() {
  listDrop = [];
  listDrop.add(DropdownMenuItem(
    child: Text('1 kg'),
    value: 'A',
  ));
  listDrop.add(DropdownMenuItem(
    child: Text('500 g'),
    value: 'B',
  ));
  listDrop.add(DropdownMenuItem(
    child: Text('250 g'),
    value: 'C',
  ));
}

class Texts {
  final String result;
  final String id;
  final String balance;
  final String time;

  Texts(this.result, this.id, this.time, this.balance);

  Texts.fromJson(Map<String, dynamic> json)
      : result = json['result'],
        id = json['id'],
        time = json['time'],
        balance = json['balance'];

  Map<String, dynamic> toJson() => {
        'result': result,
        'id': id,
        'time': time,
        'balance': balance,
      };
}

class ViewCart extends StatefulWidget {
  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  int _itemCount = 0;
  int _itemCount1 = 0;
  int _itemCount2 = 0;

  /// database
  final dbhandler = DbStudentMamager.instance;

//  var productList = new List<ItemListinCart>();

  var rowall;
  String TotalPrice = "";
  int TPrice;
  var subCategory = new List<ItemListinCart>();


  /// Get All List Form Database
  void firstqueryall() async {
    subCategory.clear();
    setState(() {
      checkdatafound = true;
    });
    print("Rishi Sir Lucky = " + subCategory.length.toString());
    rowall = await dbhandler.firstqueryall();

    rowall.forEach((row) {
      print(row);
      var _list = row.values.toList();
      String id = _list[0].toString();
      String UserID = _list[1].toString();
//      print("UserID = "+UserID.toString());
      String ProductId = _list[2].toString();
//      print("ProductId = "+ProductId.toString());
      String productname = _list[3].toString();
//      print("productname = "+productname.toString());
      String productimg = _list[4].toString();
//      print("productname = "+productimg.toString());
      String Qty = _list[5].toString();
//      print("Qty = "+Qty.toString());
      String ProductPrice = _list[6].toString();
//      print("ProductPrice = "+ProductPrice.toString());
      String itemtype = _list[7].toString();
//      print("itemtype = "+itemtype.toString());
      String TotalPricess = _list[8].toString();

      String productqty = _list[9].toString();
//      print("TotalPricess = "+TotalPricess.toString());
      ItemListinCart itemListinCart = new ItemListinCart(
          id,
          UserID,
          ProductId,
          productname,
          productimg,
          Qty,
          ProductPrice,
          itemtype,
          TotalPricess,
          productqty,
          int.parse(Qty));
      subCategory.add(itemListinCart);

      setState(() {
        checkdatafound = false;
      });

      print("Rishi Sir Lucky = " + subCategory.length.toString());
    });

//    print("dog = "+dbhandler.dogs().toString());

    var price = await dbhandler.firsttotalprice();
    print("Price New = " + price.toString());

    setState(() {
      TotalPrice = price.toString();

      if (TotalPrice == "null") {
        print("price 2223333 = " + TotalPrice.toString());
        TotalPrice = "0";
      }
    });
  }

  int price = 0;

  int TotalItems = 0;
  int indexnew = 0;
  String ProductPrice;
  String ProductId;
  String Qty;
  String TotalPricess;
  String ItemType;
  String ProductName;
  String ProductImg;

  void firstinsertdata() async {
    Toast.show("categoryID = ", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//    print("UserID = "+UserID);
//    print("ProductId = "+ProductId);
//
//    print("Qty = "+Qty);
//    print("ProductPrice = "+ProductPrice);
//
////    print("ItemType = "+ItemType);
//    print("TotalPricess = "+TotalPricess);
    Map<String, dynamic> row = {
      DbStudentMamager.userid: UserID,
      DbStudentMamager.productid: ProductId,
      DbStudentMamager.productname: ProductName,
      DbStudentMamager.productimg: ProductImg,
      DbStudentMamager.qty: Qty,
      DbStudentMamager.price: ProductPrice,
      DbStudentMamager.itemtype: ProductType,
      DbStudentMamager.totalprice: TotalPricess
    };

    final id = await dbhandler.firstinsert(row);

//    print(id);
//    Toast.show("id = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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
      DbStudentMamager.totalprice: TotalPricess
    };

    print("id  = " + ProductId);

    final id = await dbhandler.firstupdate(
        int.parse(ProductId), int.parse(Qty), int.parse(TotalPricess), row);

    print("id update = " + id.toString());
//    Toast.show("id update = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  /// database
  void firstqueryallcartview() async {
    // get all row in the table
    var rowall = await dbhandler.firstqueryall();

    //// check row on the table is null or not
    if (rowall.length.toString() != "0") {
      print('table length 2 = ' + rowall.length.toString());

      int _list = await dbhandler.checkrow(int.parse(ProductId));
      print("row  = " + _list.toString());

      int count = 0;
      count = await dbhandler.checkrow(int.parse(ProductId));
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

  String ProductType;
  String UserID;
  String TotalWallet = "0";

  void doAddition(int index, int qty) {
    setState(() {
//      ItemType =
//      firstinsertdata();
      int TotalPricessss = (double.parse(subCategory[index].price) *
              subCategory[index].numberofitems.toDouble())
          .toInt();
      print("indexnew 2  = " + index.toString());
      print("Qty 2 = " + qty.toString());
//
//      print("indexnew = "+index.toString());
//      print("Qty = "+productList[index].numberofitems.toString());
      ProductType = subCategory[index].itemtype;
      ProductName = subCategory[index].productname;
      ProductImg = subCategory[index].productimg;
      ProductId = subCategory[index].productid;
      ProductPrice = subCategory[index].price;
      Qty = qty.toString();
      TotalPricess = TotalPricessss.toString();

      //// Database api run
      firstqueryallcartview();

      firstqueryall();
    });
  }


  //// get UserID, WalletPrice
  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    TotalWallet = prefs.getString('Wallet');
    walletprice = int.parse(TotalWallet);

//    print('get UserTable count = '+count.toString());
//    print('get UserTable length = '+rowall.length.toString());
  }

  @override
  void initState() {
    super.initState();

    //// get UserID, WalletPrice
    getUserID();
    firstqueryall();

//    futureAlbum = fetchAlbum();
  }

  String Address;
  String Street;
  String Pincode;
  String City;
  String State;

  String Userid;
  String Mobile;
  String Email;
  String Name;

  String Method = "Razorpay";
  List<String> result = [];

  void Walletapirun() async {
    Random random = new Random();
    int number = random.nextInt(10000);
    String objText = '{"cdblock": "wallet_buy", "cust_id": "' +
        Userid +
        '", "transaction_id": "' +
        number.toString() +
        '", "rupees": "' +
        TotalPrice.toString() +
        '"}';
    var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
    var url = baseUrl + "?req=" + objText;
    print("this is new world two responce wallet_buy url ==    ==  " +
        url.toString());

    http.get(url).then((response) {
      setState(() {
        var data = json.decode(response.body);
        print("this is new world two responce wallet_buy ==    ==  " +
            data.toString());
        var rest = data["response"] as List;

        DeleteAPI();
        List<Texts> tagObjs =
            rest.map((tagJson) => Texts.fromJson(tagJson)).toList();
        addStringToSF(tagObjs[0].balance,tagObjs[0].time);
        print("this is new world two  222 Walelt  ==   " +
            tagObjs[0].balance.toString());
      });
    });
  }

  /// aftert delete data goto new page
  addStringToSF(String cur_balance,String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Wallet', cur_balance);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPlaced(P_Time: time)),
    );
  }

  /// after success get in api delete all data in the database
  void DeleteAPI() async {
    print('delete row  2 = ');
    var rowall = await dbhandler.deleteLoginResponse();
    print('delete row = ' + rowall.toString());
  }

  bool checkdatafound = true;

  /// Submit Button api
  void insertdata() async {
    print("this is new world two  ==   ");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Userid = prefs.getString('id');
    Email = prefs.getString('email');
    Mobile = prefs.getString('mobile');
    Name = prefs.getString('name');
    Address = prefs.getString('address');

    City = prefs.getString('city');

    State = '';
    Pincode = '';

    var createDocsss = <String, Object>{};
    String objTextss;
    var rowalls = await dbhandler.firstqueryall();
    List<String> fixedLengthList = new List(rowalls.length);
    rowalls.forEach((row) {
      print(row);

//      fixedLengthList.add(row.toString());
      var _list = row.values.toList();

      if (_list[5].toString() != "0") {
        String ProductId = _list[2].toString();

        String Qty = _list[5].toString();

        TotalItems = TotalItems + int.parse(Qty);
        String PName = _list[3].toString();

        objTextss = '{"id":"' +
            ProductId +
            '","ver_qty":"' +
            Qty +
            '","ver_name":"' +
            PName +
            '"}';
        print("this is new world two = " + objTextss);

        result.add(objTextss);
      }
    });

    var price = await dbhandler.firsttotalprice();

    TotalPrice = price.toString();
    print("this is new world two subCategory = " + result.toString());
    print("this is new world two UserID = " + Userid);
    print("this is new world two Email = " + Email);
    print("this is new world two Mobile = " + Mobile);
    print("this is new world two Name = " + Name);

    print("this is new world two Address = " + Address);
    print("this is new world two City = " + City);
    print("this is new world two State = " + State);
    print("this is new world two Pincode = " + Pincode);

    print("this is new world two TotalPrice = " + TotalPrice);

    var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
//    var url = baseUrl + "Address&address=" + Address + "&street=" + Street +"&pincode=" + Pincode + "&city=" + City + "&state=" + State + "&userid=" + Userid+ "&name=" + Name + "&mobile=" + Mobile+"&oder="+createDocsss.toString();

    String objText = '{"cdblock":"placeOrder","id":"' +
        Userid +
        '","name":"' +
        Name +
        '","mobile":"' +
        Mobile +
        '","address":"' +
        Address +
        '","city":"' +
        City +
        '","state":"' +
        State +
        '","pincode":"' +
        Pincode +
        '","method":"' +
        Method +
        '","rzp_order_id":"' +
        State +
        '","rzp_payment_id":"' +
        Pincode +
        '","rzp_signature":"' +
        Method +
        '","total_qty":"' +
        TotalItems.toString() +
        '","total_amt":"' +
        TotalPrice +
        '","delivery_fee":"' +
        "0" +
        '","order_items":' +
        result.toString() +
        '}';
    print("this is new world two URL 1 ==   " + objText.toString());
    var url = baseUrl + "?req=" + objText;
    print("this is new world two URL ==   " + url.toString());

    http.get(url).then((response) {
      setState(() {
        response.body;
        print("this is new world two responce ==    ==  " + response.body);

        Walletapirun();
      });
    });
  }

  bool _progress = false;
  int walletprice = 0;

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

  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeOrderAccount()),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// clear data in local database
    final menuButton = new PopupMenuButton<int>(
        onSelected: (int i) {},
        itemBuilder: (BuildContext ctx) {},
        child: new InkWell(
          onTap: () {
            setState(() {
              // delete data
              DeleteAPI();
              TotalPrice = "0";
              // clear list
              subCategory.clear();
            });
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Center(
              child: Text(
                "Clear Cart",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ));
    loadData();
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Confirm Order',
                style: Theme.of(context).textTheme.bodyText1),
            actions: [
              menuButton,
            ],
          ),
          body: checkdatafound?
          new Center(child: Image.asset(
            'images/logos/noproductfound.png',
            height: 300,
            width: 300,
          ),)


              :Stack(
            children: <Widget>[
              Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),child: ListView.builder(

                  itemCount: subCategory.length,
                  itemBuilder: (BuildContext context, int blockIdx) {
                    return new Column(
                      children: <Widget>[

                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, top: 30.0, right: 14.0),
                                      child: Image.network(
                                        subCategory[blockIdx].productimg,
//                                scale: 2.5,
                                        height: 93.3,
                                        width: 93.3,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          subCategory[blockIdx].productname,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(subCategory[blockIdx].productqty,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                            '\₹ ' + subCategory[blockIdx].price,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        InkWell(
                                          onTap: () {
//                                        if(productList[index].producttype == 'Single'){}
//                                        _getItems(subCategory[blockIdx].productid);
//                                         showModalBottomSheet(
//                                           context: context,
//                                           builder: (context) {
//                                             return ListView(
//
//                                               children: <Widget>[
//                                                 Container(
//                                                   height: 80.7,
//                                                   color: kCardBackgroundColor,
//                                                   padding: EdgeInsets.all(10.0),
//                                                   child: ListTile(
//                                                     title: Text(
//                                                         subCategory[blockIdx]
//                                                             .productname ,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption
//                                                             .copyWith(
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500)),
//                                                     subtitle: Text(
//                                                         subCategory[blockIdx]
//                                                             .productname ,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption
//                                                             .copyWith(
//                                                             fontSize: 15)),
//                                                     trailing: FlatButton(
//                                                       color: Colors.white,
//                                                       onPressed: () {
//                                                         /*...*/
//                                                       },
//                                                       child: Text(
//                                                         'Add',
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .caption
//                                                             .copyWith(
//                                                             color:
//                                                             kMainColor,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold),
//                                                       ),
//                                                       textTheme: ButtonTextTheme
//                                                           .accent,
//                                                       disabledColor:
//                                                       Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//
//
//                                               ],
//                                             );
//                                           },
//                                         );
                                          },
                                          child: Container(
                                            height: 30.0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            decoration: BoxDecoration(
                                              color: kCardBackgroundColor,
                                              borderRadius:
                                              BorderRadius.circular(30.0),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  subCategory[blockIdx].qty,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: kMainColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 20.0,
                                  bottom: 14,
                                  child: subCategory[blockIdx].numberofitems ==
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
                                            color: kMainColor,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                      textTheme: ButtonTextTheme.accent,
                                      onPressed: () {
                                        TotalItems++;

                                        setState(() {
                                          int total = 0;

                                          double totalproduct =
                                          subCategory[blockIdx]
                                              .numberofitems
                                              .toDouble();
                                          totalproduct =
                                              totalproduct + 1.0;

                                          int TotalPricenew =
                                          (double.parse(subCategory[
                                          blockIdx]
                                              .price) *
                                              1.0)
                                              .toInt();

                                          total = int.parse(TotalPrice);
                                          total = total + TotalPricenew;

                                          if (walletprice == 0) {
                                            _onButtonPressed();
                                          } else if (total >
                                              walletprice) {
                                            _onButtonPressed();
                                          } else {
                                            subCategory[blockIdx]
                                                .numberofitems++;
                                            doAddition(
                                                blockIdx,
                                                subCategory[blockIdx]
                                                    .numberofitems);
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
                                      border:
                                      Border.all(color: kMainColor),
                                      borderRadius:
                                      BorderRadius.circular(30.0),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            indexnew = blockIdx;
                                            setState(() {
                                              subCategory[blockIdx]
                                                  .numberofitems--;
                                              doAddition(
                                                  blockIdx,
                                                  subCategory[blockIdx]
                                                      .numberofitems);
                                            });
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: kMainColor,
                                            size: 20.0,
                                            //size: 23.3,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                            subCategory[blockIdx]
                                                .numberofitems
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption),
                                        SizedBox(width: 8.0),
                                        InkWell(
                                          onTap: () {
                                            indexnew = blockIdx;
                                            setState(() {
                                              int total = 0;

                                              double totalproduct =
                                              subCategory[blockIdx]
                                                  .numberofitems
                                                  .toDouble();
                                              totalproduct =
                                                  totalproduct + 1.0;

                                              int TotalPricenew =
                                              (double.parse(subCategory[
                                              blockIdx]
                                                  .price) *
                                                  1.0)
                                                  .toInt();

                                              total =
                                                  int.parse(TotalPrice);
                                              total =
                                                  total + TotalPricenew;

                                              if (walletprice == 0) {
                                                _onButtonPressed();
                                              } else if (total >
                                                  walletprice) {
                                                _onButtonPressed();
                                              } else {
                                                subCategory[blockIdx]
                                                    .numberofitems++;
                                                doAddition(
                                                    blockIdx,
                                                    subCategory[blockIdx]
                                                        .numberofitems);
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: kMainColor,
                                            size: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),),

              /// Button Click
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: _progress
                          ? new LinearProgressIndicator(
                              backgroundColor: Colors.cyanAccent,
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                            )
                          : new Container(),
                    ),
                    Container(
                      child: _progress
                          ? new BottomBar(
                              text: "Please Wait",
                              onTap: () {},
                            )
                          : new BottomBar(
                              text: "Pay \₹ " + TotalPrice,
                              onTap: () {
                                if (TotalPrice == "0") {
                                } else {
                                  setState(() {
                                    _progress = true;
                                    if (TotalPrice == "Please Wait") {
                                    } else {
                                      insertdata();
                                    }
                                    TotalPrice = "Please Wait";
                                  });
                                }
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget cartOrderItemListTile(
    BuildContext context,
    String title,
    String price,
    int itemCount,
    Function onPressedMinus,
    Function onPressedPlus,
  ) {
    String selected;
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 7.0, top: 13.3),
            child: ListTile(
              // contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: kMainTextColor),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 14.2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: kCardBackgroundColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 16.7,
                              ),
                              iconEnabledColor: Colors.green,
                              value: selected,
                              items: listDrop,
                              hint: Text(
                                '1 kg',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selected = value;
                                });
                              }),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 30.0,
                        //width: 76.7,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: kMainColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: onPressedMinus,
                              child: Icon(
                                Icons.remove,
                                color: kMainColor,
                                size: 20.0,
                                //size: 23.3,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(itemCount.toString(),
                                style: Theme.of(context).textTheme.caption),
                            SizedBox(width: 8.0),
                            InkWell(
                              onTap: onPressedPlus,
                              child: Icon(
                                Icons.add,
                                color: kMainColor,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ))
      ],
    );
  }
}
