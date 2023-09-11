import 'package:delivoo/Pages/area.dart';
import 'package:delivoo/Pages/city.dart';
import 'package:delivoo/Pages/firstpage.dart';
import 'package:delivoo/Pages/login_address_activity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SocietyActivity extends StatefulWidget {
  @override
  _SocietyActivityState createState() => _SocietyActivityState();
}

class Societys {
  final String name;
  final String id;

  Societys(this.id, this.name);

  Societys.fromJson(Map<String, dynamic> json)
      : id = json['soc_id'],
        name = json['soc_name'];

  Map<String, dynamic> toJson() => {
        'soc_id': id,
        'soc_name': name,
      };
}

var societys = new List<Societys>();


var searchtext = new List<Societys>();

class _SocietyActivityState extends State<SocietyActivity> {
  final TextEditingController _societyController = TextEditingController();

  addStringToSF(String society, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('society', society);
    prefs.setString('society_id', society);

    print("society_id = " + prefs.getString('society_id'));
    print("society = " + prefs.getString('society'));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginAddressActivty()),
    );
  }

  @override
  void dispose() {
    _societyController.dispose();
    super.dispose();
  }

  String society_id;
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

  _runapi() async {



    if(societys.length >0){
      societys.clear();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("area = " + prefs.getString('area'));
    print("area_id = " + prefs.getString('area_id'));
    society_id = prefs.getString('area_id');
    String objText = '{"cdblock": "society","id": ' + society_id + '}';
    var url = baseUrl + "?req=" + objText;
    print("url society  = " + url);

    // { "response": [{"result":"Success","area_id":"1","area_name":"Gaur City 1","city_id":"1"},{"result":"Success","area_id":"2","area_name":"Gaur City 2","city_id":"1"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("url2 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        // [{result: Success, area_id: 1, area_name: Gaur City 1, city_id: 1}, {result: Success, area_id: 2, area_name: Gaur City 2, city_id: 1}]

        print("url3333 = " + rest.toString());

        societys = rest.map((tagJson) => Societys.fromJson(tagJson)).toList();
        print("url333 = " + societys[0].name);
      });
    });
  }

  String Search;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Search = _societyController.text;
    _runapi();
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: InkWell(
        onTap: () {
          setState(() {
            addStringToSF(societys[index].name, societys[index].id);
          });

        },
        child: Text(societys[index].name, style: TextStyle(fontSize: 18)),
      ),
    );
  }



  ListTile _buildItemsForListViewnew(BuildContext context, int index) {
    return ListTile(
      title: InkWell(
        onTap: () {
          setState(() {
            addStringToSF(searchtext[index].name, searchtext[index].id);
          });

        },
        child: Text(searchtext[index].name, style: TextStyle(fontSize: 18)),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchtext.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    societys.forEach((userDetail) {
      if (userDetail.name.contains(text))
        searchtext.add(userDetail);
    });

    setState(() {


    });
  }



  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xff7AC920);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xffFFFFFF);
    return





      Scaffold(
      backgroundColor: backgroundcolor,
      body: Container(
        child: new Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(flex:7,child: Column(children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: <Widget>[
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
                              "Society",
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
                  SizedBox(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 55.0,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextFormField(
                                  controller: _societyController,
                                  onChanged: onSearchTextChanged,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: 'Society Name',
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
                  SizedBox(
                    height: 400,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 1, 10),
                          height: 380,
                          alignment: Alignment.topLeft,
                          child:
                          societys.length == 0?
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                            )],
                          ) :  searchtext.length != 0?new Stack(
                            children: <Widget>[
                              ListView.builder(
                                  padding: EdgeInsets.only(top: 10),
                                  itemCount: searchtext.length,
                                  itemBuilder: _buildItemsForListViewnew)
                            ],
                          ):new

                          Stack(
                            children: <Widget>[
                              ListView.builder(
                                  padding: EdgeInsets.only(top: 10),
                                  itemCount: societys.length,
                                  itemBuilder: _buildItemsForListView)
                            ],
                          ),
                        )

//
                      ],
                    ),
                  ),
                ],)),
                Expanded(flex: 3,child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    "images/logos/loginbackimgone.png", //delivoo logo
//                height: 100.0,
                    width: double.infinity,
                  ),
                ),)

              ],
            ),
          ],
        ),
      ),
    )


    ;
  }
}
