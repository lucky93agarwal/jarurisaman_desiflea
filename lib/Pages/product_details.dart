import 'dart:convert';

import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Components/search_bar.dart';
import 'package:delivoo/Models/ItemLIst.dart';
import 'package:delivoo/Models/ItemListinCart.dart';
import 'package:delivoo/Models/ProductList.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:delivoo/Models/SubCategory.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../API.dart';

List<String> listss = ['1 kg', '500 g', '250 g'];

class ItemsSecondPage extends StatefulWidget {
  final String categoryID;
  final String categoryName;

  ItemsSecondPage({this.categoryID, this.categoryName});

  @override
  _ItemsSecondPageState createState() => _ItemsSecondPageState();
}

class _ItemsSecondPageState extends State<ItemsSecondPage>
    with TickerProviderStateMixin {
  int itemCount = 0;
  var subCategoryssss = new List<ItemListinCart>();
  var subCategory = new List<SubCategory>();

  String CategoryName;
  var baseUrl = "http://supergrofer.com/demo/api/supergroferAPI.php?p=";

  var productList = new List<ProductList>();
  var itemList = new List<ItemList>();

  _getProductList() {
    var url =
        "http://supergrofer.com/demo/api/supergroferAPI.php?p=ProductsV2&catid=" +
            widget.categoryID;

    print('subcategory = ' + widget.categoryID);
    http.get(url).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);

        productList = list.map((model) => ProductList.fromJson(model)).toList();
      });
    });
  }

  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  @override
  void initState() {
    super.initState();
    getUserID();
    _getProductList();
    CategoryName = widget.categoryName;
    setState(() {
      _controller = TabController(vsync: this, length: subCategory.length);
    });
    productlength = 0;
//    onChanged = () {
//      Toast.show("SubCategory id = ", context,
//          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//      setState(() {
//        _currentIndex = this._controller.index;
//        print(_controller.index);
//
//      });
//    };
    _controller.addListener(() {
      if (_controller.indexIsChanging) {
//        Toast.show("SubCategory id = ", context, duration: Toast.LENGTH_SHORT,
//            gravity: Toast.BOTTOM);
        print('my index is' + _controller.index.toString());
      }
    });

//    futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
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
      DbStudentMamager.totalprice: TotalPricess
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
    var rowall = await dbhandler.queryall();
//    final count =  await dbhandler.firstEmpty();
    rowall.forEach((row) {
      print(row);
      var _list = row.values.toList();
      UserID = _list[1].toString();

      print('get UserID = ' + _list[1].toString());
    });

    var prices = await dbhandler.firsttotalprice();
    print("Price New = " + prices.toString());

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
      DbStudentMamager.totalprice: TotalPricess
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

  int productlength = 0;

  String ProductPrice;
  String ProductId;
  String Qty;
  String TotalPricess;
  String ItemType;
  String ProductName;
  String ProductImg;
  String ProductType;




  /// Date picker in first row
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  ///
  ///
  void doAddition(int index, int qty) {
    setState(() {
//      ItemType =
////      firstinsertdata();
//      int TotalPricenew = (double.parse(productList[index].price) *
//              productList[index].numberofitems.toDouble())
//          .toInt();
////      print("indexnew 2  = "+index.toString());
//      print("Price  = " + productList[index].price);
////
//      print("indexnew = " + index.toString());
//      print("Qty = " + productList[index].numberofitems.toString());
//
//      ProductType = productList[index].producttype;
//      ProductName = productList[index].itemname;
//      ProductImg = productList[index].image;
//      ProductId = productList[index].productid;
//      ProductPrice = productList[index].price;
//      Qty = qty.toString();
//      TotalPricess = TotalPricenew.toString();

      //// Database api run
      firstqueryall();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: CustomAppBar(
          titleWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( CategoryName.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: kMainTextColor)),
                SizedBox(
                  height: 10.0,
                ),
                Visibility(
                  visible: false,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: kIconColor,
                        size: 10,
                      ),
                      SizedBox(width: 10.0),
                      Text('6.4 km ',
                          style: Theme.of(context).textTheme.overline),
                      Text('|', style: Theme.of(context).textTheme.overline),
                      Text(' Union Market',
                          style: Theme.of(context).textTheme.overline),
                      Spacer(),
                      Icon(
                        Icons.access_time,
                        color: kIconColor,
                        size: 10,
                      ),
                      SizedBox(width: 10.0),
                      Text('20 MINS',
                          style: Theme.of(context).textTheme.overline),
                      SizedBox(width: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Column(
              children: <Widget>[
//                  CustomSearchBar(hint: 'Search item or store'),

                Divider(
                  color: kCardBackgroundColor,
                  thickness: 8.0,
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 30.0, right: 14.0),
                    child: Image.network(
                      'https://s01.sgp1.cdn.digitaloceanspaces.com/article/143666-oxownzwrao-1593513533.jpg',
                      scale: 2.5,
                      height: 93.3,
                      width: 93.3,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("productList[index].productname",
                          style:
                              bottomNavigationTextStyle.copyWith(fontSize: 11)),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("productList[0].itemname",
                          style:
                              bottomNavigationTextStyle.copyWith(fontSize: 11)),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text('\₹ ' + "productList[0].price",
                          style: Theme.of(context).textTheme.caption),
                      SizedBox(
                        height:8.0,
                      ),
                      Text("productList[0].discription",
                          style: Theme.of(context).textTheme.caption),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )
                ],
              ),
              Positioned(
                right: 20.0,
                bottom: 14,
                child:
//                productList[0].numberofitems == 0
                productlength ==0
                    ? Container(
                  height: 30.0,
                  child: FlatButton(
                    child: Text(
                      'Add',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(
                          color: kMainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    textTheme: ButtonTextTheme.accent,
                    onPressed: () {


                      setState(() {
//                        productList[0].numberofitems++;
                        productlength +1;
//                        doAddition(0,productList[0].numberofitems);
                      });
                    },
                  ),
                )
                    : Container(
                  height: 30.0,
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: kMainColor),
                    borderRadius:
                    BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          indexnew = 0;
                          setState(() {

//                            productList[0].numberofitems--;
                            productlength -1;
//                            doAddition(0,productList[0].numberofitems);
//                                                AddTotalPrice();
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          color: kMainColor,
                          size: 20.0,
                          //size: 23.3,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(

//                          productList[0].numberofitems.toString(),
                      productlength.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption),
                      SizedBox(width: 8.0),
                      InkWell(
                        onTap: () {
                          indexnew = 0;
                          setState(() {
//                            productList[0].numberofitems++;
                            productlength +1;
//                            doAddition(0,productList[0].numberofitems);
//                                                AddTotalPrice();


                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: kMainColor,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                  EdgeInsets.only(left: 20.0, top: 10.0, right: 14.0),
                  child: Column(
                    children: <Widget>[
                      Text("From ",
                          style: Theme.of(context).textTheme.caption),
                      SizedBox(
                        height:8.0,
                      ),
                    ],
                  ),
              ),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
            ],
          )
        ],
      ), //        body: TabBarView(
//
//          physics: NeverScrollableScrollPhysics(),
//          children: tabs.map((Tab tab) {
//
//
//            return Stack(
//              children: <Widget>[
//                ListView(
//                    children:<Widget>[
//                      Column(
//                        children: <Widget>[
//                          Stack(
//                            children: <Widget>[
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  Padding(
//                                    padding: EdgeInsets.only(
//                                        left: 20.0, top: 30.0, right: 14.0),
//                                    child: Image.network(
//                                      'http://supergrofer.com/demo/' +
//                                          productList[0].image,
////                                scale: 2.5,
//                                      height: 93.3,
//                                      width: 93.3,
//                                    ),
//                                  ),
//                                  Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
////                                    Text(productList[index].productname,
////                                        style: bottomNavigationTextStyle
////                                            .copyWith(fontSize: 15)),
//                                      SizedBox(
//                                        height: 8.0,
//                                      ),
//                                      Text(productList[0].itemname,
//                                          style: bottomNavigationTextStyle
//                                              .copyWith(fontSize: 11)),
//                                      SizedBox(
//                                        height: 8.0,
//                                      ),
//
//                                      Text('\₹ ' + productList[0].price,
//                                          style: Theme.of(context)
//                                              .textTheme
//                                              .caption),
//                                      SizedBox(
//                                        height: 20.0,
//                                      ),
////                                    InkWell(
////                                      onTap: () {
////                                        print('product type = '+productList[0].producttype);
////                                        if(productList[0].producttype == 'Single'){
////
////                                        }else {
////                                          _getItems(
////                                              productList[0].productid);
////                                        }
////                                        showModalBottomSheet(
////                                          context: context,
////                                          builder: (context) {
////                                            return ListView(
////
////                                              children: <Widget>[
////                                                Container(
////                                                  height: 80.7,
////                                                  color: kCardBackgroundColor,
////                                                  padding: EdgeInsets.all(10.0),
////                                                  child: ListTile(
////                                                    title: Text(
////                                                        productList[index]
////                                                            .productname +
////                                                            productList[index]
////                                                                .itemname,
////                                                        style: Theme.of(context)
////                                                            .textTheme
////                                                            .caption
////                                                            .copyWith(
////                                                            fontSize: 15,
////                                                            fontWeight:
////                                                            FontWeight
////                                                                .w500)),
////                                                    subtitle: Text(
////                                                        subCategory[index].name,
////                                                        style: Theme.of(context)
////                                                            .textTheme
////                                                            .caption
////                                                            .copyWith(
////                                                            fontSize: 15)),
////                                                    trailing: FlatButton(
////                                                      color: Colors.white,
////                                                      onPressed: () {
////                                                        /*...*/
////                                                      },
////                                                      child: Text(
////                                                        'Add',
////                                                        style: Theme.of(context)
////                                                            .textTheme
////                                                            .caption
////                                                            .copyWith(
////                                                            color:
////                                                            kMainColor,
////                                                            fontWeight:
////                                                            FontWeight
////                                                                .bold),
////                                                      ),
////                                                      textTheme: ButtonTextTheme
////                                                          .accent,
////                                                      disabledColor:
////                                                      Colors.white,
////                                                    ),
////                                                  ),
////                                                ),
////                                                CheckboxGroup(
////                                                  labelStyle: Theme.of(context)
////                                                      .textTheme
////                                                      .caption
////                                                      .copyWith(fontSize: 16.7),
////                                                  labels: listss,
////
////                                                ),
////
////                                              ],
////                                            );
////                                          },
////                                        );
////                                      },
////                                      child: Container(
////                                        height: 30.0,
////                                        padding: EdgeInsets.symmetric(
////                                            horizontal: 12.0),
////                                        decoration: BoxDecoration(
////                                          color: kCardBackgroundColor,
////                                          borderRadius:
////                                          BorderRadius.circular(30.0),
////                                        ),
////                                        child: Row(
////                                          children: <Widget>[
////                                            Text(
////                                              productList[index].unit,
////                                              style: Theme.of(context)
////                                                  .textTheme
////                                                  .caption,
////                                            ),
////                                            SizedBox(
////                                              width: 8.0,
////                                            ),
////                                            Icon(
////                                              Icons.keyboard_arrow_down,
////                                              color: kMainColor,
////                                            ),
////                                          ],
////                                        ),
////                                      ),
////                                    ),
//                                    ],
//                                  ),
//                                ],
//                              ),









//                            ],
//                          ),
//                        ],
//                      ),
//                    ]
//
//                ),
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child: Container(
//                    padding: EdgeInsets.symmetric(horizontal: 20.0),
//                    child: Row(
//                      children: <Widget>[
//                        Image.asset(
//                          'images/icons/ic_cart wt.png',
//                          height: 19.0,
//                          width: 18.3,
//                        ),
//                        SizedBox(width: 20.7),
//                        Text(
//
//                          TotalPrice  == 0 ? '0 items | 0 Total Price' :  TotalItems.toString()+' items | \₹ '+(TotalPrice).toString(),
//
//                          style: bottomBarTextStyle.copyWith(
//                              fontSize: 15, fontWeight: FontWeight.w500),
//                        ),
//                        Spacer(),
//                        FlatButton(
//                          color: Colors.white,
//                          onPressed: () =>
//                              Navigator.pushNamed(context, PageRoutes.viewCart),
//                          child: Text(
//                            'View Cart',
//                            style: Theme.of(context).textTheme.caption.copyWith(
//                                color: kMainColor, fontWeight: FontWeight.bold),
//                          ),
//                          textTheme: ButtonTextTheme.accent,
//                          disabledColor: Colors.white,
//                        ),
//                      ],
//                    ),
//                    color: kMainColor,
//                    height: 60.0,
//                  ),
//                ),
//              ],
//            );
//          }).toList(),
//        ),
    );
  }
}

//class BottomSheetWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return ListView(
//      children: <Widget>[
//        Container(
//          height: 80.7,
//          color: kCardBackgroundColor,
//          padding: EdgeInsets.all(10.0),
//          child: ListTile(
//            title: Text('Fresh Red Onions',
//                style: Theme.of(context)
//                    .textTheme
//                    .caption
//                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
//            subtitle: Text('Vegetables',
//                style:
//                Theme.of(context).textTheme.caption.copyWith(fontSize: 15)),
//            trailing: FlatButton(
//              color: Colors.white,
//              onPressed: () {
//                /*...*/
//              },
//              child: Text(
//                'Add',
//                style: Theme.of(context)
//                    .textTheme
//                    .caption
//                    .copyWith(color: kMainColor, fontWeight: FontWeight.bold),
//              ),
//              textTheme: ButtonTextTheme.accent,
//              disabledColor: Colors.white,
//            ),
//          ),
//        ),
//        CheckboxGroup(
//          labelStyle:
//          Theme.of(context).textTheme.caption.copyWith(fontSize: 16.7),
//          labels: listss,
//        ),
//      ],
//    );
//  }
//}
