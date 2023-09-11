import 'dart:convert';
import 'package:delivoo/Pages/CityEditActivity.dart';
import 'package:delivoo/Pages/SocietyEditActivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;





class AreaEditActivity extends StatefulWidget {
  final String CityName;
  final String Cityid;
  AreaEditActivity({this.Cityid,this.CityName});
  @override
  _AreaEditActivityState createState() => _AreaEditActivityState();
}
class Areas {
  final String name;
  final String id;

  Areas(this.id, this.name);

  Areas.fromJson(Map<String, dynamic> json)
      : id = json['area_id'],
        name = json['area_name'];

  Map<String, dynamic> toJson() => {
    'area_id': id,
    'area_name': name,
  };
}
var areas = new List<Areas>();

class _AreaEditActivityState extends State<AreaEditActivity> {

  String City_Name;


  addStringToSF(String area,String id ) async {


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SocietyEditActivity(CityName:City_Name, Cityid:Cityids, AreaName:area, Areaid:id)),
    );
  }


  final TextEditingController _areaController = TextEditingController();
  @override
  void dispose() {
    _areaController.dispose();


    super.dispose();
  }


  String city_id;
  var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";
  _runapi() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("city = " + prefs.getString('city'));
    // print("city id = " + prefs.getString('city_id'));
    // city_id = prefs.getString('city_id');
    String objText = '{"cdblock": "area","id": '+Cityids+'}';
    var url = baseUrl + "?req=" + objText;
    print("url = " + url);

    // { "response": [{"result":"Success","area_id":"1","area_name":"Gaur City 1","city_id":"1"},{"result":"Success","area_id":"2","area_name":"Gaur City 2","city_id":"1"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        print("url2 = " + values);

        var data = json.decode(response.body);
        var rest = data["response"] as List;
        // [{result: Success, area_id: 1, area_name: Gaur City 1, city_id: 1}, {result: Success, area_id: 2, area_name: Gaur City 2, city_id: 1}]

        print("url3 = " + rest.toString());

        areas = rest.map((tagJson) => Areas.fromJson(tagJson)).toList();
        print("url3 = " + areas[0].name);
      });
    });
  }
  String Search;
  String Cityids;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    City_Name = widget.CityName;
    Cityids = widget.Cityid;
    Search = _areaController.text;


    print("Check Address Update Area City_Name = = ="+City_Name.toString());
    print("Check Address Update Area Cityids = = ="+Cityids.toString());

    _runapi();
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: InkWell(
        onTap: () {
          setState(() {

            addStringToSF(areas[index].name, areas[index].id);
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AreaActivity()),
          // );
        },
        child: Text(areas[index].name, style: TextStyle(fontSize: 18)),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CityEditActivity()),
    );
  }
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xff7AC920);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xffFFFFFF);
    return  new WillPopScope(
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
                                      builder: (context) => CityEditActivity()),
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => AreaActivity()),
                                // );
                              },
                              child: Text(
                                "Area",
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
//                  Container(
//                    margin: const EdgeInsets.only(top: 50.0, left: 10),
//                    child: new Text(
//                      "",
//                      style: TextStyle(color: black, fontSize: 18,fontWeight: FontWeight.bold),
//                    ),
//                  ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 50.0,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TextFormField(
                                    controller: _areaController,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Area Name',
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
                            height: 300,
                            alignment: Alignment.topLeft,
                            child: areas.length == 0?


                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                              )],
                            )

                                :



                            new



                            Stack(
                              children: <Widget>[
                                ListView.builder(
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: areas.length,
                                    itemBuilder: _buildItemsForListView)
                              ],
                            ),
                          )

//
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
