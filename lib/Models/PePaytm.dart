import 'package:flutter/material.dart';



import 'Order.dart';
import 'PaymentScreen.dart';

class PePaytm {
  final String paymentURL;

  PePaytm(
      {this.paymentURL =
      "https://us-central1-payments-testing-5fc15.cloudfunctions.net/customFunctions/payment"});

  makePayment(context, {Order order}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          order: order,
          paymentURL: paymentURL,
        ),
      ),
    );
  }
}