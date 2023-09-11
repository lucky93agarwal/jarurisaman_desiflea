import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';

class OrderPlaced extends StatefulWidget {
  final String P_Time;
  OrderPlaced({this.P_Time});
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  String formattedDate = "";
  String datess = "";
  String timeStamp = "";

  String Time_Slot = "";


  String Line = "";

  String setTextindata = "";

  void getTime() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    timeStamp = DateFormat('HHmm').format(now);

    String tomorrowAsString = DateFormat('EEE d MMM').format(now);

    final nows = DateTime.now();
    final lastMidnight = new DateTime(nows.year, nows.month, nows.day + 1);
    datess = DateFormat('dd-MMM-yyyy').format(lastMidnight);
    // print("current date lastMidnight = "+lastMidnight.toString());

    print("current date datess = " + datess.toString());
    print("current date tomorrowAsString = " + tomorrowAsString.toString());

    int currenttime = int.parse(timeStamp);

    print("current date = " + currenttime.toString());

    currenttime = 1300;
    // currenttime= 2101;
    // currenttime= 0001;
    //// 12 subha and rat 9 bje tk
    if (currenttime >= 1200 && currenttime <= 2100) {
      // date change
      // next day = datess
      setTextindata =
          "Your order will be delivered between 06:00 AM to 08:00 AM on " +
              datess;
      print("current date = " + setTextindata.toString());
    } else {
      // same day
      if (currenttime > 2100 && currenttime < 2400) {
        setTextindata =
            "Your order will be delivered between 06:00 AM to 08:00 AM on " +
                datess;
      } else {
        setTextindata =
            "Your order will be delivered between 03:00 PM to 05:00 PM on " +
                tomorrowAsString;
      }

      print("current date = " + setTextindata.toString());
    }

  }

  bool check_internet = false;

  getData() async {
    _startTimer();
    try {

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          check_internet = true;
        });

        print('Lucky connected');
      }
    } on SocketException catch (_) {
      setState(() {
        check_internet = false;
      });

      print('Lucky not connected');
    }
  }

  int _counter = 180;
  Timer _timer;


  _startTimer() {
    //shows timer
    _counter = 180; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
        getData();
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Line = widget.P_Time;
    // _startTimer();
    // getData();
    //getTime();
  }

  /// check connection
  /// check connection
  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeOrderAccount()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child:
        // check_internet
        //     ?
        new Scaffold(
                body: Column(
                  children: <Widget>[
                    Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(60.0),
                      child: Image.asset(
                        'images/orderplaceimg.png',
                        height: 265.7,
                        width: 260.7,
                      ),
                    ),
                    Text(
                      'Order Placed !!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 23.3, color: kMainTextColor),
                    ),
                    Text(
                      '\n\nThank you for choosing us to serve.\n' +
                          "Your order will be delivered between "+Line  +
                          '\n\n',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: kDisabledColor),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    BottomBar(
                        text: 'My Orders',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPage()),
                          );
                        }
//                insertdata(),

                        )
                  ],
                ),
              )
            // : new Scaffold(
            //     backgroundColor: Colors.black54,
            //     body: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Center(
            //           child: Image.asset("images/icons/netwrok.png",
            //             height: 150,
            //             width: 150,),
            //         ),
            //         Center(
            //           child: Text("No Internet",
            //               style: TextStyle(color: Colors.lightBlueAccent)),
            //         ),
            //       ],
            //     ),
            //   )
    );
  }
}
