import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class ReferPageActivity extends StatefulWidget {
  @override
  _ReferPageActivityState createState() => _ReferPageActivityState();
}

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // STARTUP FROM DYNAMIC LINK LOGIC
    // Get initial dynamic link if the app is started using the link
    // प्रारंभिक डायनामिक लिंक प्राप्त करें यदि ऐप को लिंक का उपयोग करके शुरू किया गया है
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance
        .getInitialLink();

    _handleDeepLink(data);

    // INTO FOREGROUND FROM DYDNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
          _handleDeepLink(dynamicLinkData);
        },

        onError: (OnLinkErrorException e) async {
          print('Dynamic Link Failed: ${e.message}');
        }
    );
  }


  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deepLink: $deepLink');
      String string = deepLink.toString();




      List<String> result = string.split("https:https://play.google.com/store/apps/details?id=cheekolite.gpslab.com?");

      String returnValue = result[result.length - 1];
      print('_handleDeepLink | 78662 deepLink: '+returnValue);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('referal', returnValue);



      print('_handleDeepLink | 760 deepLink: '+prefs.getString('referal'));

    }else {
      print('_handleDeepLink | 786876 deepLink: else ');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('referal', "0");
    }
  }
}

class Response {
  Response({
    this.result,
    this.msg,
    this.amount,
    this.id,
    this.reffer_id,
    this.reffer_name,
    this.status,
    this.user_id,
  });

  String result;
  String msg;
  String amount;
  String id;
  String reffer_id;
  String reffer_name;
  String status;
  String user_id;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        result: json["result"],
        msg: json["msg"],
        amount: json["amount"],
        id: json["id"],
        reffer_id: json["reffer_id"],
        reffer_name: json["reffer_name"],
        status: json["status"],
        user_id: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "msg": msg,
        "amount": amount,
        "id": id,
        "reffer_id": reffer_id,
        "reffer_name": reffer_name,
        "status": status,
        "user_id": user_id,
      };
}

class _ReferPageActivityState extends State<ReferPageActivity> {
  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');
    sharelink = prefs.getString('deeplink');

    //
    // Referlink = "https://gpslab.page.link/?"+
    //     "link=https:https://play.google.com/store/apps/details?id=cheekolite.gpslab.com?"+UserID+
    //     "&apn="+"desiflea.gpslab.com"+
    //     "&st="+"DesiFlea"+
    //     "&sd="+"Feel Desi"+
    //     "&si="+"https://desiflea.com/admin/api/desiflea_logo.png";

    print("referal link 77789 === "+sharelink);

    setState(() {
      _runapi();
    });
  }

  var productModelBannerImageOne = new List<Response>();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
  int total = 0;
  String UserID;
  String TotalPrice = "0";
  String Referlink;
  _runapi() async {
    String objText = '{"cdblock": "referal_list", "cust_id": ' + UserID + '}';
    var url = baseUrl + "?req=" + objText;
    print("response new  url = " + url);

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        if(productModelBannerImageOne.length >0){
          productModelBannerImageOne.clear();
        }
        print("url rest = " + rest.toString());
        productModelBannerImageOne = rest.map((tagJson) => Response.fromJson(tagJson)).toList();
        print("response new length = " + productModelBannerImageOne.length.toString());
        // count = productModelBannerImageOne.length * 20;
        for (int i = 0; i < productModelBannerImageOne.length; i++) {


          if (productModelBannerImageOne[i].msg == "data not found") {
            setState(() {
              visibilty = true;
            });
            TotalPrice = "0";
          }else {

            count = count + int.parse(productModelBannerImageOne[i].amount);

            setState(() {
              visibilty = false;
              TotalPrice =  count.toString();
            });
          }
        }
      });
    });
  }

  bool _isCreatingLink = false;

  String _linkMessage;
  String sharelink;



  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    sharelink = prefs.getString('deeplink');
    print("referal link 786 === "+sharelink);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://gpslab.page.link',

      // link: Uri.parse('https://gpslab.page.link/refer?'),

      link: Uri.parse(sharelink),

      androidParameters: AndroidParameters(
        packageName: 'io.flutter.plugins.firebasedynamiclinksexample',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            Navigator.pushNamed(context, deepLink.path);
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(" _linkMessage  onLinkError =   "+e.message);
      print(e.message);
    });

    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<void> _shareText() async {
    try {
      Share.text('my text title',
          " Hi...!! Desiflea delivers all my grocery needs and household items, "
              "its hassle-free, faster, competitive and highly recommended. "
              "Join Desiflea family and avail life time cash benefits through their unique referral system\n"+
          _linkMessage, 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DynamicLinkService().handleDynamicLinks();

    getUserID();
    initDynamicLinks();


    _createDynamicLink(true);
  }


  int count = 0;
  bool visibilty = true;

  Row _buildItemsForListView(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    (index+1).toString() + ".",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    productModelBannerImageOne[index].reffer_name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "₹ " + productModelBannerImageOne[index].amount+".00",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(  margin: const EdgeInsets.fromLTRB(
            0, 0, 60, 0),child: Center(
          child: Text(
            'Share with your Friends',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),),

      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    'images/icons/popupimg.png',
                    height: 120,
                    width: 120,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    child: CircleAvatar(
                      child: Text(
                        "₹ " + TotalPrice,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      radius: 64,
                      backgroundColor: Colors.white,
                    ),
                    radius: 65,
                    backgroundColor: Colors.black,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    "Your Circle",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    "SHARE NOW TO EARN",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            _shareText();
                          },
                          child: Image.asset(
                            'images/icons/whatsappicon.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            _shareText();
                          },
                          child: Image.asset(
                            'images/icons/faceb.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            _shareText();
                          },
                          child: Image.asset(
                            'images/icons/more.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffffaa01),
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: Text(
                          "Sr.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 55,
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Text(
                          "Earnings",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffffffff),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: visibilty
                      ? new Center(
                          child: Text('No data found'),
                        )
                      : new ConstrainedBox(constraints: BoxConstraints(maxHeight: 100, minHeight: 26.0),
                    child: ListView.builder(
                        itemCount: productModelBannerImageOne.length,
                        itemBuilder: _buildItemsForListView),
                  )





                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Terms and Conditions - ",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000)),
                    )),
                Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "1. ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000)),
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cashback will be credited within 24 hours of successful",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xff000000)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "   ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000)),
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        " top up by your friend. ",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xff000000)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "2. ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000)),
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Minimum top up value is INR 250 to avail offer. ",
                          style:
                              TextStyle(fontSize: 11, color: Color(0xff000000)),
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "3. ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000)),
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Offer not valid for account registered with ",
                          style:
                              TextStyle(fontSize: 11, color: Color(0xff000000)),
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "   ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000)),
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          " in same address. ",
                          style:
                              TextStyle(fontSize: 11, color: Color(0xff000000)),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
