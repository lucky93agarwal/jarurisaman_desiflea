

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Order_Details_Activity extends StatefulWidget {
  @override
  _Order_Details_ActivityState createState() => _Order_Details_ActivityState();
}

class _Order_Details_ActivityState extends State<Order_Details_Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Order Details',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
          body: Column(
            children: [
              Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                "order_history[index].invoice_num",
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
                               " order_history[index].created_at",
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
                                "order_history[index].order_status_id",
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
//                                order_history[index].total_quantity+" Items | ₹ "+order_history[index].total_amt,
                              "data",
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
            ],
          ),
    );
  }
}
