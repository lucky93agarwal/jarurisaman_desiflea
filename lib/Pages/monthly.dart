import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';


class MonthlyActivity extends StatefulWidget {
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
  final String P_percentage;


  MonthlyActivity(
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
        this.productQty,
      this.P_percentage});
  @override
  _MonthlyActivityState createState() => _MonthlyActivityState();
}

class _MonthlyActivityState extends State<MonthlyActivity> {
  void getDate() {
    var date = DateTime.now();
    DateFormat dateFormat = DateFormat("MMMM yyyy");
    var date1s = new DateTime(date.year, date.month, date.day + 1);
    fulldate = dateFormat.format(date1s);



    DateFormat dateFormats = DateFormat("dd");
    dateaaa = dateFormats.format(date1s);
    dateaaa = dateaaa+"st "+fulldate;


    day = DateFormat('EEEE').format(date);

    DaysText = day+", "+dateaaa;



///// 1 day increment
    DateFormat dateFormatss = DateFormat("MMMM yyyy");
    var date1 = new DateTime(date.year, date.month, date.day + 2);
    fulldate1 = dateFormatss.format(date1);



    DateFormat dateFormatsss = DateFormat("dd");
    dateaaa1 = dateFormatsss.format(date1);
    dateaaa1 = dateaaa1+"st "+fulldate1;


    day1 = DateFormat('EEEE').format(date1);

    //// 2 day increment
    DateFormat dateFormatssx = DateFormat("MMMM yyyy");
    var date1x = new DateTime(date.year, date.month, date.day + 3);
    fulldate2 = dateFormatssx.format(date1x);



    DateFormat dateFormatsssx = DateFormat("dd");
    dateaaa2 = dateFormatsssx.format(date1x);
    dateaaa2 = dateaaa2+"st "+fulldate2;


    day2 = DateFormat('EEEE').format(date1x);

    /// 3 day increament
    DateFormat dateFormatssxd = DateFormat("MMMM yyyy");
    var date1xd = new DateTime(date.year, date.month, date.day + 4);
    fulldate3 = dateFormatssxd.format(date1xd);



    DateFormat dateFormatsssxd = DateFormat("dd");
    dateaaa3 = dateFormatsssxd.format(date1xd);
    dateaaa3 = dateaaa3+"st "+fulldate3;


    day3 = DateFormat('EEEE').format(date1xd);


    /// 4 day increament
    DateFormat dateFormatssxd4 = DateFormat("MMMM yyyy");
    var date1xd4 = new DateTime(date.year, date.month, date.day + 5);
    fulldate4 = dateFormatssxd4.format(date1xd4);



    DateFormat dateFormatsssxd4 = DateFormat("dd");
    dateaaa4 = dateFormatsssxd4.format(date1xd4);
    dateaaa4 = dateaaa4+"st "+fulldate4;


    day4 = DateFormat('EEEE').format(date1xd4);


    /// 5 day increament
    DateFormat dateFormatssxd5 = DateFormat("MMMM yyyy");
    var date1xd5 = new DateTime(date.year, date.month, date.day + 6);
    fulldate5 = dateFormatssxd5.format(date1xd5);



    DateFormat dateFormatsssxd5 = DateFormat("dd");
    dateaaa5 = dateFormatsssxd5.format(date1xd5);
    dateaaa5 = dateaaa5+"st "+fulldate5;


    day5 = DateFormat('EEEE').format(date1xd5);




    /// 6 day increament
    DateFormat dateFormatssxd6 = DateFormat("MMMM yyyy");
    var date1xd6 = new DateTime(date.year, date.month, date.day + 7);
    fulldate6 = dateFormatssxd6.format(date1xd6);



    DateFormat dateFormatsssxd6 = DateFormat("dd");
    dateaaa6 = dateFormatsssxd6.format(date1xd6);
    dateaaa6 = dateaaa6+"st "+fulldate6;


    day6 = DateFormat('EEEE').format(date1xd6);

  }
  String dateaaa;
  String fulldate;
  String day;

  String dateaaa1;
  String fulldate1;
  String day1;

  String dateaaa2;
  String fulldate2;
  String day2;

  String dateaaa3;
  String fulldate3;
  String day3;


  String dateaaa4;
  String fulldate4;
  String day4;



  String dateaaa5;
  String fulldate5;
  String day5;



  String dateaaa6;
  String fulldate6;
  String day6;


