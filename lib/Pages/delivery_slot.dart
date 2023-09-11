import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliverySlot extends StatefulWidget {
  @override
  _DeliverySlotState createState() => _DeliverySlotState();
}

class _DeliverySlotState extends State<DeliverySlot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Delivery Slot'),
        ),
      ),
      backgroundColor: Color(0xffFFFFFF),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: Image.asset(
                  "images/logos/tableimage.png", //delivoo logo
                  height: 200.0,
                  width: 200,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Table(
                      // defaultColumnWidth:  FixedColumnWidth(120.0),
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(4),
                      },
                      border: TableBorder.all(
                          color: Colors.grey[300],
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        TableRow(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('SLOT',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4,),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('ORDER TIMINGS',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4,),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('DELIVERY TIMINGS',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4,),
                              ]),
                        ]),
                        TableRow(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('1',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4,),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('12 PM - 09 PM',
                                    style: TextStyle(fontSize: 12.0)),
                                Text('(Same Day)',
                                    style: TextStyle(fontSize: 12.0)),
                                SizedBox(height: 4,),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('06 AM - 08 AM ',
                                    style: TextStyle(fontSize: 12.0)),
                                Text('(Next Day)',
                                    style: TextStyle(fontSize: 12.0)),
                                SizedBox(height: 4,),
                              ]),
                        ]),
                        TableRow(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('2',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4,),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('09 PM - 12 PM ',
                                    style: TextStyle(fontSize: 12.0)),
                                Text('(Next Day)',
                                    style: TextStyle(fontSize: 12.0)),
                                SizedBox(height: 4,),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 4,),
                                Text('03 PM - 05 PM',
                                    style: TextStyle(fontSize: 12.0)),
                                Text('(Same Day)',
                                    style: TextStyle(fontSize: 12.0)),
                                SizedBox(height: 4,),
                              ]),
                        ]),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
