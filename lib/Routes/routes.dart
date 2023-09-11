import 'package:delivoo/Auth/login_navigator.dart';
import 'package:delivoo/HomeOrderAccount/Account/UI/ListItems/support_page.dart';
import 'package:delivoo/HomeOrderAccount/Account/UI/account_page.dart';
import 'package:delivoo/Chat/UI/chat_page.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/home.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:delivoo/Maps/UI/location_page.dart';
import 'package:delivoo/HomeOrderAccount/Account/UI/ListItems/about_us_page.dart';
import 'package:delivoo/HomeOrderAccount/Account/UI/ListItems/saved_addresses_page.dart';
import 'package:delivoo/HomeOrderAccount/Account/UI/ListItems/tnc_page.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/order_placed_map.dart';
import 'package:delivoo/Models/Category.dart';
import 'package:delivoo/Models/PaymentScreen.dart';
import 'package:delivoo/Models/RazorpayScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:delivoo/Pages/itemslist.dart';
import 'package:delivoo/Pages/view_cart.dart';

import 'package:delivoo/Pages/address.dart';
import 'package:delivoo/Pages/order_placed.dart';
import 'package:delivoo/Pages/payment_method.dart';

class PageRoutes {
  static const String locationPage = 'location_page';
  static const String homeOrderAccountPage = 'home_order_account';
  static const String homePage = 'home_page';
  static const String accountPage = 'account_page';
  static const String orderPage = 'order_page';
  static const String items = 'items';
  static const String tncPage = 'tnc_page';
  static const String aboutUsPage = 'about_us_page';
  static const String savedAddressesPage = 'saved_addresses_page';
  static const String supportPage = 'support_page';
  static const String loginNavigator = 'login_navigator';
  static const String orderMapPage = 'order_map_page';
  static const String chatPage = 'chat_page';
  static const String viewCart = 'view_cart';
  static const String orderPlaced = 'order_placed';
  static const String paymentMethod = 'payment_method';
  static const String addressMethod = 'address_method';
  static const String paymentMethodss = 'payment_payment';

  static const String razorpayMethodss = 'payment_razorpay';
  static const String produtList = 'productlist';

  Map<String, WidgetBuilder> routes() {
    return {
      locationPage: (context) => LocationPage(),
      homeOrderAccountPage: (context) => HomeOrderAccount(),
      homePage: (context) => HomePage(),
      orderPage: (context) => OrderPage(),
      accountPage: (context) => AccountPage(),
      tncPage: (context) => TncPage(),
      aboutUsPage: (context) => AboutUsPage(),
      savedAddressesPage: (context) => SavedAddressesPage(),
      supportPage: (context) => SupportPage(),
      loginNavigator: (context) => LoginNavigator(),
      orderMapPage: (context) => OrderMapPage(),
      chatPage: (context) => ChatPage(),
      paymentMethodss: (context) => PaymentScreen(),
      viewCart: (context) => ViewCart(),
      razorpayMethodss: (context) => RazorpayScreen(),
      addressMethod: (context) => LoginPage(),
      paymentMethod: (context) => PaymentPage(),
      produtList: (context) => ItemsListPage(),
      orderPlaced: (context) => OrderPlaced()
    };
  }
}




