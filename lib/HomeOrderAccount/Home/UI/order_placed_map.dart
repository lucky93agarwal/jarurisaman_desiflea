import 'dart:async';
import 'package:delivoo/HomeOrderAccount/Home/UI/slide_up_panel.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderMapPage extends StatelessWidget {
  final String instruction;
  final String pageTitle;

  OrderMapPage(
      {this.instruction, this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return OrderMap(pageTitle);
  }
}

class OrderMap extends StatefulWidget {
  final String pageTitle;

  OrderMap(this.pageTitle);

  @override
  _OrderMapState createState() => _OrderMapState();
}

class _OrderMapState extends State<OrderMap> {

  @override
  void initState() {
    super.initState();
//    _orderMapBloc = BlocProvider.of<OrderMapBloc>(context);
//    _orderMapBloc.add(LoadPageEvent(
//      pickupId: 'pickup',
//      dropId: 'drop',
//      pickupDescriptor: BitmapDescriptor.defaultMarker,
//      dropDescriptor: BitmapDescriptor.defaultMarkerWithHue(90),
//    ));
  }

  List<String> itemName = [
    'Fresh Red Onions',
    'Fresh Cauliflower',
    'Fresh Cauliflower',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          titleSpacing: 0.0,
          title: null,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.3),
                      child: Image.asset(
                        'images/maincategory/vegetables_fruitsact.png',
                        height: 42.3,
                        width: 33.7,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Vegetables & Fruits',
                          style: orderMapAppBarTextStyle.copyWith(
                              letterSpacing: 0.07),
                        ),
                        subtitle: Text(
                          '20 June, 11:35am',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: 11.7,
                              letterSpacing: 0.06,
                              color: Color(0xffc1c1c1)),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Pickup Arranged',
                              style: orderMapAppBarTextStyle.copyWith(
                                  color: kMainColor),
                            ),
                            SizedBox(height: 7.0),
                            Text(
                              '3 items | \$ 11.50',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: 11.7,
                                      letterSpacing: 0.06,
                                      color: Color(0xffc1c1c1)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: kCardBackgroundColor,
                  thickness: 1.0,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 36.0, bottom: 6.0, top: 6.0, right: 12.0),
                      child: ImageIcon(
                        AssetImage('images/custom/ic_pickup_pointact.png'),
                        size: 13.3,
                        color: kMainColor,
                      ),
                    ),
                    Text(
                      'Silver Leaf Vegetables\t',
                      style: orderMapAppBarTextStyle.copyWith(
                          fontSize: 10.0, letterSpacing: 0.05),
                    ),
                    Text(
                      '(Union Market)',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 10.0, letterSpacing: 0.05),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 36.0, bottom: 12.0, top: 12.0, right: 12.0),
                      child: ImageIcon(
                        AssetImage('images/custom/ic_droppointact.png'),
                        size: 13.3,
                        color: kMainColor,
                      ),
                    ),
                    Text(
                      'Home\t',
                      style: orderMapAppBarTextStyle.copyWith(
                          fontSize: 10.0, letterSpacing: 0.05),
                    ),
                    Text(
                      '(Central Residency)',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 10.0, letterSpacing: 0.05),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'images/map.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                SlideUpPanel(itemName),
              ],
            ),
          ),
          Container(
            height: 60.0,
            color: kCardBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${itemName.length} items  |  \$ 11.50',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

//  GoogleMap buildGoogleMap(_OrderMapState state) {
//    return GoogleMap(
//      initialCameraPosition: CameraPosition(
//       // target: state.pickupLatLng,
//        zoom: 13.0,
//      ),
//      mapType: MapType.normal,
//     // markers: state.markers,
//     // polylines: state.polylines,
//      zoomControlsEnabled: false,
//      onMapCreated: (GoogleMapController controller) {
//        _controller.complete(controller);
//      },
//    );
//  }
}
