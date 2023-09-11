import 'dart:convert';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Components/search_bar.dart';
import 'package:delivoo/Models/ItemLIst.dart';
import 'package:delivoo/Models/ItemListinCart.dart';
import 'package:delivoo/Models/ProductListNew.dart';
import 'package:delivoo/Pages/monthly.dart';
import 'package:delivoo/Pages/search_product_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:delivoo/Pages/product_details_page.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:delivoo/Models/SubCategory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../API.dart';
import 'package:delivoo/Pages/view_cart.dart';
import 'add_money.dart';

List<String> listss = ['1 kg', '500 g', '250 g'];

class ItemsPage extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final String WalletPrice;
  final int tabindex;

  ItemsPage({this.categoryID, this.categoryName, this.WalletPrice, this.tabindex});

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.response,
  });

  List<List<Response>> response;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        response: List<List<Response>>.from(json["response"].map(
            (x) => List<Response>.from(x.map((x) => Response.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Response {
  Response({
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String productId;
  String name;
  String description;
  String image1;
  int numberofitems = 0;
  List<Item> items;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.percentage,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String percentage;
  String isOutOfStock;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        percentage: json["percentage"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "percentage": percentage,
        "is_out_of_stock": isOutOfStock,
      };
}

enum VerUnit { KG, GM }

final verUnitValues = EnumValues({"gm": VerUnit.GM, "kg": VerUnit.KG});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

// List<String> parcentage = [];

class _ItemsPageState extends State<ItemsPage> with TickerProviderStateMixin {
  String CategoryName;
  int itemCount = 0;
  var subCategoryssss = new List<ItemListinCart>();
  var subCategory = new List<SubCategory>();
  String TotalWallet;
  final TextEditingController _searchController = TextEditingController();
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  /// SubCategory List API and Last run Product Api
  /// Get SubCategory API
  _getUsers() {
    String objText =
        '{"cdblock": "SubCategories", "catid": ' + widget.categoryID + '}';
    var url = baseUrl + "?req=" + objText;
    print("Lucky SubCategory =   " + url);

    http.get(url).then((response) {
      setState(() {
        var data = json.decode(response.body);
        var rest = data["response"] as List;
//        print("response = " + response.body);
//        Iterable list = json.decode(response.body);
        subCategory = rest.map((tagJson) => SubCategory.fromJson(tagJson)).toList();


        _currentIndex = this._controller.index;


//        print(_controller.index);
        setState(() {
          visibilenewnew = false;
          getdata = true;
        });
        _getProductList(_currentIndex);
      });
    });
  }

  bool visibilty = false;

  bool visibiltytwo = false;
  bool ListViewVisi = false;
  var productList = new List<Response>();
  var productListTwo = new List<Response>();
  var itemList = new List<ItemList>();

  int Page = 1;
  int Productid = 0;

  bool noProduct = true;


  bool getdata = false;

  ///// product list get Products in the tab click
  _getProductList(int index) {
    setState(() {
      visibilenewnew = false;
    });
    print("check api index = "+ index.toString());
    Page = 1;
    setState(() {
      visibilenewnew = false;
    });
    print("check api visibilenewnew = "+ visibilenewnew.toString());
     Productid = int.parse(subCategory[index].id);
    String objText = '{"cdblock": "CategoryProducts", "catid": "' +
        subCategory[index].id +
        '", "page": "' +
        Page.toString() +
        '"}';

    var url = baseUrl + "?req=" + objText;
    print("check api URL = "+ url.toString());

    print('subcategory = ' + subCategory[index].id);
    http.get(url).then((response) {
      setState(() {
        if (response.body ==
            '{ "response": [[{"result":"Success","msg":"Product not found."}]] }') {
          productList.clear();
          setState(() {
            noProduct = false;
          });

          visibilenewnew = true;
          visibiltytwo = false;
        } else {
          setState(() {
            noProduct = true;
          });

          setState(() {
            visibilenewnew = false;
          });
          final ProductModel users = productModelFromJson(response.body);
          productList = users.response[0];
          // if (parcentage.length > 0) {
          //   parcentage.clear();
          // }
          setState(() {
            visibilenewnew = false;
          });
          // for (int i = 0; i < productList.length; i++) {
          //   double off = double.parse(productList[i].items[0].verPrice) -
          //       double.parse(productList[i].items[0].offerPrice);
          //   double per =
          //       (off / double.parse(productList[i].items[0].verPrice)) * 100;
          //
          //   parcentage.add(per.toStringAsFixed(2).toString());
          // }
          visibilenewnew = true;
          ListViewVisi = true;
        }
      });
    });
  }


  /// Scroll Time Run this api
  _getRunAPI() {
    // setState(() {
    //   visibilenewnew = false;
    // });
    String objText = '{"cdblock": "CategoryProducts", "catid": "' +
        Productid.toString() +
        '", "page": "' +
        Page.toString() +
        '"}';

    var url = baseUrl + "?req=" + objText;
    print("url = = =========== url ====" + url);

    http.get(url).then((response) {
      setState(() {
        print("url = = =========== response ====" + response.body);
        if (response.body ==
            '{ "response": [[{"result":"Success","msg":"Product not found."}]] }') {
          // Toast.show(
          //     'Product not found with the selected keyword "' +
          //         _searchController.text +
          //         '".',
          //     context,
          //     duration: Toast.LENGTH_LONG,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     gravity: Toast.BOTTOM);
          visibilty = false;
          // visibiltytwo = false;
          visibilenewnew = true;
        } else {
          final ProductModel users = productModelFromJson(response.body);
          productListTwo = users.response[0];

          print("Check Data in list = " + users.response[0].toString());

          print(
              "Check Data in list Size = " + productListTwo.length.toString());
          print("Check Data in list Size = " + productList.length.toString());
          int indexnew = productList.length;

          for (int j = 0; j < productListTwo.length; j++) {
            print("Check Data in list index = " + (indexnew + j).toString());
            productList.insert(indexnew + j, productListTwo[j]);
          }
          print("Check Data in list after Size = " +
              productList.length.toString());

          // if (parcentage.length > 0) {
          //   parcentage.clear();
          // }
          // for (int i = 0; i < productList.length; i++) {
          //   double off = double.parse(productList[i].items[0].verPrice) -
          //       double.parse(productList[i].items[0].offerPrice);
          //   double per =
          //       (off / double.parse(productList[i].items[0].verPrice)) * 100;
          //   print("Get % Data 4 = " + per.toStringAsFixed(2).toString());
          //   parcentage.add(per.toStringAsFixed(2).toString());
          // }
          visibilty = false;
          setState(() {
            visibilenewnew = true;
          });

        }
      });
    });
  }

  /// Search Time Run This api
  _getRunAPISearch() {
    print("sdfssdfsdfdsdfhds = " + visibiltytwo.toString());
    String objText = '{"cdblock":"CategoryProducts","catid":"' +
        Productid.toString() +
        '","search":"' +
        _searchController.text +
        '"}';

    var url = baseUrl + "?req=" + objText;
    print("url = = =========== url ====" + url);
    print("url = = " + url);

    http.get(url).then((response) {
      setState(() {
        print("url = = =========== response ====" + response.body);
        print("lsjdflsjfjdlfjsflj = " + response.body);

        if (response.body ==
            '{ "response": [[{"result":"Success","msg":"Product not found."}]] }') {
          // Toast.show(
          //     'Product not found with the selected keyword "' +
          //         _searchController.text +
          //         '".',
          //     context,
          //     duration: Toast.LENGTH_LONG,
          //     gravity: Toast.BOTTOM);
          visibilenewnew = true;
          visibiltytwo = false;
        } else {
          final ProductModel users = productModelFromJson(response.body);

          if (productList.length > 0) {
            productList.clear();
            productListTwo.clear();
          }
          productList = users.response[0];

          print("Check Data in list after Size = " +
              productList.length.toString());

          // if (parcentage.length > 0) {
          //   parcentage.clear();
          // }
          //
          // for (int i = 0; i < productList.length; i++) {
          //   double off = double.parse(productList[i].items[0].verPrice) -
          //       double.parse(productList[i].items[0].offerPrice);
          //   double per =
          //       (off / double.parse(productList[i].items[0].verPrice)) * 100;
          //
          //   print("Get % Data 3 = " + per.toStringAsFixed(2).toString());
          //   parcentage.add(per.toStringAsFixed(2).toString());
          // }
        }

        visibiltytwo = false;
      });
    });
  }

  int _currentIndex = 0;

  int veriantIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  int tabindexs;
  @override
  void initState() {
    super.initState();
    print("url = 1 categoryID = " +
        widget.categoryID +
        " categoryName; " +
        widget.categoryName +
        " WalletPrice;  " +
        widget.WalletPrice);
    present = present + perPage;
    print("url = 2 = ");
    getUserID();
    print("url = 3 = ");
    TotalWallet = widget.WalletPrice;
    print("url = 4 = ");
    walletprice = int.parse(TotalWallet);
    print("url = 5 = ");
    tabindexs = widget.tabindex;
    print("NewLuckyYUYURiSHI=== subidsss index b2 ====    "+tabindexs.toString());
    print("NewLuckyYUYURiSHI=== subidsss index widget.tabindex ====    "+widget.tabindex.toString());

    _getUsers();
    print("url = 6 = ");
    CategoryName = widget.categoryName;
    print("url = 7 = ");

    setState(() {
      _controller = TabController(vsync: this, length: subCategory.length);
    });
    print("url = 8 = ");
    _controller.addListener(() {
      if (_controller.indexIsChanging) {
//        Toast.show("SubCategory id = ", context, duration: Toast.LENGTH_SHORT,
//            gravity: Toast.BOTTOM);
        print('my index is' + _controller.index.toString());
      }
    });
    print("url = 9 = ");
    present = present + perPage;
    print("url = 10 = ");
    _scrollController.addListener(() {
      print("Get more Data _scrollController.position.pixels = " +
          _scrollController.position.pixels.toString());
      print("Get more Data _scrollController.position.maxScrollExtent = " +
          _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          visibilty = true;
        });
        Page = Page + 1;
        _getRunAPI();
      }
    });
    print("url = 11 = ");
//    futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    _searchController.dispose();
    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

//  final List<Tab> tabs = <Tab>[
//    Tab(text: 'VEGETABLES'),
//    Tab(text: 'FRUITS'),
//    Tab(text: 'HERBS'),
//    Tab(text: 'DAIRY'),
//  ];
  int TotalPrice = 0;

  int price = 0;

  int TotalItems = 0;
  int indexnew = 0;

  /// database
  final dbhandler = DbStudentMamager.instance;
  String UserID;

  String productqty;

  //// get Product ID in createuserTable Table in DataBase
  void firstqueryall() async {
    // get all row in the table
    var rowall = await dbhandler.firstqueryall();

    //// check row on the table is null or not
    if (rowall.length.toString() != "0") {
      print('table length 2 = ' + rowall.length.toString());
      print("ProductId  = " + ProductId.toString());
//      int _list =  await dbhandler.checkrow(int.parse(ProductId));

      int count = 0;
      count = await dbhandler.checkrow(int.parse(ProductId));
      print("row  = " + count.toString());
      if (count == null) {
        count = 0;
      }
      print("count = " + count.toString());

      if (count >= 1) {
        print('UPdate Query........');
        updatedb();
      } else {
        print('Insert Query........');
        firstinsertdata();
      }

      rowall.forEach((row) {
        print(row);
      });
    } else {
      print('Insert Quer in else');

      firstinsertdata();
    }
  }

  /// update database
  void updatedb() async {
    Map<String, dynamic> row = {
      DbStudentMamager.userid: UserID,
      DbStudentMamager.productid: ProductId,
      DbStudentMamager.productname: ProductName,
      DbStudentMamager.productimg: ProductImg,
      DbStudentMamager.qty: Qty,
      DbStudentMamager.price: ProductPrice,
      DbStudentMamager.itemtype: ProductType,
      DbStudentMamager.totalprice: TotalPricess,
      DbStudentMamager.productqty: productqty
    };

    print("id  = " + ProductId);

    final id = await dbhandler.firstupdate(
        int.parse(ProductId), int.parse(Qty), int.parse(TotalPricess), row);

//    var rowall = await dbhandler.firstqueryall();
//    TotalItems = rowall.length.toInt();
    print("id update = " + id.toString());

    var rowall = await dbhandler.firstqueryall();

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });

//    Toast.show("id update = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  //// getUser ID in createuserTable Table in DataBase
  void getUserID() async {
    var rowall = await dbhandler.firstqueryall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    TotalWallet = prefs.getString('Wallet');
    walletprice = int.parse(TotalWallet);

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());
    if (prices.toString() == 'null') {
      prices = "0";
    }

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });
//    print('get UserTable count = '+count.toString());
//    print('get UserTable length = '+rowall.length.toString());
  }

  //// STore product in FirstTable in Database
  void firstinsertdata() async {
//    Toast.show("categoryID = ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    print("UserID = " + UserID);
    print("ProductId = " + ProductId);
    print("ProductName = " + ProductName);
    print("ProductImg = " + ProductImg);

    print("Qty = " + Qty);
    print("ProductPrice = " + ProductPrice);

//    print("ItemType = "+ProductType);
    print("TotalPricess = " + TotalPricess);
    Map<String, dynamic> row = {
      DbStudentMamager.userid: UserID,
      DbStudentMamager.productid: ProductId,
      DbStudentMamager.productname: ProductName,
      DbStudentMamager.productimg: ProductImg,
      DbStudentMamager.qty: Qty,
      DbStudentMamager.price: ProductPrice,
      DbStudentMamager.itemtype: "Single",
      DbStudentMamager.totalprice: TotalPricess,
      DbStudentMamager.productqty: productqty,
    };

    final id = await dbhandler.firstinsert(row);

    print("id = " + id.toString());
    var rowall = await dbhandler.firstqueryall();

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

    setState(() {
      TotalItems = rowall.length.toInt();
      TotalPrice = int.parse(prices.toString());
    });

//    print(id);
//    Toast.show("id = " + id.toString() , context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  String Off;

  Future<String> _fetchUserInfo(String mrp, String offer) async {
    double onemrp = double.parse(mrp);
    double oneoffer = double.parse(offer);
    double diff = onemrp - oneoffer;
    double per = (diff * 100) / onemrp;
    Off = per.toString();
    return Off;
  }

  int walletprice = 0;
  String ProductPrice;
  String ProductId;
  String Qty;
  String TotalPricess;
  String ItemType;
  String ProductName;
  String ProductImg;
  String ProductType;

  Container _buildBottomNavigationMenu() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  color: Color(0xffF2F2F2),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Low on balance",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "You are low on balance, please recharge to continue shopping.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMoneyActivity()),
                        );
                      },
                      color: Color(0xffff791a),
                      child: const Text('Add Money Now',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 300,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  void doAddition(int index, int qty, int indexsecond) async {
    setState(() {
      int TotalPricenew =
          (double.parse(productList[index].items[0].offerPrice) *
                  productList[index].numberofitems.toDouble())
              .toInt();

      print("TotalPricenew 2  = " + TotalPricenew.toString());
      print("Price  = " + productList[index].items[0].offerPrice);
//
      print("indexnew = " + index.toString());
      print("Qty = " + productList[index].numberofitems.toString());

      ProductType = "Single";
      ProductName = productList[index].name;
      ProductImg = productList[index].image1;
      ProductId = productList[index].productId;
      ProductPrice = productList[index].items[0].offerPrice;
      Qty = qty.toString();
      TotalPricess = TotalPricenew.toString();
      productqty = productList[index].items[0].verCapacity +
          productList[index].items[0].verUnit;

      //// Database api run
      firstqueryall();
    });
  }

  int perPage = 10;
  int present = 0;
  ScrollController _scrollController = ScrollController();

  String searchdata;

  void searchproduct(String reset) {
    setState(() {
      visibilty = true;
    });

    searchdata = _searchController.text;
    print("reset data from server 1 =" + searchdata.length.toString());
    if (searchdata.length >= 3) {
      print("reset data from server 2 =");
      // _runapis();
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeOrderAccount()),
    );
  }

  bool visibilenewnew = false;

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = new List<Tab>();
    for (int i = 0; i < subCategory.length; i++) {
      tabs.add(Tab(
        child: Text(
          subCategory[i].name,
        ),
      ));
    }
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: DefaultTabController(
          length: subCategory.length,
          initialIndex: tabindexs,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(186.0),
              child: CustomAppBar(
                titleWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(CategoryName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: kMainTextColor)),
                      SizedBox(
                        height: 10.0,
                      ),
                      // Visibility(
                      //   visible: false,
                      //   child: Row(
                      //     children: <Widget>[
                      //       Icon(
                      //         Icons.location_on,
                      //         color: kIconColor,
                      //         size: 10,
                      //       ),
                      //       SizedBox(width: 10.0),
                      //       Text('6.4 km ',
                      //           style: Theme.of(context).textTheme.overline),
                      //       Text('|',
                      //           style: Theme.of(context).textTheme.overline),
                      //       Text(' Union Market',
                      //           style: Theme.of(context).textTheme.overline),
                      //       Spacer(),
                      //       Icon(
                      //         Icons.access_time,
                      //         color: kIconColor,
                      //         size: 10,
                      //       ),
                      //       SizedBox(width: 10.0),
                      //       Text('20 MINS',
                      //           style: Theme.of(context).textTheme.overline),
                      //       SizedBox(width: 20.0),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchProductPage()));
                          },
                          child: Container(
                            height: 50,
                            color: Color(0xffF8F9FD),
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 15,
                                    child: Image.asset(
                                      "images/icons/ic_search.png",
                                      height: 15,
                                      width: 15,
                                    )),
                                Expanded(
                                    flex: 85,
                                    child: Text(
                                      "Search ",
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      getdata? new TabBar(
                        tabs: tabs,
                        onTap: (index) {
                          setState(() {


                            visibilenewnew = false;

                          });
                          _getProductList(index);
                        },
                        isScrollable: true,
                        labelColor: Color(0xffff791a),
                        unselectedLabelColor: kLightTextColor,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 24.0),
                      ): new Container(),
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 8.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: tabs.map((Tab tab) {
                return Stack(
                  children: <Widget>[

                    visibilenewnew
                        ? (noProduct
                            ? Container(
                                margin: const EdgeInsets.fromLTRB(5, 20, 5, 75),
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: productList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0,
                                                      top: 20.0,
                                                      right: 5.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ProductDetailsPage(
                                                                  P_Id: productList[index]
                                                                      .productId,
                                                                  P_name: productList[index]
                                                                      .name,
                                                                  P_description:
                                                                      productList[index]
                                                                          .description,
                                                                  P_image1: productList[index]
                                                                      .image1,
                                                                  P_verShortDesc: productList[index]
                                                                      .items[0]
                                                                      .verShortDesc,
                                                                  P_verCapacity: productList[index]
                                                                      .items[0]
                                                                      .verCapacity,
                                                                  P_verUnit: productList[index]
                                                                      .items[0]
                                                                      .verUnit,
                                                                  P_verPrice: productList[index]
                                                                      .items[0]
                                                                      .verPrice,
                                                                  P_offerPrice: productList[index]
                                                                      .items[0]
                                                                      .offerPrice,
                                                                  walletprice:
                                                                      walletprice
                                                                          .toString(),
                                                                  productQty: productList[index].items[0].verUnit +
                                                                      productList[index]
                                                                          .items[0]
                                                                          .verCapacity)));
                                                    },
                                                    child: Image.network(
                                                      productList[index].image1,
                                                      height: 80,
                                                      width: 80,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          child: Text(productList[index].name,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontSize: 11,fontFamily: 'Raleway',color: Colors.black),
                                                          ),
                                                        ),

                                                        // Align(
                                                        //   alignment: Alignment.topRight,
                                                        //   child: InkWell(onTap: (){
                                                        //     Navigator.push(
                                                        //         context,
                                                        //         MaterialPageRoute(
                                                        //         builder: (context) => MonthlyActivity(P_Id: productList[index]
                                                        //             .productId,
                                                        //             P_name: productList[index]
                                                        //                 .name,
                                                        //             P_description:
                                                        //             productList[index]
                                                        //                 .description,
                                                        //             P_image1: productList[index]
                                                        //                 .image1,
                                                        //             P_verShortDesc: productList[index]
                                                        //                 .items[0]
                                                        //                 .verShortDesc,
                                                        //             P_verCapacity: productList[index]
                                                        //                 .items[0]
                                                        //                 .verCapacity,
                                                        //             P_verUnit: productList[index]
                                                        //                 .items[0]
                                                        //                 .verUnit,
                                                        //             P_verPrice: productList[index]
                                                        //                 .items[0]
                                                        //                 .verPrice,
                                                        //             P_offerPrice: productList[index]
                                                        //                 .items[0]
                                                        //                 .offerPrice,
                                                        //             walletprice:
                                                        //             walletprice
                                                        //                 .toString(),
                                                        //             productQty: productList[index].items[0].verCapacity +
                                                        //                 productList[index]
                                                        //                     .items[0]
                                                        //                     .verUnit
                                                        //         )));
                                                        //   },child:  Image.asset("images/icons/repeat.png",height: 30,width: 30,),),
                                                        //
                                                        //
                                                        //
                                                        // ),

                                                      ],
                                                    ),
                                                    Stack(
                                                      children: [

                                                        Container(margin: const EdgeInsets.fromLTRB(100.0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                          child: Text("",
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Color(
                                                                    0xffff791a)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    // SizedBox(
                                                    //   height: 15.0,
                                                    // ),
                                                    Text(productList[index].items[0].verCapacity +
                                                        productList[index].items[0].verUnit,
                                                        style: TextStyle(fontSize: 11,color: Colors.grey[500])
                                                    ),

                                                    SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Row(children: [
                                                      Text(
                                                          '\₹' +
                                                              productList[index]
                                                                  .items[0]
                                                                  .offerPrice+"  ",
                                                          style: TextStyle(fontSize: 11,color: Colors.black)
                                                      ),

                                                      Text(
                                                        '\₹' +
                                                            productList[index]
                                                                .items[0]
                                                                .verPrice,
                                                        // + _fetchUserInfo(productList[index]
                                                        // .items[0]
                                                        // .verPrice,productList[index]
                                                        // .items[0]
                                                        // .offerPrice

                                                        style:
                                                        bottomNavigationTextStyle
                                                            .copyWith(
                                                          fontSize: 11,
                                                          color: Colors.grey[500],
                                                          decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                        ),
                                                      ),
                                                      Text("  "+productList[index].items[0].percentage + "% OFF",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                          color: Colors.grey[500],
                                                        ),
                                                      ),
                                                    ],),

                                                  ],
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              right: 20.0,
                                              bottom: 14,
                                              child: productList[index]
                                                          .numberofitems ==
                                                      0
                                                  ? Container(
                                                      height: 30.0,
                                                      child: FlatButton(
                                                        child: Text(
                                                          'Add',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .caption
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xffff791a),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .accent,
                                                        onPressed: () {
                                                          setState(() {
                                                            int total = 0;
                                                            double
                                                                totalproduct =
                                                                productList[
                                                                        index]
                                                                    .numberofitems
                                                                    .toDouble();
                                                            totalproduct =
                                                                totalproduct +
                                                                    1.0;

                                                            int TotalPricenew =
                                                                (double.parse(productList[index]
                                                                            .items[0]
                                                                            .offerPrice) *
                                                                        1.0)
                                                                    .toInt();

                                                            print("TotalPrice by time TotalPricenew = " +
                                                                TotalPricenew
                                                                    .toString());

                                                            total = TotalPrice;
                                                            total = total +
                                                                TotalPricenew;
                                                            print("Check Address Update total = " +
                                                                total
                                                                    .toString());
                                                            print("Check Address Update walletprice = " +
                                                                walletprice
                                                                    .toString());
                                                            if (walletprice ==
                                                                0) {
                                                              _onButtonPressed();
                                                            } else if (total >
                                                                walletprice) {
                                                              _onButtonPressed();
                                                            } else {
                                                              productList[index]
                                                                  .numberofitems++;
                                                              doAddition(
                                                                  index,
                                                                  productList[
                                                                          index]
                                                                      .numberofitems,
                                                                  0);
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 30.0,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 11.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffff791a)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              indexnew = index;
                                                              setState(() {
                                                                int total = 0;
                                                                double
                                                                    totalproduct =
                                                                    productList[
                                                                            index]
                                                                        .numberofitems
                                                                        .toDouble();
                                                                totalproduct =
                                                                    totalproduct +
                                                                        1.0;

                                                                int TotalPricenew =
                                                                    (double.parse(productList[index].items[0].offerPrice) *
                                                                            totalproduct)
                                                                        .toInt();

                                                                print("TotalPrice by time TotalPricenew = " +
                                                                    TotalPricenew
                                                                        .toString());

                                                                total =
                                                                    TotalPrice;
                                                                total = total +
                                                                    TotalPricenew;
                                                                print("TotalPrice by time total = " +
                                                                    total
                                                                        .toString());
                                                                // if (walletprice == 0) {
                                                                //   _onButtonPressed();
                                                                // } else if (total >
                                                                //     walletprice) {
                                                                //   _onButtonPressed();
                                                                // } else {
                                                                productList[
                                                                        index]
                                                                    .numberofitems--;
                                                                doAddition(
                                                                    index,
                                                                    productList[
                                                                            index]
                                                                        .numberofitems,
                                                                    0);
                                                                // }

//                                                AddTotalPrice();
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: Color(
                                                                  0xffff791a),
                                                              size: 20.0,
                                                              //size: 23.3,
                                                            ),
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Text(
                                                              productList[index]
                                                                  .numberofitems
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption),
                                                          SizedBox(width: 8.0),
                                                          InkWell(
                                                            onTap: () {
                                                              indexnew = index;
                                                              setState(() {
                                                                int total = 0;
                                                                double
                                                                    totalproduct =
                                                                    productList[
                                                                            index]
                                                                        .numberofitems
                                                                        .toDouble();
                                                                totalproduct =
                                                                    totalproduct +
                                                                        1.0;

                                                                int TotalPricenew =
                                                                    (double.parse(productList[index].items[0].offerPrice) *
                                                                            1.0)
                                                                        .toInt();

                                                                print("TotalPrice by time TotalPricenew = " +
                                                                    TotalPricenew
                                                                        .toString());

                                                                total =
                                                                    TotalPrice;
                                                                print("Check Address Update TotalPrice = " +
                                                                    TotalPrice
                                                                        .toString());
                                                                total = total +
                                                                    TotalPricenew;
                                                                print("Check Address Update total = " +
                                                                    total
                                                                        .toString());
                                                                print("Check Address Update walletprice = " +
                                                                    walletprice
                                                                        .toString());

                                                                if (walletprice ==
                                                                    0) {
                                                                  _onButtonPressed();
                                                                } else if (total >
                                                                    walletprice) {
                                                                  _onButtonPressed();
                                                                } else {
                                                                  productList[
                                                                          index]
                                                                      .numberofitems++;
                                                                  doAddition(
                                                                      index,
                                                                      productList[
                                                                              index]
                                                                          .numberofitems,
                                                                      0);
                                                                }

//                                                AddTotalPrice();
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Color(
                                                                  0xffff791a),
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 5.0,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : new Center(
                                child: Image.asset(
                                  'images/logos/noproduct.png',
                                  height: 300,
                                  width: 300,
                                ),
                              )
                    )
                        : new Column(
                            children: [
                              Container(
                                height: 160,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 140,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 30),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 20, 10, 20),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 30),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 20),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 140,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 30),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 20, 10, 20),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 30),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 20),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 140,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 30),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 20, 10, 20),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 30),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 20),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 140,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 30),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  height: 70,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 20, 10, 20),
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 30),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 20),
                                                  ),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: visibilty
                                  ? new SpinKitThreeBounce(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: index.isEven
                                                ? Colors.white
                                                : Colors.white,
                                          ),
                                        );
                                      },
                                    )
                                  : new Container(),
                            ),
                            Expanded(
                              flex: 9,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'images/icons/ic_cart wt.png',
                                    height: 19.0,
                                    width: 18.3,
                                  ),
                                  SizedBox(width: 20.7),
                                  Text(
                                    TotalPrice == 0
                                        ? '0 items | 0 Total Price'
                                        : TotalItems.toString() +
                                            ' items | \₹ ' +
                                            (TotalPrice).toString(),
                                    style: bottomBarTextStyle.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  FlatButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (TotalItems == 0) {
                                        Toast.show(
                                            "Please select any product...",
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewCart()),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'View Cart',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              color: Color(0xffff791a),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    textTheme: ButtonTextTheme.accent,
                                    disabledColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        color: Color(0xffff791a),
                        height: 70.0,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ));
  }
}

class BottomSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 80.7,
          color: kCardBackgroundColor,
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text('Fresh Red Onions',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
            subtitle: Text('Vegetables',
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 15)),
            trailing: FlatButton(
              color: Colors.white,
              onPressed: () {
                /*...*/
              },
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: Color(0xffff791a), fontWeight: FontWeight.bold),
              ),
              textTheme: ButtonTextTheme.accent,
              disabledColor: Colors.white,
            ),
          ),
        ),
        CheckboxGroup(
          labelStyle:
              Theme.of(context).textTheme.caption.copyWith(fontSize: 16.7),
          labels: listss,
        ),
      ],
    );
  }
}