  int num1 =1;
  int num2 =1;
  int num3 =1;
  int num4 =1;
  int num5 =1;
  int num6 =1;
  int num7 =1;
  bool checkone = false;

  bool checkonetwo = false;

  bool Onebtn = true;
  bool Twobtn = false;
  bool Threebtn = false;


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
  String p_percentage;

  String WalletPrice;
  String productqty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    P_ID = widget.P_Id;
    P_Name = widget.P_name;
    // P_Description = widget.P_description;
    P_Image1 = widget.P_image1;
    // P_VerShortDesc = widget.P_verShortDesc;
    P_VerCapacity = widget.P_verCapacity;
    P_VerUnit = widget.P_verUnit;

    P_VerPrice = widget.P_verPrice;
    P_OfferPrice = widget.P_offerPrice;
    WalletPrice = widget.walletprice;
    productqty = widget.productQty;


    double off = double.parse(P_VerPrice) - double.parse(P_OfferPrice);
    double per = (off * 100) / double.parse(P_VerPrice);

    P_off = per.toStringAsFixed(2).toString();
   // p_percentage= widget.P_percentage;


    // print("LUckyYUYUBhai"+"  P_ID = "+P_ID);
    // print("LUckyYUYUBhai"+"  P_Name = "+P_Name);
    // // print("LUckyYUYUBhai"+"  P_Description = "+P_Description);
    // print("LUckyYUYUBhai"+"  P_Image1 = "+P_Image1);
    // // print("LUckyYUYUBhai"+"  P_VerShortDesc = "+P_VerShortDesc);
    // print("LUckyYUYUBhai"+"  P_VerCapacity = "+P_VerCapacity);
    // print("LUckyYUYUBhai"+"  P_VerUnit = "+P_VerUnit);
    //
    //
    // print("LUckyYUYUBhai"+"  P_VerPrice = "+P_VerPrice);
    // print("LUckyYUYUBhai"+"  P_OfferPrice = "+P_OfferPrice);
    // print("LUckyYUYUBhai"+"  WalletPrice = "+WalletPrice);
    // print("LUckyYUYUBhai"+"  productqty = "+productqty);
    // print("LUckyYUYUBhai"+"  p_percentage = "+p_percentage);

