import 'package:delivoo/Auth/login_navigator.dart';
import 'package:delivoo/Locale/locales.dart';
import 'package:delivoo/Pages/RootPage.dart';
import 'package:delivoo/Pages/monthly.dart';
import 'package:delivoo/Pages/paytmpage.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


import 'HomeOrderAccount/home_order_account.dart';
import 'Pages/firstpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'database/DbStudentMamager.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.


// Get a specific camera from the list of available cameras.

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(OverlaySupport(child: Phoenix(child: Delivoo()))






  );


}
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
class Delivoo extends StatefulWidget {


  const Delivoo({
    Key key,

  }) : super(key: key);
  @override
  _DelivooState createState() => _DelivooState();
}


class _DelivooState extends State<Delivoo>{
  final dbhandler = DbStudentMamager.instance;


  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String UserID;
  bool Length;
// login page parameters:
  // primary swatch color
  static const primarySwatch = Colors.green;
  // button color
  static const buttonColor = Colors.green;
  // app name
  static const appName = 'My App';
  // boolean for showing home page if user unverified
  static const homePageUnverified = false;

  final params = {
    'appName': appName,
    'primarySwatch': primarySwatch,
    'buttonColor': buttonColor,
    'homePageUnverified': homePageUnverified,
  };

  void getUserID() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    if (UserID == null) {
      Length = true;
      print('Length new 786 = '); // set an initial value
    }else {
      Length = false;
    }
    // var rowall = await dbhandler.queryall();
//    final count =  await dbhandler.firstEmpty();

    print('Length new = '+Length.toString());


  }
  @override
  void initState() {
    super.initState();
    getUserID();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("Lucky Wallet onMessage: $message");
        showOverlayNotification((context) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(
                        child: Container(
                          color: Colors.black,
                        ))),
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("Lucky Wallet onLaunch: $message");
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("Lucky Wallet onResume: $message");
//        _navigateToItemDetail(message);
      },
    );



  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('hi'),
      ],
      theme: appTheme,
     // home: Length ? FirstPage() : HomeOrderAccount(),
  //     home: FirstPage(),
      home:  new RootPage(checklogin: Length));
    // home:  new PaytmPageActivity());


    // home:  new MonthlyActivity());


  //    routes: PageRoutes().routes(),

  }
}
