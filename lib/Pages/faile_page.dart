import 'dart:convert';
import 'package:delivoo/Pages/wallet_history.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Transaction_Failed_Page extends StatefulWidget {
  final String message;
  Transaction_Failed_Page({this.message});
  @override
  _Transaction_Failed_PageState createState() => _Transaction_Failed_PageState();
}

class _Transaction_Failed_PageState extends State<Transaction_Failed_Page> {
  int _counter = 05;
  Timer _timer;
  String Message;
  _startTimer() {
    //shows timer
    _counter = 05; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WalletHistoryActivity()),
          );
        }
        // _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
    Message = widget.message;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.topRight,
                child: Container(margin: const EdgeInsets.fromLTRB(0, 40, 15, 0),child: Text(
                  _counter.toString() + "Sec",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),)

            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: Image.asset('images/icons/savethreeimg.png'),
                ),

                Center(child:     Text("Message:- "+Message,style: TextStyle(color: Colors.grey),),),



              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ButtonTheme(
              minWidth: double.infinity,
              height: 100.0,
              child: RaisedButton(
                color: const Color(0xffff791a),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletHistoryActivity()),
                  );
                },
                child: Text("Wallet",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
