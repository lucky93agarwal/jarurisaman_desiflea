import 'package:delivoo/Pages/order_track_activity.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/order_placed_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:toast/toast.dart';
import 'package:shimmer/shimmer.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class Citys {
  final String created_at;
  final String invoice_num;
  final String order_code;
  final String order_status_id;
  final String total_quantity;
  final String total_amt;
  final String id;
  final String msg;

  Citys(
      this.created_at,
      this.invoice_num,
      this.order_code,
      this.order_status_id,
      this.total_quantity,
      this.total_amt,
      this.id,
      this.msg);

  Citys.fromJson(Map<String, dynamic> json)
      : created_at = json['created_at'],
        invoice_num = json['invoice_num'],
        order_code = json['order_code'],
        order_status_id = json['order_status_id'],
        total_quantity = json['total_quantity'],
        total_amt = json['total_amt'],
        id = json['id'],
        msg = json['msg'];

  Map<String, dynamic> toJson() => {
        'created_at': created_at,
        'invoice_num': invoice_num,
        'order_code': order_code,
        'order_status_id': order_status_id,
        'total_quantity': total_quantity,
        'total_amt': total_amt,
        'id': id,
        'msg': msg,
      };
}

var citys = new List<Citys>();

class _OrderPageState extends State<OrderPage> {
  /// database
  final dbhandler = DbStudentMamager.instance;

  String UserID;

  void getUserID() async {
    setState(() {
      MasterSrim = false;
    });
    print("Place Order UserID = ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    print("Place Order UserID = " + UserID);
    _runapi();
  }

  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  bool checkdatafound = false;
  int checkdata = 0;

  _runapi() async {
    String objText =
        '{"cdblock": "order_history", "cust_id": "' + UserID + '"}';
    var url = baseUrl + "?req=" + objText;
    print("Place Order url 22 = " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("url2 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("url3 = " + rest.toString());

        citys = rest.map((tagJson) => Citys.fromJson(tagJson)).toList();
        print("Place Order  length = " + citys.length.toString());

        setState(() {
          MasterSrim = true;
        });
        if (citys[0].msg == "id not found") {
          setState(() {
            checkdatafound = true;
          });

          setState(() {
            checkdata = 0;
          });
        } else {
          setState(() {
            checkdata = 1;
          });
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      MasterSrim = false;
    });
    getUserID();
  }

  //// List Product

  Row _buildItemsForListView(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Order_Track_Activity(
                            created_at: citys[index].created_at,
                            invoice_num: citys[index].invoice_num,
                            order_code: citys[index].order_code,
                            order_status_id: citys[index].order_status_id,
                            total_quantity: citys[index].total_quantity,
                            total_amt: citys[index].total_amt,
                            id: citys[index].id,
                          )));
            },
            child: ListTile(
              title: Text(
                citys[index].invoice_num,
                style: orderMapAppBarTextStyle.copyWith(letterSpacing: 0.07),
              ),
              subtitle: Text(
                citys[index].total_quantity +
                    ' items | \ ₹' +
                    citys[index].total_amt,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 11.7,
                    letterSpacing: 0.06,
                    color: Color(0xffc1c1c1)),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    citys[index].order_status_id,
                    style: orderMapAppBarTextStyle.copyWith(color: kMainColor),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    citys[index].created_at,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: 11.7,
                        letterSpacing: 0.06,
                        color: Color(0xffc1c1c1)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeOrderAccount()),
    );
  }

  bool MasterSrim = false;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          appBar: AppBar(
            title:
                Text('My Orders', style: Theme.of(context).textTheme.bodyText1),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderMapPage(
                  pageTitle: 'Vegetables & Fruits',
                ),
              ),
            ),
            child: MasterSrim
                ? (checkdatafound
                    ? new Center(
                        child: Image.asset(
                          'images/logos/noproduct.png',
                          height: 300,
                          width: 300,
                        ),
                      )
                    : Stack(
                        children: [
                          ListView.builder(
                              padding: EdgeInsets.only(top: 10),
                              itemCount: checkdata == 0 ? 0 : citys.length,
                              itemBuilder: _buildItemsForListView)
                        ],
                      ))
                : new Column(children: [
                  Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              height: 10,
                              width: 60,
                              child: Shimmer.fromColors(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    margin:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              height: 10,
                              width: 100,
                              child: Shimmer.fromColors(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    margin:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 40,child: Container(),),
                      Expanded(
                        flex: 30,
                        child: Column(

                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              height: 10,
                              width: 100,
                              child: Shimmer.fromColors(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    margin:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              height: 10,
                              width: 100,
                              child: Shimmer.fromColors(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    margin:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),),),

              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),
              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),
              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),
              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),

              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),
              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),
              Container(  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),child: Card(child: Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 60,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 40,child: Container(),),
                  Expanded(
                    flex: 30,
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 10,
                          width: 100,
                          child: Shimmer.fromColors(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey,
                                margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),),


            ],),

          ),
        ));
  }
}
