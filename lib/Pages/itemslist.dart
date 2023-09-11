import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivoo/Components/card_content.dart';
import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Components/reusable_card.dart';
import 'package:delivoo/Controller/HomeController.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/Stores/stores.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/custom_delivery.dart';
import 'package:delivoo/Models/Category.dart';
import 'package:delivoo/Pages/product_details.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../API.dart';


class ItemsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeTwo();
  }
}

class HomeTwo extends StatefulWidget {
  @override
  _HomeTwoState createState() => _HomeTwoState();
}

class _HomeTwoState extends StateMVC<HomeTwo> {




//  Future<String> getData() async{
//    http.Response response = await http.get("http://supergrofer.com/demo/api/?p=MasterCategory");
//
//    print('Lucky AGarwal is my name');
//    print(response.body);
//    debugPrint(response.body);
//    Toast.show(response.body, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//  }



  String value = 'Home';


//  Future<Category> fetchAlbum() async {
//    final response = await http.get('http://supergrofer.com/demo/api/?p=MasterCategory');
//
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response,
//      // then parse the JSON.
//      Toast.show(response.body, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//      return Category.fromJson(json.decode(response.body));
//    } else {
//      // If the server did not return a 200 OK response,
//      // then throw an exception.
//      throw Exception('Failed to load album');
//    }
//  }
  var category = new List<Category>();
  _getUsers() {
    API.getUsersTwo().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        category = list.map((model) => Category.fromJson(model)).toList();
      });
    });
  }
//  Future<Category> futureAlbum;
  @override
  void initState() {
    super.initState();
    _getUsers();
//    futureAlbum = fetchAlbum();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(126.0),
        child: CustomAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.location_on,
              color: kMainColor,
            ),
          ),

          titleWidget: DropdownButton(
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: kMainColor,
            ),
            iconSize: 24.0,
            elevation: 16,
            style: inputTextStyle.copyWith(fontWeight: FontWeight.bold),
            underline: Container(
              height: 0,
            ),
            onChanged: (String newValue) {
              setState(() {
                value = newValue;
              });
              if (value == 'Set Location')
                Navigator.pushNamed(context, PageRoutes.locationPage);
            },
            items: <String>['Home', 'Office', 'Other', 'Set Location']
                .map<DropdownMenuItem<String>>((String address) {
              return DropdownMenuItem<String>(
                value: address,
                child: Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: IconButton(
                icon: ImageIcon(
                  AssetImage('images/icons/ic_cart blk.png'),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, PageRoutes.viewCart),
//                getData,
              ),
            ),
          ],
          hint: 'Search item or store',
        ),
      ),
      body: Column(
        children: <Widget>[
          //               CustomSearchBar(hint: 'Search item or store'),
          Padding(
            padding: EdgeInsets.only(top: 16.0, left: 24.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Got Delivered",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "everything you need",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),

          buildGrid(),
        ],
      ),
    );
  }

  Expanded buildGrid() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: new List<Widget>.generate(category.length, (index) {

//            return new Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Image.network('http://supergrofer.com/demo/'+category[index].image,width: 150,height: 150,),
//                Text(category[index].name,
//                    style: bottomNavigationTextStyle.copyWith(
//                        fontSize: 15)),
//                InkWell(
//                  onTap: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsPage('Vegetables & Fruits',category[index].id))
//                    );
//                  },
//                )
//              ],
//            );
            return new InkWell(
              highlightColor: Colors.transparent,
              splashColor: Theme.of(context).accentColor.withOpacity(0.08),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsSecondPage(categoryID:category[index].id,categoryName:category[index].name)));
              },
              child: Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)]),
                child:
                Padding(padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child:  Wrap(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                        child: Hero(
                          tag: category[index].name,
                          child: CachedNetworkImage(
                            width: 100,
                            height: 100,
                            imageUrl: 'http://supergrofer.com/demo/'+category[index].image,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              width: double.infinity,
                              height: 72,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),

                      Column(
                        children: <Widget>[
                          Text(
                            category[index].name.toUpperCase(),
                            style: new TextStyle(fontSize: 13, color: Colors.black),
                            softWrap: false,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 1),


                        ],
                      ),

                    ],
                  ),),

              ),
            );
//            Container(
////            padding: const EdgeInsets.all(5.0),
////            child: Text('${event_response.eventList[position].eventName}'),
////            )




          }),
//          <Widget>[
//            ReusableCard(
//              cardChild: CardContent(
//                image: AssetImage('images/maincategory/food_mealsact.png'),
//                text: category[0].name,
////                image:
////                    AssetImage(_con.categories.elementAt(0).image),
////                text: _con.categories.elementAt(0).name,
//              ),
//              onPress: () => Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => StoresPage('Vegetables & Fruits')),
//              ),
////            ),
////            ReusableCard(
//////              cardChild: CardContent(
//////                image: AssetImage('images/maincategory/food_mealsact.png'),
//////                text: 'FOOD\n& MEALS',
//////              ),
//////              onPress: () => Navigator.push(
//////                  context,
//////                  MaterialPageRoute(
//////                      builder: (context) => StoresPage('Food & Meals'))),
//////            ),
////            ReusableCard(
////              cardChild: CardContent(
////                image: AssetImage('images/maincategory/meat_fishact.png'),
////                text: 'MEAT\n& FISH',
////              ),
////              onPress: () => Navigator.push(
////                  context,
////                  MaterialPageRoute(
////                      builder: (context) => StoresPage('Meat & Fish'))),
////            ),
////            ReusableCard(
////              cardChild: CardContent(
////                image:
////                    AssetImage('images/maincategory/pharma_medicinesact.png'),
////                text: 'PHARMA\nMEDICINES',
////              ),
////              onPress: () => Navigator.push(
////                  context,
////                  MaterialPageRoute(
////                      builder: (context) => StoresPage('Pharma Medicines'))),
////            ),
////            ReusableCard(
////              cardChild: CardContent(
////                image: AssetImage('images/maincategory/pet_suppliesact.png'),
////                text: 'PET\nSUPPLIES',
////              ),
////              onPress: () => Navigator.push(
////                  context,
////                  MaterialPageRoute(
////                      builder: (context) => StoresPage('Pet Supplies'))),
////            ),

//          ],
        ),
      ),
    );
  }
}
