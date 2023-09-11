import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:delivoo/HomeOrderAccount/home_order_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';


import 'dart:ui' as ui;

import 'dart:io';

import 'package:toast/toast.dart';

class RaiseRequestActivity extends StatefulWidget {
  @override
  _RaiseRequestActivityState createState() => _RaiseRequestActivityState();
}

class Products {
  final String id;
  final String order_code;
  final String invoice_num;
  final String order_status_id;
  final String total_quantity;
  final String sub_total;

  final String total_amt;
  final String active;
  final String delivery_address_id;

  final String payment_id;
  final String created_at;

  Products(
      this.id,
      this.order_code,
      this.invoice_num,
      this.order_status_id,
      this.total_quantity,
      this.sub_total,
      this.total_amt,
      this.active,
      this.delivery_address_id,
      this.payment_id,
      this.created_at);

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        order_code = json['order_code'],
        invoice_num = json['invoice_num'],
        order_status_id = json['order_status_id'],
        total_quantity = json['total_quantity'],
        sub_total = json['sub_total'],
        total_amt = json['total_amt'],
        active = json['active'],
        delivery_address_id = json['delivery_address_id'],
        payment_id = json['payment_id'],
        created_at = json['created_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_code': order_code,
        'invoice_num': invoice_num,
        'order_status_id': order_status_id,
        'total_quantity': total_quantity,
        'sub_total': sub_total,
        'total_amt': total_amt,
        'active': active,
        'delivery_address_id': delivery_address_id,
        'payment_id': payment_id,
        'created_at': created_at,
      };
}

class ProductsList {
  final String price;
  final String product_id;
  final String product_Name;
  final String quantity;
  final String ver_capacity;
  final String ver_unit;

  final String version_id;
  final String imageURL;

  ProductsList(this.price, this.product_id, this.product_Name, this.quantity,
      this.ver_capacity, this.ver_unit, this.version_id, this.imageURL);

  ProductsList.fromJson(Map<String, dynamic> json)
      : price = json['price'],
        product_id = json['product_id'],
        product_Name = json['product_Name'],
        quantity = json['quantity'],
        ver_capacity = json['ver_capacity'],
        ver_unit = json['ver_unit'],
        version_id = json['version_id'],
        imageURL = json['imageURL'];

  Map<String, dynamic> toJson() => {
        'price': price,
        'product_id': product_id,
        'product_Name': product_Name,
        'quantity': quantity,
        'ver_capacity': ver_capacity,
        'ver_unit': ver_unit,
        'version_id': version_id,
        'imageURL': imageURL,
      };
}

class _RaiseRequestActivityState extends State<RaiseRequestActivity> {
  List<String> spinnerItems = [];
  List<String> TypeNew = [];

  List<String> itemmissings = ['Item Missing', 'Damages'];


  List<String> storeitemid = [];
  List<String> storeorderid = [];
  List<String> price_array = [];
  List<String> quantity_array = [];

  List<String> product_Name_array = [];
  List<String> ver_capacity_array = [];
  List<String> ver_unit_array = [];
  List<String> img_array = [];

  List<String> product_id_array = [];
  List<String> storepickter=[];

  String dropdownValue;
  String dropdownValueTwo = 'Item Missing';

  String UserID;
  String OrderID;
  String Invoice_Num_Get;
  String Type = "0";
  List<Products> tagObjs = [];

  List<ProductsList> tagObjslist = [];

