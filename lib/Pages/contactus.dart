import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsActivity extends StatefulWidget {
  @override
  _ContactUsActivityState createState() => _ContactUsActivityState();
}

_launchURL(String toMailId, String subject, String body) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  print("data url = " + url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _ContactUsActivityState extends State<ContactUsActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Contact Us'),
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
              child: Container(margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),child: Image.asset(
                "images/logos/applogo.png", //delivoo logo
                height: 200.0,
                width: 200,
              ),),





            ),
            Expanded(
                flex: 5,
                child: Container(margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Get in Touch",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                          fontSize: 15),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: InkWell(
                        onTap: () {
                          _launchURL(
                              'connect@desiflea.com', 'Subject', 'Body');
                        },
                        child: Text(
                          "connect@desiflea.com",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff627BF8),
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),),











            ),
          ],
        ),
      ),
    );
  }
}
