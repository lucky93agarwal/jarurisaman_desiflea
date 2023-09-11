import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:delivoo/Routes/routes.dart';

class StoresPage extends StatelessWidget {
  final String pageTitle;
  final String categoryID;

  StoresPage(this.pageTitle, this.categoryID);

  final int noOfStores = 28;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(126.0),
        child: CustomAppBar(
          titleWidget: Text(
            pageTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          hint: 'Search item or store',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              '$noOfStores Stores found',
              style:
                  Theme.of(context).textTheme.headline6.copyWith(color: kHintColor),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, PageRoutes.items),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 25.3),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage("images/layer_1.png"), //delivoo logo
                    height: 93.3,
                    width: 93.3,
                  ),
                  SizedBox(width: 13.3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Silver Leaf Vegetables',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(color: kMainTextColor)),
                      SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: kIconColor,
                            size: 10,
                          ),
                          SizedBox(width: 10.0),
                          Text('6.4 km ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kLightTextColor,fontSize: 10.0)),
                          Text('|',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kMainColor,fontSize: 10.0)),
                          Text(' Union Market',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kLightTextColor,fontSize: 10.0)),
                        ],
                      ),
                      SizedBox(height: 10.3),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: kIconColor,
                            size: 10,
                          ),
                          SizedBox(width: 10.0),
                          Text('20 MINS',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kLightTextColor,fontSize: 10.0)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
//          ListTile(
//            leading: Image.asset('images/veg/Vegetables/onion.png'),
//            onTap: () => Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => OrderMapPage(
//                  pageTitle: pageTitle,
//                  pickupLatLng: LatLng(20.5937, 78.9629),
//                  dropLatLng: LatLng(20.5937, 78.9630),
//                ),
//              ),
//            ),
//          ),

//          ListView.builder(
//              itemCount: 1,
//              itemBuilder: (BuildContext context, int index) {
//                return ListTile(
//                  title: Text('Hello'),
//                  subtitle: Text('Bye'),
//                );
//              })
        ],
      ),
    );
  }
}
