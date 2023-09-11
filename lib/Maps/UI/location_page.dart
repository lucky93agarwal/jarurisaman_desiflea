import 'package:delivoo/Components/bottom_bar.dart';
import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Maps/Components/address_type_button.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

TextEditingController _addressController = TextEditingController();

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SetLocation();
  }
}

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  bool isCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(126.0),
        child: CustomAppBar(
//              boxShadow: BoxShadow(
//                color: Colors.grey.shade600,
//                offset: Offset(0.0, 2.0),
//                blurRadius: 5.0,
//              ),
//              color: Colors.white,
          titleWidget: Text(
            'Set delivery location',
            style: TextStyle(fontSize: 16.7),
          ),
          onTap: null,
          hint: 'Enter location',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'images/map.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 36.0),
                      child: Image.asset(
                        'images/map_pin.png',
                        height: 36,
                      ),
                    ))
              ],
            ),
          ),
          Container(
            color: kCardBackgroundColor,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/map_pin.png',
                  scale: 2.5,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Text(
                    'Paris, France',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ),
          isCard ? SaveAddressCard() : Container(),
          BottomBar(
              text: "Continue",
              onTap: () {
                if (isCard == false) {
                  setState(() {
                    isCard = true;
                  });
                } else {
                  Navigator.popAndPushNamed(
                      context, PageRoutes.homeOrderAccountPage);
                }
              }),
        ],
      ),
    );
  }
}

enum AddressType {
  Home,
  Office,
  Other,
}
AddressType selectedAddress = AddressType.Other;

class SaveAddressCard extends StatefulWidget {
  @override
  _SaveAddressCardState createState() => _SaveAddressCardState();
}

class _SaveAddressCardState extends State<SaveAddressCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: EntryField(
            controller: _addressController,
            label: 'FLAT NUM, LANDMARK, APARTMENT, ETC.',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'SAVE ADDRESS AS',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AddressTypeButton(
                label: 'Home',
                image: 'images/address/ic_homeblk.png',
                onPressed: () {
                  setState(() {
                    selectedAddress = AddressType.Home;
                  });
                },
                isSelected: selectedAddress == AddressType.Home,
              ),
              AddressTypeButton(
                label: 'Office',
                image: 'images/address/ic_officeblk.png',
                onPressed: () {
                  setState(() {
                    selectedAddress = AddressType.Office;
                  });
                },
                isSelected: selectedAddress == AddressType.Office,
              ),
              AddressTypeButton(
                label: 'Other',
                image: 'images/address/ic_otherblk.png',
                onPressed: () {
                  setState(() {
                    selectedAddress = AddressType.Other;
                  });
                },
                isSelected: selectedAddress == AddressType.Other,
              ),
            ],
          ),
        )
      ],
    );
  }
}
