import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class Texts {
  final String error;
  final String title;
  final String description;

  Texts(this.error, this.title, this.description);

  Texts.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'error': error,
        'title': title,
        'description': description,
      };
}

class _WebViewExampleState extends State<WebViewExample> {
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  String Description = "";
  String title = "";

  @override
  void initState() {
    // TODO: implement initState
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
                    "PRIVACY POLICY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Information Gathering and Use",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                Text(
                  "We may collect information from you in a number of ways, for example when you Sign up or When you place an order.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "We may collect the following personally identifiable information about you: Name including first and last name, alternate email address, mobile phone number and contact details, Postal code, Demographic profile (like your age, gender, occupation, education, address etc.) and information about the pages on the site you visit/access, the links you click on the site, the number of times you access the page and any such browsing information.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "We won’t collect or record your personal information unless you choose to give it us.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Use of Personal Information",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "We use the information you give us in the following ways:",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "1. To make sure we have an accurate record of all the orders we receive.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "2. To email you with news and information about DESIFLEA and our campaigns.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "3. To make sure you are receiving the most appropriate and relevant information for you.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Privacy of our email lists",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "1. Individuals who join our mailing lists via our website/app or through our campaigning engagements are added to our email database. We do not sell, rent, loan, trade, or lease the addresses on our lists to anyone.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Cookie Policy",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "1. Cookies are pieces of electronic information which will be sent by DesiFlea when you use our web site. These will be placed in your computer’s hard disk and enable us to recognise you as a user when you next visit.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "2. You can configure your browser so that it responds to cookies the way you deem fit. For example, you make want to accept all cookies, reject them all or get notified when a cookie is sent. Please check your browser’s settings to modify cookie behaviour as per your individual behaviour..",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "3. Please note that if you disable the use of cookies on your web browser or remove or reject specific cookies from our website or linked sites then you may not be able to use the website as it is intended.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
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
                  "1. DESIFLEA uses well-recognised and proven technology for payments. Payment information is transferred by the use of an SSL connection which offers the highest degree of security that your browser is able to support.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "2. Several layers of built-in security, including an advanced firewall system, encryption of credit card numbers, and use of passwords, protect the collected information.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "External Web Services",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "1. We use a number of external web services on our site to display content within our web pages. For example, to display video we use YouTube. As with the social buttons, we cannot prevent these sites, or external domains, from collecting information on your use of the content we embed on our site.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "2. The Site contains links to other websites for the benefit of it’s visitors. This Privacy and Policy does not apply to such other websites. DESIFLEA is not expressly or impliedly responsible for, or liable to any loss or damage caused to you by the collection, use and retention of Personal Information by such website in any manner whatsoever. It is important that you review the privacy and policies of all websites you visit before you disclose any information to such websites.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Changes to Privacy and Policy",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "1. As and when the need arises, DESIFLEA may alter its privacy and policy in accordance with the latest technology and trends. We strive to provide you with timely notice of these changes. You may reach out to us if you have any queries about any changes made to our practices.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "1. If you have any questions at all about our privacy and policy, please email us: info@desiflea.com",
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