    getDate();
  }

  int Total = 0;


  String DaysText = "";

  String Price = "";
  String OneDaysText="7 Days";


  bool btnonestring= true;
  bool btntwostring= true;
  bool btnthreestring= true;
  bool btnfourstring= true;
  bool btnfivestring= true;
  bool btnsixstring= true;
  bool btnsevenstring= true;


  String SlotString =  "03 PM - 05 PM";

  bool btnoneSlot= true;
  bool btntwoSlot= false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 92,
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.network(
                          P_Image1,
                          width: 70,
                          height: 70,
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "  "+P_Name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Raleway',
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text("  "+productqty,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[500])),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Text('  \₹' + P_OfferPrice + "  ",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black)),
                                    Text(
                                      '\₹' + P_VerPrice,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[500],
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      "  " + P_off + "% OFF",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[500],
                                      ),
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
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "     SET FREQUENCY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 30,
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: Row(
                    children: [
                      InkWell(onTap: (){
                        setState(() {
                          OneDaysText="7 Days";
                          Onebtn = true;
                          Twobtn = false;
                          Threebtn = false;
                        });
                      },child: Onebtn?Container(
                        height: 28,
                        width: 70,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFFE8F4F8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "7 Days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ):
                      Container(
                        height: 28,
                        width: 70,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFFAFEEEE),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "7 Days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),),
                      InkWell(onTap: (){
                        setState(() {
                          OneDaysText="15 Days";

                          Onebtn = false;
                          Twobtn = true;
                          Threebtn = false;
                        });
                      },child: Twobtn?Container(
                        height: 28,
                        width: 130,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFFE8F4F8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "15 Days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ):
                      Container(
                        height: 28,
                        width: 130,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFFAFEEEE),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "15 Days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),),

                      InkWell(onTap: (){
                        setState(() {
                          OneDaysText="30 Days";
                          Onebtn = false;
                          Twobtn = false;
                          Threebtn = true;
                        });
                      },child: Threebtn?Container(
                        height: 28,
                        width: 130,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFFE8F4F8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "30 Days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ):
                      Container(
                        height: 28,
                        width: 130,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Color(0xFFAFEEEE),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "30 Days",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),),



                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "     SET DELIVERY TIME",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 30,
                  margin: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                  child: Row(
                    children: [
                      InkWell(onTap: (){
                        setState(() {
                          SlotString="06 AM - 08 AM";
                          btnoneSlot = true;
                          btntwoSlot = false;

                        });
                      },child: btnoneSlot?Container(
                        height: 28,
                        width: 180,
                        margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                        color: Color(0xFFE8F4F8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Morning 06 AM - 08 AM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ):
                      Container(
                        height: 28,
                        width: 180,
                        margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                        color: Color(0xFFAFEEEE),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                             "Morning 06 AM - 08 AM" ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),),
                      InkWell(onTap: (){
                        setState(() {
                          SlotString="03 PM - 05 PM" ;

                          btnoneSlot = false;
                          btntwoSlot = true;

                        });
                      },child: btntwoSlot?Container(
                        height: 28,
                        width: 180,
                        margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                        color: Color(0xFFE8F4F8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Evening 03 PM - 05 PM" ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ):
                      Container(
                        height: 28,
                        width: 180,
                        margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                        color: Color(0xFFAFEEEE),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Evening 03 PM - 05 PM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ),
                      ),),





                    ],
                  ),
                ),





                Row(
                  children: [

                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 20, 5, 10),
                      child: Text(
                        "SET QUANTITY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            fontFamily: 'Raleway',
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 25,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: Text(
                                "MON",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                "TUE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                "WED",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                "THU",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                "FRI",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                "SAT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                "SUN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num1.toString()=="0"){

                                  }else {
                                    num1= num1-1;
                                  }

                                });

                              },child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),

                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num2.toString()=="0"){

                                  }else {
                                    num2= num2-1;
                                  }

                                });},child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num3.toString()=="0"){

                                  }else {
                                    num3= num3-1;
                                  }

                                });},child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num4.toString()=="0"){

                                  }else {
                                    num4= num4-1;
                                  }

                                });},child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num5.toString()=="0"){

                                  }else {
                                    num5= num5-1;
                                  }

                                });},child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num6.toString()=="0"){

                                  }else {
                                    num6= num6-1;
                                  }

                                });},child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  if(num7.toString()=="0"){

                                  }else {
                                    num7= num7-1;
                                  }

                                });},child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num1).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num2).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num3).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num4).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num5).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num6).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Text(
                                (num7).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num1= num1+1;
                                });

                                },child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),

                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num2= num2+1;
                                });},child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num3= num3+1;
                                });},child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num4= num4+1;
                                });},child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num5= num5+1;
                                });},child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num6= num6+1;
                                });},child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                            Expanded(
                              flex: 14,
                              child: InkWell(onTap: (){
                                setState(() {
                                  num7= num7+1;
                                });},child: Text(
                                "+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue),
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [

                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                      child: Text(
                        "SET STARTING DATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [

                    InkWell(onTap: (){
                      setState(() {
                        if(checkone){
                          checkone = false;
                        }else{
                          checkone = true;
                        }
                        DaysText = day+", "+dateaaa;

                        btntwostring = true;
                        btnthreestring = true;
                        btnfourstring = true;
                        btnfivestring = true;
                        btnsixstring = true;
                        btnsevenstring = true;
                        btnonestring= false;
                      });
                    },child:  btnonestring?




                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                      child: Text(
                        day+", "+dateaaa,
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.black),
                      ),
                    )
                        :
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                      child: Text(
                        day+", "+dateaaa,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )







                      ,





                    ),

                    InkWell(onTap: (){
                      setState(() {
                        if(checkone){
                          checkone = false;
                        }else{
                          checkone = true;
                        }
                        DaysText = day+", "+dateaaa;
                        btnonestring= false;
                        btntwostring = true;
                        btnthreestring = true;
                        btnfourstring = true;
                        btnfivestring = true;
                        btnsixstring = true;
                        btnsevenstring = true;
                      });
                    },child: checkone ? Container( margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),child: Image.asset("images/icons/uparrow.png",height: 10,width: 10,),)
                      :Container( margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),child: Image.asset("images/icons/downarry.png",height: 10,width: 10,),),
                    ),

                  ],
                ),

                Column(children: [
                  checkone? Column(children: [
                    Row(
                      children: [
                        InkWell(onTap: (){
                          setState(() {
                            DaysText = day1+", "+dateaaa1;
                            btnonestring= true;
                            btntwostring = false;
                            btnthreestring = true;
                            btnfourstring = true;
                            btnfivestring = true;
                            btnsixstring = true;
                            btnsevenstring = true;
                          });

                        },child: btntwostring
                            ?
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day1+", "+dateaaa1,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black),
                          ),
                        ):
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day1+", "+dateaaa1,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),


                        ),

                      ],
                    ),
                    Row(
                      children: [
                        InkWell(onTap: (){
                          setState(() {
                            DaysText = day2+", "+dateaaa2;
                            btnonestring= true;
                            btntwostring = true;
                            btnthreestring = false;
                            btnfourstring = true;
                            btnfivestring = true;
                            btnsixstring = true;
                            btnsevenstring = true;
                          });

                        },child: btnthreestring?
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day2+", "+dateaaa2,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black),
                          ),
                        ):
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day2+", "+dateaaa2,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        InkWell(onTap: (){

                          setState(() {
                            DaysText = day3+", "+dateaaa3;
                            btnonestring= true;
                            btntwostring = true;
                            btnthreestring = true;
                            btnfourstring = false;
                            btnfivestring = true;
                            btnsixstring = true;
                            btnsevenstring = true;
                          });
                        },child: btnfourstring?
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day3+", "+dateaaa3,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black),
                          ),
                        ):
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day3+", "+dateaaa3,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        InkWell(onTap: (){
                          setState(() {
                            DaysText = day4+", "+dateaaa4;
                            btnonestring= true;
                            btntwostring = true;
                            btnthreestring = true;
                            btnfourstring = true;
                            btnfivestring = false;
                            btnsixstring = true;
                            btnsevenstring = true;
                          });

                        },child:
    btnfivestring?

                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day4+", "+dateaaa4,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black),
                          ),
                        ):
    Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
      child: Text(
        day4+", "+dateaaa4,
        style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    ),
                        ),


                      ],
                    ),
                    Row(
                      children: [

                        InkWell(onTap: (){
                          setState(() {
                            DaysText = day5+", "+dateaaa5;
                            btnonestring= true;
                            btntwostring = true;
                            btnthreestring = true;
                            btnfourstring = true;
                            btnfivestring = true;
                            btnsixstring = false;
                            btnsevenstring = true;
                          });

                        },child: btnsixstring?
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day5+", "+dateaaa5,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black),
                          ),
                        ):
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day5+", "+dateaaa5,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(onTap: (){
                          setState(() {
                            DaysText = day6+", "+dateaaa6;
                            btnonestring= true;
                            btntwostring = true;
                            btnthreestring = true;
                            btnfourstring = true;
                            btnfivestring = true;
                            btnsixstring = true;
                            btnsevenstring = false;
                          });

                        },child: btnsevenstring?
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day6+", "+dateaaa6,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black),
                          ),
                        ):
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                          child: Text(
                            day6+", "+dateaaa6,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ),
                      ],
                    ),
                  ],) : Container(),
                ],),






              ],
            ),
          ),
          Expanded(
            flex: 08,
            child: InkWell(onTap: (){
              Total = num1 + num2 + num3 + num4 + num5 + num6 + num7;

              if(Onebtn){
                Total = Total*4;
                int TotalPricenew =
                (double.parse(P_OfferPrice) *
                    Total)
                    .toInt();
                Price = TotalPricenew.toString();
              }else if(Twobtn){
                Total = Total*2;

                int TotalPricenew =
                (double.parse(P_OfferPrice) *
                    Total)
                    .toInt();
                Price = TotalPricenew.toString();
              }else if(Threebtn){

                int TotalPricenew =
                (double.parse(P_OfferPrice) *
                    Total)
                    .toInt();
                Price = TotalPricenew.toString();
              }



              if(int.parse(WalletPrice) < int.parse(Price)){
                Toast.show("Please add a money", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              }



              String Url = '{"id":"'+P_ID+'", "button":"'+OneDaysText+'", "mon":"'+num1.toString()+'", "tue":"'+num2.toString()+'", "wed":"'+num3.toString()+'", "thu":"'+num4.toString()+'", "fri":"'+num5.toString()+'", "sat":"'+num6.toString()+'", "sun":"'+num7.toString()+'", "Day":"'+DaysText.toString()+'", "Slot":"'+SlotString.toString()+'"}';

              print("newLuckyYUYUData   url = "+Url+" WalletPrice  =  "+WalletPrice);
              // Toast.show("QTY = "+Total.toString()+" Price= "+Price.toString()+" Url = "+Url, context,
              //     duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            },child:  Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xffff791a),
              child: Center(child: Text(
                "Save Recurring Order",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),),
            ),),




          ),
        ],
      ),
    );
  }


}
