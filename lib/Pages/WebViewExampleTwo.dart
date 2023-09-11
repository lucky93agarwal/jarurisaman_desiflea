import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';

class WebViewExampleTwo extends StatefulWidget {
  @override
  _WebViewExampleTwoState createState() => _WebViewExampleTwoState();
}

class _WebViewExampleTwoState extends State<WebViewExampleTwo> {
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  String Description = "";
  String title = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Website Terms Of Use",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                Text(
                  "PLEASE READ THESE TERMS OF USE CAREFULLY. BY ACCESSING OR USING THE SERVICES PROVIDED BY DESIFLEA THRU THIS WEBSITE OR THROUGH THE DESIFLEA APP (TOGETHER REFERRED HEREINAFTER AS THE , YOU AGREE TO BE BOUND BY THE TERMS DESCRIBED HEREIN AND ALL TERMS INCORPORATED BY REFERENCE. IF YOU DO NOT AGREE TO ALL OF THESE TERMS, DO NOT USE THE SERVICES PROVIDED BY THE PLATFORM.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Desiflea E-Wallet (issued by Doorstep Retail Solutions Private Limited ) Terms & Conditions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "We won’t collect or record your personal information unless you choose to give it us.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "These terms and conditions (“Terms and Conditions”) govern your use of the Prepaid Desiflea E-Wallet Desiflea Wallet created on the Platform for your usage towards ordering Desiflea services. This Desiflea Wallet is the property of Doorstep Retail Solutions Private Limited (“Desiflea”) to whom to whom it must be surrendered, upon request. The following terms and conditions shall apply to the prepaid account of your Desiflea Wallet. By using the Desiflea Wallet, you agree to the below mentioned Terms and Conditions. Please ensure that you have read carefully and understood these Terms and Conditions before using your Desiflea Wallet and also request you to keep a copy of these Terms and Conditions for your records. You further agree that by using the Desiflea Wallet, you confirm that you have read, understood and accepted the detailed Terms and Conditions of the Desiflea Wallet.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Eligibility",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "To be eligible for the Desiflea Wallet membership, you should be competent to enter into a contract i.e. you should have attained the age of majority according to the Indian law. Desiflea Wallet is not targeted towards, nor intended for use by anyone who has not attained the age of majority. Any person under the age of 18, may only use the Desiflea Wallet under the supervision of a parent or legal guardian who agrees to be bound by these Terms and Conditions.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "About Your Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Desiflea Wallet is issued to you by Desiflea. It allows you to load a rupee value onto your Desiflea Wallet for use only on on Desiflea Platform. The value associated with the Desiflea Wallet is not insured or guaranteed by any person or entity.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "The rupee value that you load onto your Desiflea Wallet is a prepayment only for purchasing the goods and availing the services on Desiflea Platform in India unless otherwise specified.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Desiflea Wallet can be loaded on Desiflea Platform using either cash / credit card / debit card / upi / Internet Banking / any other RBI approved e-wallets managed and governed by other private or government entities . One Desiflea Wallet cannot be reloaded by using any other registered/unregistered Desiflea Wallet.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Desiflea reserves the right not to accept any Desiflea Wallet or otherwise limit use of a Desiflea Wallet if we reasonably believe that the use is unauthorized, fraudulent or otherwise unlawful. Further, misuse of the Desiflea Wallet or its benefits in any manner may result in disablement of the Desiflea Wallet and/or withdrawal of benefits at the sole discretion of Desiflea. Please maintain the Desiflea Wallet safely and securely.",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Security & Protection of Data",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Desiflea Wallet is automatically created and enabled as soon as you register for Desiflea Platform’s services while accepting these Terms and Conditions. The wallet gets activated by loading money in it either through cash / credit card / debit card / upi / Internet Banking / any other RBI approved e-wallets managed and governed by other private or government entities by visiting the Desiflea website or Desiflea mobile app. Desiflea Wallet can be used as a mode of payment, whenever the Desiflea Wallet-holder purchases goods or services from Desiflea website or Desiflea mobile app. The minimum amount that must be initially loaded onto your Desiflea Wallet is INR 250 (Rupees Two Hundred Fifty only). The balance on the Desiflea Wallet does not have a validity or expiry period.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Desiflea may change the maximum and minimum amounts at any time by notifying you at the point of recharge, or on the Desiflea website (www.Desiflea.com), and such change shall not constitute an amendment to these Terms and Conditions. No credit card, credit line, overdraft protection or deposit account is associated with a Desiflea Wallet. The balance loaded onto your Desiflea Wallet is non-refundable and may not be exchanged for cash or credit balance unless required by law in India. No interest, dividends or any other earnings on funds deposited to a Desiflea Wallet will accrue or be paid or credited to you by Desiflea..",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "All amounts loaded onto your Desiflea Wallet are held and denominated in Indian Rupees.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Fees and Expiration of Wallet Balances",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Desiflea reserves its right, in its sole discretion and without any prior notice, to impose and/or revise charges/commissions in relation to your use of the Desiflea Wallet. The current charges for your Wallet are provided hereunder , the same are subject to change;",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Receipts and Statements",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Desiflea Wallet holders are not sent statements of itemized transactions on their registered email id from a Desiflea Wallet account. You can check the balance of your Desiflea Wallet or review recent transactions on your Desiflea Wallet by logging into your Desiflea account on www.Desiflea.com. or on the Desiflea mobile app.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "You will need to use your Desiflea Wallet to make purchases for the goods and availing the services on Desiflea Platform. When you use your Desiflea Wallet, you will receive the details of your order and payment in the Account History section of your Desiflea account.. The Shopping Credits section of your Desiflea Account will provide the remaining balance of your Desiflea Wallet. You should check your order and payments details to ensure that your account balance is correct",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Billing Errors, Corrections",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Desiflea reserves the right to correct the balance of your Desiflea Wallet if there is reason to believe that a clerical, billing or accounting error has occurred. If you have questions regarding your transaction history or any correction, or if you dispute any transaction or correction that has been assessed against your Desiflea Wallet, please email your concern at hello@Desiflea.com. Desiflea will conduct an investigation and communicate the results and correct any error that after conducting a thorough investigation in a reasonable time-frame. If no error is found, a suitable explanation shall be communicated to you. Desiflea shall have no liability for any billing error unless you provide a notice within 30 days of the date of the transaction in question. You are requested to monitor your transactions and account balances accurately.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Registration, Liability for Unauthorized Transactions",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "You are responsible for all transactions associated with your Desiflea Wallet, including transactions claimed to be unauthorised. The Desiflea Wallet does not have a separate authentication password or PIN and can be used to make transactions once you have logged-in to the platform using Mobile Number-Password combination or Mobile number-OTP authentication. The mobile application remains in a state of permanent log-in and anyone with access to your mobile phone can have access to your application and thereafter use your Desiflea Wallet. You agree to take full responsibility of any unintended or unauthorised access to your Desiflea Wallet.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Blocking of Desiflea Wallet:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Desiflea reserves the right to block your Desiflea Wallet and/or discontinue, if Desiflea determines or observes in its sole discretion that there has been any fraudulent or unauthorized activities through your Desiflea Wallet.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Privacy Statement",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "You hereby authorise Desiflea to disclose your information to Government authorities or to competent authorities or to credit bureaus or to other third persons, to comply with the obligation under the law. You also authorise Desiflea to use your information for offering product and services to you, including from its associates/partners unless specified otherwise.For information concerning how we collect, use and disclose information concerning the Desiflea Wallet and how to select privacy preferences regarding certain promotional communications, you should refer to our privacy statement mentioned on our website - https://www.Desiflea.com/privacy-policy.html",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
