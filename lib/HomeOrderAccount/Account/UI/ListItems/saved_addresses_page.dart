import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:flutter/material.dart';

class Address{
  final String icon;
  final String addressType;
  final String address;

  Address(this.icon, this.addressType, this.address);


}

class SavedAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCardBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          title: Text(
            'Saved Addresses',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        body: SavedAddresses());
  }
}

class SavedAddresses extends StatefulWidget {
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  final List<Address> listOfAddressTypes = [
    Address('images/address/ic_homeblk.png', 'Home', 'New York, America'),
    Address('images/address/ic_officeblk.png', 'Office', 'Paris, France'),
    Address('images/address/ic_otherblk.png', 'Other', 'New Delhi, India'),
  ];
  //AddressBloc _addressBloc;
  @override
  void initState() {
    super.initState();
//    _addressBloc = BlocProvider.of<AddressBloc>(context);
//    _addressBloc.add(FetchAddressesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                Divider(
                                  height: 6.0,
                                  color: kCardBackgroundColor,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 6.0),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading:
                            CircleAvatar(
                            radius: 30,
                            backgroundColor: kCardBackgroundColor,
                            child: ImageIcon(
                            AssetImage(listOfAddressTypes[index].icon),
                            color: kMainColor,
                            size: 28,
                            ),
                            ),                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, bottom: 8.0),
                                      child: Text(
                                        listOfAddressTypes[index].addressType,
                                        style: listTitleTextStyle,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        listOfAddressTypes[index].address,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(fontSize: 11.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })),
              BottomBar(
                color: Colors.white,
                text: '+ Add new',
                textColor: kMainColor,
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.locationPage);
                },
              ),
            ],
          );
        }
  }
