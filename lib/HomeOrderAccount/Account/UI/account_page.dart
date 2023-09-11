import 'package:delivoo/Components/list_tile.dart';
import 'package:delivoo/Pages/CityEditActivity.dart';
import 'package:delivoo/Pages/reset_pass_otp_page.dart';
import 'package:delivoo/Pages/resetpasswordstartingpage.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivoo/Pages/firstpage.dart';
import 'package:delivoo/Pages/contactus.dart';
import 'package:delivoo/Pages/WebViewExample.dart';
import 'package:delivoo/Pages/WebViewExampleTwo.dart';


class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account', style: Theme.of(context).textTheme.bodyText1),
        centerTitle: true,
      ),
      body: Account(),
    );
  }
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String number;
  //AccountBloc _accountBloc;



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserDetails(),

        Divider(
          color: kCardBackgroundColor,
          thickness: 8.0,
        ),
         AddressTile(),
        BuildListTile(
            image: 'images/account/ic_menu_tncact.png',
            text: 'Terms & Conditions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebViewExampleTwo()),
              );
            }
        ),
        BuildListTile(
            image: 'images/account/ic_menu_supportact.png',
            text: 'Contact us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsActivity()),
              );
            }
        ),
        BuildListTile(
          image: 'images/account/ic_menu_aboutact.png',
          text: 'Privacy Policy',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewExample()),
            );
          },
        ),
        BuildListTile(
          image: 'images/account/ic_menu_aboutact.png',
          text: 'Reset Password',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetPasswordStartingPage()),
            );
          },
        ),
         LogoutTile(),
      ],
    );
  }
}

class AddressTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildListTile(
        image: 'images/account/ic_menu_addressact.png',
        text: 'Change Address',
        onTap: ()
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CityEditActivity()),
      );

    });
  }
}

class LogoutTile extends StatelessWidget {


  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();




    DeleteAPI();
  }
  final dbhandler = DbStudentMamager.instance;
  void DeleteAPI() async {
    print('delete row  2 = ');
    var rowall = await dbhandler.deleteLoginResponse();
    print('delete row = '+rowall.toString());
  }
  @override
  Widget build(BuildContext context) {
    return BuildListTile(
      image: 'images/account/ic_menu_logoutact.png',
      text: 'Logout',
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Logging out'),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    textColor: kMainColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                      child: Text('Yes'),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: kTransparentColor)),
                      textColor: kMainColor,
                      onPressed: () {

                        getUserID();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstPage()),
                        );
                      })
                ],
              );
            });
      },
    );
  }
}

class UserDetails extends StatefulWidget {

  @override
  _UserDetailsState createState() => _UserDetailsState();

}
class _UserDetailsState extends State<UserDetails> {
  String UserName, UserID;
  String Mobile;
  String Email;
  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {

  UserID = prefs.getString('id');
  UserName = prefs.getString('name');
  Mobile = prefs.getString('mobile');
  Email = prefs.getString('address');
  });


  }
  @override
  void initState() {
    super.initState();
    getUserID();
    // _accountBloc = BlocProvider.of<AccountBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


          Container( margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Text('\n' + UserName, style: Theme.of(context).textTheme.bodyText1),),

          Container( margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Text('\n' + Mobile, style: Theme.of(context).textTheme.subtitle2.copyWith(color: Color(0xff9a9a9a))),),

          SizedBox(height: 5.0,),

          Container( margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Text(Email, style: Theme.of(context).textTheme.subtitle2.copyWith(color: Color(0xff9a9a9a))),)

        ],
      ),
    );
  }
}
