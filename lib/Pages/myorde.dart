import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyOrdeActivity extends StatefulWidget {
  @override
  _MyOrdeActivityState createState() => _MyOrdeActivityState();
}

class OrderHistory {
  final String created_at;
  final String invoice_num;
  final String order_code;
  final String order_status_id;
  final String total_quantity;
  final String total_amt;
  final String id;

  OrderHistory(this.created_at, this.invoice_num, this.order_code,
      this.order_status_id, this.total_quantity, this.total_amt, this.id);

  OrderHistory.fromJson(Map<String, dynamic> json)
      : created_at = json['created_at'],
        invoice_num = json['invoice_num'],
        order_code = json['order_code'],
        order_status_id = json['order_status_id'],
        total_quantity = json['total_quantity'],
        total_amt = json['total_amt'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'created_at': created_at,
        'invoice_num': invoice_num,
        'order_code': order_code,
        'order_status_id': order_status_id,
        'total_quantity': total_quantity,
        'total_amt': total_amt,
        'id': id,
      };
}

var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

class _MyOrdeActivityState extends State<MyOrdeActivity> {
  var order_history = new List<OrderHistory>();
  String UserID;

  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    print("UserID = " + UserID);
    setState(() {
      _runapi();
    });
  }

  _runapi() async {
    print("UserID 2 = " + UserID);
    String objText = '{"cdblock": "order_history", "cust_id": ' + UserID + '}';
    var url = baseUrl + "?req=" + objText;
    print("url = " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("url92 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("url93 = " + rest.toString());

        order_history =
            rest.map((tagJson) => OrderHistory.fromJson(tagJson)).toList();
        print("url933 = " + order_history[0].created_at);
//        addStringToSF(tagObjs[0].cur_balance);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
  }

  Column _buildItemsForListView(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: InkWell(
              onTap: () {

              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              order_history[index].invoice_num,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              order_history[index].created_at,
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff535252)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            alignment: Alignment.topRight,
                            child: Text(
                              order_history[index].order_status_id,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff7ac81d),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            alignment: Alignment.topRight,
                            child: Text(
                              order_history[index].total_quantity +
                                  " Items | ₹ " +
                                  order_history[index].total_amt,
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff535252)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Orders',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 1, 10),
            height: 450,
            alignment: Alignment.topLeft,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: order_history.length,
                    itemBuilder: _buildItemsForListView),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
