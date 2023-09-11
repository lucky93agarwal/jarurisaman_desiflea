
import 'package:delivoo/Chat/UI/animated_bottom_bar.dart';
import 'package:delivoo/HomeOrderAccount/Account/UI/account_page.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/home.dart';
import 'package:delivoo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeOrderAccount extends StatefulWidget {
  // final CameraDescription camera;

  // const HomeOrderAccount({
  //   Key key,
  //   @required this.camera,
  // }) : super(key: key);
  @override
  _HomeOrderAccountState createState() => _HomeOrderAccountState();
}

class _HomeOrderAccountState extends State<HomeOrderAccount> {
  // CameraDescription scamera;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // scamera = widget.camera;
  }

  final List<BarItem> barItems = [
    BarItem(
      text: 'Home',
      image: bottomIconHome,
    ),
    BarItem(
      text: 'Order',
      image: bottomIconOrder,
    ),
    BarItem(
      text: 'Account',
      image: bottomIconAccount,
    ),
  ];

  final List<Widget> _children = [
    HomePage(),
    OrderPage(),
    AccountPage(),
  ];

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static String bottomIconHome = 'images/footermenu/ic_home.png';

  static String bottomIconOrder = 'images/footermenu/ic_orders.png';

  static String bottomIconAccount = 'images/footermenu/ic_profile.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: AnimatedBottomBar(
          barItems: barItems,
          onBarTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}