  var baseUrls = "https://desiflea.com/admin/api/desifleaapi.php";

  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    setState(() {
      _runapi();
    });
  }

  _runapi_new() async {
    String objText = '{"cdblock": "order_history_details", "cust_id": ' +
        UserID +
        ', "order_id": ' +
        OrderID +
        '}';
    var url = baseUrls + "?req=" + objText;

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("response = " + rest.toString());
        if (tagObjslist.length>0){
          tagObjslist.clear();
        }

        if (storeorderid.length>0){
          storeorderid.clear();
        }

        if (storepickter.length>0){
          storepickter.clear();
        }

        if (storeitemid.length>0){
          storeitemid.clear();
        }

        if (inputs.length>0){
          inputs.clear();
        }

        if (TypeNew.length>0){
          TypeNew.clear();
        }

        if (CheckImage.length>0){
          CheckImage.clear();
        }
        tagObjslist =
            rest.map((tagJson) => ProductsList.fromJson(tagJson)).toList();


        print("response sub_total msl = " +
            tagObjslist[0].price +
            tagObjslist[0].product_Name);
        for (int i = 0; i < tagObjslist.length; i++) {
          inputs.add(false);
          TypeNew.add(Type);
          CheckImage.add(false);

        }
      });
    });
  }

  _runapi() async {
    String objText = '{"cdblock": "itemmissing", "id": ' + UserID + '}';
    var url = baseUrls + "?req=" + objText;

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("response = " + rest.toString());

        tagObjs = rest.map((tagJson) => Products.fromJson(tagJson)).toList();

        //    if(spinnerItems.length >0){
        // //     spinnerItems.clear();
        //    }

        for (int i = 0; i < tagObjs.length; i++) {
          dropdownValue = tagObjs[0].invoice_num + " " + tagObjs[0].created_at;
          OrderID = tagObjs[0].id;
          Invoice_Num_Get = tagObjs[0].id;
          spinnerItems
              .add(tagObjs[i].invoice_num + " " + tagObjs[i].created_at);

          // print("response sub_total = " +
          //     tagObjs[i].invoice_num +
          //     tagObjs[i].created_at);
        }

        _runapi_new();
      });
    });
  }

  void removepic(String item_id){
    for(int i=0; i<storeitemid.length; i++)
    {
      if(storeitemid[i] == item_id)
      {
        storeitemid.removeAt(i);
        storepickter.removeAt(i);
        price_array.removeAt(i);
        quantity_array.removeAt(i);

        product_Name_array.removeAt(i);
        ver_capacity_array.removeAt(i);

        ver_unit_array.removeAt(i);
        img_array.removeAt(i);
        product_id_array.removeAt(i);

        print("checkknowdata  == 8 === " + "Item id Array = "+storeitemid.toString()+" Order id Array = "+storeorderid.toString());
      }

    }
  }

  void removestoreid(String item_id){
    for(int i=0; i<storeitemid.length; i++)
    {
      if(storeitemid[i] == item_id)
      {
        storeitemid.removeAt(i);
        price_array.removeAt(i);
        quantity_array.removeAt(i);

        product_Name_array.removeAt(i);
        ver_capacity_array.removeAt(i);

        ver_unit_array.removeAt(i);
        img_array.removeAt(i);
        product_id_array.removeAt(i);

        print("checkknowdata  == 8 === " + "Item id Array = "+storeitemid.toString()+" Order id Array = "+storeorderid.toString());
      }

    }
  }
  void getstoreid(String item_id, String order_id, String price, String quantity, String product_Name, String ver_capacity, String ver_unit, String img, String product_id){
    storeitemid.add(item_id);
    storeorderid.add(order_id);
    price_array.add(price);


    quantity_array.add(quantity);
    product_Name_array.add(product_Name);
    ver_capacity_array.add(ver_capacity);

    ver_unit_array.add(ver_unit);
    img_array.add(img);
    product_id_array.add(product_id);






    storeitemid = LinkedHashSet<String>.from(storeitemid).toList();


    storeorderid = LinkedHashSet<String>.from(storeorderid).toList();


    print("checkknowdata  == 7 === " + "Item id Array = "+storeitemid.toString()+" Order id Array = "+storeorderid.toString());

  }

  List<bool>  CheckImage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
  }
  static GlobalKey previewContainer = new GlobalKey();

  takeScreenShot() async{
    RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile =new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }
  Future<File> imagefile;


  /// for camera
  String base64Image;
  File tmpFile;
  String errMessage="Error Uploading Image";

  _opencamera() {
    this.setState(() {
      imagefile = ImagePicker.pickImage(source: ImageSource.camera);
      print("lsdjflsjlfjslj 1" + imagefile.toString());
    });
  }
  String status = '';
  setStatus(String message){
    setState(() {
      status = message;
    });
  }
  startUpload(){
    setStatus('upload image');
    if(null == tmpFile){
      return;
    }
    String fileName = tmpFile.path.split('/').last;
  }
  Widget _iamgenew() {
    return FutureBuilder<File>(
      future: imagefile,
      builder:(BuildContext context, AsyncSnapshot < File > snapshot){
        if (snapshot.connectionState == ConnectionState.done && null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          storepickter.add(base64Image);
          storepickter = LinkedHashSet<String>.from(storepickter).toList();
          print("lsdjflsjlfjslj 786 length  =" + storepickter.length.toString());
          print("lsdjflsjlfjslj 786  =" + storepickter.toString());
          return Flexible(
            child: Image.file(snapshot.data,fit: BoxFit.fill,),
          );
        } else if(null != snapshot.error) {
          return const Text('error picking Image', textAlign: TextAlign.center,);
        }else {
          return const Text('no image select', textAlign: TextAlign.center,);
        }
      },

    );

  }
  /// for camera
  List<bool> inputs = new List<bool>();
  void ItemChange(bool val,int index){
    setState(() {
      inputs[index] = val;
      print("Get Check Box Value ="+val.toString());

      if(val){
        print("Get Check Box Value TypeNew[index] ="+TypeNew[index].toString());
        if(TypeNew[index] == "1"){
          _opencamera();
          /// Camera Open
          getstoreid(tagObjslist[index].version_id,
              OrderID,
              tagObjslist[index].price,
              tagObjslist[index].quantity,
              tagObjslist[index].product_Name,
              tagObjslist[index].ver_capacity,
              tagObjslist[index].ver_unit,
              tagObjslist[index].imageURL, tagObjslist[index].product_id);

          CheckImage[index] = true;


        }else {
          CheckImage[index] = false;
          print("Check Image Permission = "+CheckImage.toString());
          getstoreid(tagObjslist[index].version_id,
              OrderID,
              tagObjslist[index].price,
              tagObjslist[index].quantity,
              tagObjslist[index].product_Name,
              tagObjslist[index].ver_capacity,
              tagObjslist[index].ver_unit,
              tagObjslist[index].imageURL, tagObjslist[index].product_id);



        }

      }else {
        if(TypeNew[index] == "1"){
          CheckImage[index] = false;
          removepic(tagObjslist[index].version_id);
          print("Check Image Permission = "+CheckImage.toString());
        }else{
          removestoreid(tagObjslist[index].version_id);
        }


      }
    });
  }
  Container _buildItemsForListView(BuildContext context, int index) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Card(color: Colors.white,child:  Row(
        children: [
          Expanded(flex: 2, child: Image.network(tagObjslist[index].imageURL)),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    tagObjslist[index].product_Name,
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                ),
                Expanded(flex: 5, child:  Text(
                  tagObjslist[index].ver_capacity+" X "+tagObjslist[index].ver_unit,
                  style: TextStyle(fontSize: 11, color: Colors.black),
                ),),
              ],
            ),
          ),
          Expanded(flex: 3, child: Column(
            children: [
              Expanded(
                flex: 5,
                child: CheckImage[index]? new Text(
                  "Picture Uploaded",
                  style: TextStyle(fontSize: 10, color: Color(0xffFF0000)),
                ) : new Container(),
              ),
              Expanded(flex: 5, child:  Text(
                " ₹ "+tagObjslist[index].price,
                style: TextStyle(fontSize: 11, color: Colors.black),
              ),),
              SizedBox(
                height: 0.0,
                width: double.infinity,
                child: _iamgenew(),
              ),
            ],
          ),
          ),

          Expanded(flex: 1, child: Checkbox(
              value: inputs[index],
              onChanged:  (bool val) {
                setState(() {
                  ItemChange(val, index);
                });
              },
          ),
          ),
        ],
      ),),

    );
  }

  String OrderType;
  List<String> result = [];

  String sumiturl;

  String Report ="Report";
  void CalulateValue() async{
    String Delete;
    String objTextss, objTess;
    int totalqty = 0;


    if(storeitemid.length == 0){
      print("url == === === 1  =====");
      Toast.show("Please select item.", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);

    }else {

      print("url == === === 2  =====");
      if (Type=="0"){
        OrderType = "Item Missing";

        print("url == === === 3  =====Size ="+storeitemid.length.toString());
        for (int i =0;i<storeitemid.length; i++){
          print("url == === === 4  =====");
          if (storepickter.length >0) {
            print("url == === === 5  =====");
            int random = new Random().nextInt(1000000) + 100000;
            sumiturl = UserID + (random).toString() + ".jpeg";




          }
          print("url == === === 6  =====");
          print("url == === === 6  =====id "+storeitemid[i]);
          print("url == === === 6  =====price "+price_array[i]);
          print("url == === === 6  ===== quantity "+quantity_array[i]);
          print("url == === === 6  ===== product_Name "+product_Name_array[i]);
          print("url == === === 6  ===== unit " +ver_unit_array[i]);

          print("url == === === 6  ===== img "+img_array[i]);
          print("url == === === 6  ===== product_id " +product_id_array[i]);
          // print("url == === === 6  ===== pic "+storepickter[i]);
          // print("url == === === 6  ===== imgname " +sumiturl[i]);

          objTextss = '{"id": "'+ storeitemid[i]+
              '", "price": "' +
              price_array[i] +
              '", "quantity": "' +
              quantity_array[i] +
              '", "product_Name": "' +
              product_Name_array[i] +
              '", "ver_capacity": "' +
              ver_capacity_array[i] +
              '", "ver_unit": "' +
              ver_unit_array[i] +
              '", "img": "' +
              img_array[i] +
              '", "product_id": "' +
              product_id_array[i] +

              '", "pic": ' +
              '""' +
              ', "imgname": ' +
              '""' +
              '}';

          result.add(objTextss);
          print("url == === === 7  ====="+result.toString());
        }
      }else {
        OrderType = "Damages";
        for (int i =0;i<storeitemid.length; i++){




          if (storepickter.length >0) {
            print("url == === === 8  =====");
            int random = new Random().nextInt(1000000) + 100000;
            sumiturl = UserID + (random).toString() + ".jpeg";




          }
          objTextss = '{"id": '+ storeitemid[i]+
              ', "price": "' +
              price_array[i] +
              '", "quantity": ' +
              quantity_array[i] +
              '", "product_Name": "' +
              product_Name_array[i] +
              '", "ver_capacity": "' +
              ver_capacity_array[i] +
              '", "ver_unit": "' +
              ver_unit_array[i] +
              '", "img": "' +
              img_array[i] +
              '", "product_id": "' +
              product_id_array[i] +
              '", "pic": "' +
              storepickter[i] +
              '", "imgname": "' +
              sumiturl +
              '"}';

          result.add(objTextss);
          print("url == === === 9  ====="+result.toString());
        }
      }

    }

    String objText = '{"cdblock": "raiseRequest", "cust_id": "' +
        UserID +
        '", "order_id": "' +
        OrderID +
        '", "Invoice_Num": "' +
        Invoice_Num_Get +
        '", "order_type": "' +
        OrderType +

        '", "order_items": ' +
        result.toString() +
        '}';

    var url = baseUrls + "?req=" + objText;


    print("url == === === "+url);

    http.get(url).then((response) {
      setState(() {
        // var data = json.decode(response.body);

        print("response = " + response.body);


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeOrderAccount()),
        );

      });
    });

    // print("this is new world = "+objText);

  }


  File _image;
  final picker = ImagePicker();

  Future<void> retrieveLostData() async {
    final LostData response =
    await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        // if (response.type == RetrieveType.video) {
        //   _handleVideo(response.file);
        // } else {
        //   _handleImage(response.file);
        // }
      });
    } else {
      // _handleError(response.exception);
    }
  }
  Future getImage() async {
    LostDataResponse response = await ImagePicker.retrieveLostData();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  void openGallery() async{
    var iamge = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = iamge;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Raise Request',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 23,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Order (Invoice no):-",
                      style: TextStyle(fontSize: 15, color: Color(0xff000000)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 1, 0, 0),
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String data) {
                        setState(() {
                          dropdownValue = data;

                          int index = spinnerItems.indexOf(data);
                          Invoice_Num_Get = tagObjs[index].invoice_num;
                          OrderID = tagObjs[index].id;

                          print("Order ID = " + OrderID);

                          _runapi_new();
                        });
                      },
                      items: spinnerItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
//          Text('Selected Item = ' + '$dropdownValue',
//              style: TextStyle(fontSize: 22, color: Colors.black)),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Damages / Item Missing:-",
                      style: TextStyle(fontSize: 15, color: Color(0xff000000)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 1, 0, 0),
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: DropdownButton<String>(
                      value: dropdownValueTwo,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String data) {
                        setState(() {
                          dropdownValueTwo = data;
                          if (data == 'Item Missing') {
                            Type = "0";
                          } else {
                            Type = "1";
                          }

                          _runapi_new();
                        });
                      },
                      items: itemmissings
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  Divider(color: Colors.black),
                ],
              )),
          Expanded(
              flex: 67,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 1, 0),
                    height: 500,
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: <Widget>[
                        ListView.builder(
                            padding: EdgeInsets.only(top: 10),
                            itemCount: tagObjslist.length,
                            itemBuilder: _buildItemsForListView)
                      ],
                    ),
                  )
                ],
              )),
          Expanded(
            flex: 10,
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(),
                ),
                onPressed: () {

                  setState(() {
                    if(Report == "Please Wait"){

                    }else{
                      CalulateValue();
                    }
                    Report ="Please Wait";


                  });



                },
                child: Text(
                  Report,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
