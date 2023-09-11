import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:delivoo/Pages/area.dart';
import 'package:delivoo/Pages/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CityActivity extends StatefulWidget {
  @override
  _CityActivityState createState() => _CityActivityState();
}

class Citys {
  final String name;
  final String id;

  Citys(this.id, this.name);

  Citys.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

var citys = new List<Citys>();

class _CityActivityState extends State<CityActivity> {


  bool visibilty = false;

  addStringToSF(String city,String id ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('city', city);
    prefs.setString('city_id', id);






    print("city = " + prefs.getString('city'));
    print("city = " + prefs.getString('city_id'));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AreaActivity()),
    );
  }
  final TextEditingController _searchController = TextEditingController();

  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  _runapi() async {
    String objText = '{"cdblock": "City"}';
    var url = baseUrl + "?req=" + objText;
    print("City Page url = " + url);

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("City Page Response  = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("City Page Response Two = " + rest.toString());

        citys = rest.map((tagJson) => Citys.fromJson(tagJson)).toList();
        print("url3 = " + citys[0].name);
        visibilty = true;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  String Search;

  @override
  void initState() {
    super.initState();

    Search = _searchController.text;
    _runapi();
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: InkWell(
        onTap: () {
          setState(() {

            addStringToSF(citys[index].name,citys[index].id);
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AreaActivity()),
          );
        },
        child: Text(citys[index].name, style: TextStyle(fontSize: 18)),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FirstPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xff7AC920);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xffFFFFFF);
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new



      Scaffold(
      backgroundColor: backgroundcolor,
      body:
      Container(
        child: new Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 50.0, left: 10),
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstPage()),
                            );
                          },
                          child: Image.asset(
                            "images/logos/iconsleft.png", //delivoo logo
                            height: 30,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50.0, left: 10),
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AreaActivity()),
                            );
                          },
                          child: Text(
                            "City",
                            style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50.0,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextFormField(
                                controller: _searchController,
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: 'City Name',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 1, 10),
                        height: 100,
                        alignment: Alignment.topLeft,
                        child:
                        citys.length == 0
                            ?
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                          )
                          ],
                        )
                            :
                        new Stack(
                          children: <Widget>[
                            ListView.builder(
                                padding: EdgeInsets.only(top: 1),
                                itemCount: citys.length,
                                itemBuilder: _buildItemsForListView)
                          ],
                        ),
                      )

//                      ListView.builder( itemCount: citys.length,itemBuilder: _buildItemsForListView)
                    ],
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Image.asset(
                    "images/logos/loginbackimgone.png", //delivoo logo
//                height: 100.0,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    )





    ;
  }
}
