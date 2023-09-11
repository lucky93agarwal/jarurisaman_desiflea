import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:delivoo/Pages/delivery_slot.dart';
import 'package:delivoo/Pages/view_cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivoo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:delivoo/Components/custom_appbar.dart';
import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Components/reusable_card.dart';
import 'dart:io';
import 'package:delivoo/Models/SubCategory.dart';
import 'package:delivoo/Controller/HomeController.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/Stores/stores.dart';
import 'package:delivoo/HomeOrderAccount/Home/UI/custom_delivery.dart';
import 'package:delivoo/Models/Category.dart';
import 'package:delivoo/Pages/contactus.dart';
import 'package:delivoo/Pages/items.dart';
import 'package:delivoo/Pages/itemslist.dart';
import 'package:delivoo/Pages/myorde.dart';
import 'package:delivoo/Pages/product_details_page.dart';
import 'package:delivoo/Pages/raise_request.dart';
import 'package:delivoo/Pages/refer_page.dart';
import 'package:delivoo/Pages/search_product_page.dart';
import 'package:delivoo/Pages/wallet_history.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:delivoo/Themes/style.dart';
import 'package:delivoo/database/DbStudentMamager.dart';
import 'package:delivoo/dialogs/exit_confirmation_dialog.dart';
import 'package:delivoo/helpers/dialog_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../API.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class MasterCategory {
  final String name;
  final String img;
  final String id;

  MasterCategory(this.name, this.img, this.id);

  MasterCategory.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = json['image'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': img,
        'id': id,
      };
}

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

ProductModelSec productModelFromJsons(String str) =>
    ProductModelSec.fromJson(json.decode(str));

String productModelToJsons(ProductModelSec data) => json.encode(data.toJson());

ProductModelImage productModelFromJsonss(String str) =>
    ProductModelImage.fromJson(json.decode(str));

String productModelToJsonss(ProductModelImage data) =>
    json.encode(data.toJson());

ProductModelImageOne productModelFromJsonss_one(String str) =>
    ProductModelImageOne.fromJson(json.decode(str));

String productModelToJsonssOne(ProductModelImageOne data) =>
    json.encode(data.toJson());



ProductModelImageSix productModelFromJsonss_six(String str) =>
    ProductModelImageSix.fromJson(json.decode(str));

String productModelToJsonssSix(ProductModelImageSix data) =>
    json.encode(data.toJson());



ProductModelImage7 productModelFromJsonss_7(String str) =>
    ProductModelImage7.fromJson(json.decode(str));

String productModelToJsonss7(ProductModelImage7 data) =>
    json.encode(data.toJson());


ProductModelImage8 productModelFromJsonss_8(String str) =>
    ProductModelImage8.fromJson(json.decode(str));

String productModelToJsonss8(ProductModelImage8 data) =>
    json.encode(data.toJson());


ProductModelImage9 productModelFromJsonss_9(String str) =>
    ProductModelImage9.fromJson(json.decode(str));

String productModelToJsonss9(ProductModelImage9 data) =>
    json.encode(data.toJson());


ProductModelImage10 productModelFromJsonss_10(String str) =>
    ProductModelImage10.fromJson(json.decode(str));

String productModelToJsonss10(ProductModelImage10 data) =>
    json.encode(data.toJson());








ProductModeldesi productModelFromJsondesi(String str) =>
    ProductModeldesi.fromJson(json.decode(str));

String productModelToJsondesi(ProductModeldesi data) =>
    json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.response,
  });

  List<List<Response>> response;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        response: List<List<Response>>.from(json["response"].map(
            (x) => List<Response>.from(x.map((x) => Response.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ProductModelSec {
  ProductModelSec({
    this.response,
  });

  List<List<ResponseSec>> response;

  factory ProductModelSec.fromJson(Map<String, dynamic> json) =>
      ProductModelSec(
        response: List<List<ResponseSec>>.from(json["response"].map((x) =>
            List<ResponseSec>.from(x.map((x) => ResponseSec.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ProductModelImage {
  ProductModelImage({
    this.response,
  });

  List<ResponseImage> response;

  factory ProductModelImage.fromJson(Map<String, dynamic> json) =>
      ProductModelImage(
        response: List<ResponseImage>.from(
            json["response"].map((x) => ResponseImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class ProductModelImageOne {
  ProductModelImageOne({
    this.response,
  });

  List<ResponseImageOne> response;

  factory ProductModelImageOne.fromJson(Map<String, dynamic> json) =>
      ProductModelImageOne(
        response: List<ResponseImageOne>.from(
            json["response"].map((x) => ResponseImageOne.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}


class ProductModelImageSix {
  ProductModelImageSix({
    this.response,
  });

  List<ResponseImageSix> response;

  factory ProductModelImageSix.fromJson(Map<String, dynamic> json) =>
      ProductModelImageSix(
        response: List<ResponseImageSix>.from(
            json["response"].map((x) => ResponseImageSix.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class ProductModelImage7 {
  ProductModelImage7({
    this.response,
  });

  List<ResponseImage7> response;

  factory ProductModelImage7.fromJson(Map<String, dynamic> json) =>
      ProductModelImage7(
        response: List<ResponseImage7>.from(
            json["response"].map((x) => ResponseImage7.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}




class ProductModelImage8 {
  ProductModelImage8({
    this.response,
  });

  List<ResponseImage8> response;

  factory ProductModelImage8.fromJson(Map<String, dynamic> json) =>
      ProductModelImage8(
        response: List<ResponseImage8>.from(
            json["response"].map((x) => ResponseImage8.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

var subCategory = new List<SubCategory>();
class ProductModelImage9 {
  ProductModelImage9({
    this.response,
  });

  List<ResponseImage9> response;

  factory ProductModelImage9.fromJson(Map<String, dynamic> json) =>
      ProductModelImage9(
        response: List<ResponseImage9>.from(
            json["response"].map((x) => ResponseImage9.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class ProductModelImage10 {
  ProductModelImage10({
    this.response,
  });

  List<ResponseImage10> response;

  factory ProductModelImage10.fromJson(Map<String, dynamic> json) =>
      ProductModelImage10(
        response: List<ResponseImage10>.from(
            json["response"].map((x) => ResponseImage10.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class ProductModelImageTwo {
  ProductModelImageTwo({
    this.response,
  });

  List<ResponseImageTwo> response;

  factory ProductModelImageTwo.fromJson(Map<String, dynamic> json) =>
      ProductModelImageTwo(
        response: List<ResponseImageTwo>.from(
            json["response"].map((x) => ResponseImageTwo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class ProductModelImageBig {
  ProductModelImageBig({
    this.response,
  });

  List<ResponseImageBig> response;

  factory ProductModelImageBig.fromJson(Map<String, dynamic> json) =>
      ProductModelImageBig(
        response: List<ResponseImageBig>.from(
            json["response"].map((x) => ResponseImageBig.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class ProductModeldesi {
  ProductModeldesi({
    this.response,
  });

  List<List<DesiProductsResponse>> response;

  factory ProductModeldesi.fromJson(Map<String, dynamic> json) =>
      ProductModeldesi(
        response: List<List<DesiProductsResponse>>.from(json["response"].map(
            (x) => List<Response>.from(
                x.map((x) => DesiProductsResponse.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

// class ProductModeldesi{
//   ProductModeldesi({
//     this.response,
//   });
//
//   List<DesiProductsResponse> response;
//
//   factory ProductModeldesi.fromJson(Map<String, dynamic> json) =>
//       ProductModeldesi(
//         response: List<DesiProductsResponse>.from(
//             json["response"].map((x) => DesiProductsResponse.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() =>
//       {
//         "response": List<dynamic>.from(response.map((x) => x.toJson())),
//       };
// }

// /// first banner
// class ProductModelBannerImage {
//   ProductModelBannerImage({
//     this.response,
//   });
//
//   List<ResponseBannerImageOne> response;
//
//   factory ProductModelBannerImage.fromJson(Map<String, dynamic> json) =>
//       ProductModelBannerImage(
//         response: List<ResponseBannerImageOne>.from(
//             json["response"].map((x) => ProductModelBannerImage.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "response": List<dynamic>.from(response.map((x) => x.toJson())),
//   };
// }

var topSearchResponse = new List<TopSearchResponse>();
var desiProductsResponse = new List<DesiProductsResponse>();

var topBestSellsResponse = new List<TopBestSellsResponse>();

class TopSearchResponse {
  final String product_id;
  final String id;
  final String store_id;
  final String version_id;
  final String ver_short_desc;
  final String ver_capacity;
  final String ver_unit;
  final String ver_price;

  final String offer_price;
  final String is_out_of_stock;
  final String name;
  final String description;
  final String image1;

  TopSearchResponse(
      this.product_id,
      this.id,
      this.store_id,
      this.version_id,
      this.ver_short_desc,
      this.ver_capacity,
      this.ver_unit,
      this.ver_price,
      this.offer_price,
      this.is_out_of_stock,
      this.name,
      this.description,
      this.image1);

  TopSearchResponse.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'],
        id = json['id'],
        store_id = json['store_id'],
        version_id = json['version_id'],
        ver_short_desc = json['ver_short_desc'],
        ver_capacity = json['ver_capacity'],
        ver_unit = json['ver_unit'],
        ver_price = json['ver_price'],
        offer_price = json['offer_price'],
        is_out_of_stock = json['product_id'],
        name = json['name'],
        description = json['description'],
        image1 = json['prod_pic1'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
class DesiProductsResponse {
  DesiProductsResponse({
    this.product_id,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String product_id;
  String name;
  String description;
  String image1;
  List<DesiProductsItem> items;

  factory DesiProductsResponse.fromJson(Map<String, dynamic> json) => DesiProductsResponse(
    product_id: json["product_id"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],
    items: List<DesiProductsItem>.from(json["items"].map((x) => DesiProductsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_id": product_id,
    "name": name,
    "description": description,
    "image1": image1,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}
class DesiProductsItem {
  DesiProductsItem({
    this.id,
    this.store_id,
    this.product_id,
    this.version_id,
    this.ver_short_desc,
    this.ver_capacity,
    this.ver_unit,
    this.ver_price,
    this.offer_price,
    this.is_out_of_stock,
  });

  String id;
  String store_id;
  String product_id;
  String version_id;
  String ver_short_desc;
  String ver_capacity;
  String ver_unit;
  String ver_price;
  String offer_price;
  String is_out_of_stock;

  factory DesiProductsItem.fromJson(Map<String, dynamic> json) => DesiProductsItem(
    id: json["id"],
    store_id: json["store_id"],
    product_id: json["product_id"],
    version_id: json["version_id"],
    ver_short_desc: json["ver_short_desc"],
    ver_capacity: json["ver_capacity"],
    ver_unit: json["ver_unit"],
    ver_price: json["ver_price"],
    offer_price: json["offer_price"],
    is_out_of_stock: json["is_out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": store_id,
    "product_id": product_id,
    "version_id": version_id,
    "ver_short_desc": ver_short_desc,
    "ver_capacity": ver_capacity,
    "ver_unit": ver_unit,
    "ver_price": ver_price,
    "offer_price": offer_price,
    "is_out_of_stock": is_out_of_stock,
  };
}
class TopBestSellsResponse {
  final String product_id;
  final String id;
  final String store_id;
  final String version_id;
  final String ver_short_desc;
  final String ver_capacity;
  final String ver_unit;
  final String ver_price;

  final String offer_price;
  final String is_out_of_stock;
  final String name;
  final String description;
  final String image1;

  TopBestSellsResponse(
      this.product_id,
      this.id,
      this.store_id,
      this.version_id,
      this.ver_short_desc,
      this.ver_capacity,
      this.ver_unit,
      this.ver_price,
      this.offer_price,
      this.is_out_of_stock,
      this.name,
      this.description,
      this.image1);

  TopBestSellsResponse.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'],
        id = json['id'],
        store_id = json['store_id'],
        version_id = json['version_id'],
        ver_short_desc = json['ver_short_desc'],
        ver_capacity = json['ver_capacity'],
        ver_unit = json['ver_unit'],
        ver_price = json['ver_price'],
        offer_price = json['offer_price'],
        is_out_of_stock = json['product_id'],
        name = json['name'],
        description = json['description'],
        image1 = json['image1'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
class Response {
  Response({
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<Item> items;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
class ResponseSec {
  ResponseSec({
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemSec> items;

  factory ResponseSec.fromJson(Map<String, dynamic> json) => ResponseSec(
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items:
            List<ItemSec>.from(json["items"].map((x) => ItemSec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
class ResponseImage {
  ResponseImage({
    this.result,
    this.image,
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImage> items;

  factory ResponseImage.fromJson(Map<String, dynamic> json) => ResponseImage(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImage>.from(
            json["items"].map((x) => ItemImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "image": image,
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
class ResponseImageOne {
  ResponseImageOne({
    this.result,
    this.image,
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImageOne> items;

  factory ResponseImageOne.fromJson(Map<String, dynamic> json) =>
      ResponseImageOne(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImageOne>.from(
            json["items"].map((x) => ItemImageOne.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "image": image,
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}



class ResponseImageSix {
  ResponseImageSix({
    this.result,
    this.image,
    this.catId,
    this.index,
    this.cat_name,
    this.category_id,
    this.sub_category_id,
    this.btype,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String index;
  String cat_name;
  String category_id;
  String sub_category_id;
  String btype;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImageSix> items;

  factory ResponseImageSix.fromJson(Map<String, dynamic> json) =>
      ResponseImageSix(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        index: json["index"],
        cat_name: json["cat_name"],
        category_id: json["category_id"],
        sub_category_id: json["sub_category_id"],
        btype: json["btype"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImageSix>.from(
            json["items"].map((x) => ItemImageSix.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "image": image,
    "cat_id": catId,
    "index": index,
    "cat_name": cat_name,
    "category_id": category_id,
    "sub_category_id": sub_category_id,
    "btype": btype,
    "product_id": productId,
    "name": name,
    "description": description,
    "image1": image1,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}


class ResponseImage7 {
  ResponseImage7({
    this.result,
    this.image,
    this.catId,

    this.category_id,
    this.sub_category_id,
    this.btype,
    this.index,
    this.cat_name,

    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String index;
  String cat_name;
  String category_id;
  String sub_category_id;
  String btype;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImage7> items;

  factory ResponseImage7.fromJson(Map<String, dynamic> json) =>
      ResponseImage7(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        index: json["index"],
        cat_name: json["cat_name"],
        category_id: json["category_id"],
        sub_category_id: json["sub_category_id"],
        btype: json["btype"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImage7>.from(
            json["items"].map((x) => ItemImage7.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "image": image,
    "cat_id": catId,
    "index": index,
    "cat_name": cat_name,
    "category_id": category_id,
    "sub_category_id": sub_category_id,
    "btype": btype,
    "product_id": productId,
    "name": name,
    "description": description,
    "image1": image1,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ResponseImage8 {
  ResponseImage8({
    this.result,
    this.image,
    this.catId,
    this.index,
    this.cat_name,
    this.category_id,
    this.sub_category_id,
    this.btype,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String cat_name;
  String index;
  String category_id;
  String sub_category_id;
  String btype;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImage8> items;

  factory ResponseImage8.fromJson(Map<String, dynamic> json) =>
      ResponseImage8(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        index: json["index"],
        cat_name: json["cat_name"],
        category_id: json["category_id"],
        sub_category_id: json["sub_category_id"],
        btype: json["btype"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImage8>.from(
            json["items"].map((x) => ItemImage8.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "image": image,
    "cat_id": catId,
    "index": index,
    "cat_name": cat_name,
    "category_id": category_id,
    "sub_category_id": sub_category_id,
    "btype": btype,
    "product_id": productId,
    "name": name,
    "description": description,
    "image1": image1,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ResponseImage9 {
  ResponseImage9({
    this.result,
    this.image,
    this.catId,
    this.index,
    this.cat_name,
    this.category_id,
    this.sub_category_id,
    this.btype,

    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String category_id;
  String sub_category_id;
  String btype;

  String index;
  String cat_name;

  String productId;
  String name;
  String description;
  String image1;
  List<ItemImage9> items;

  factory ResponseImage9.fromJson(Map<String, dynamic> json) =>
      ResponseImage9(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],

        index: json["index"],
        cat_name: json["cat_name"],
        category_id: json["category_id"],
        sub_category_id: json["sub_category_id"],
        btype: json["btype"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImage9>.from(
            json["items"].map((x) => ItemImage9.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "image": image,
    "cat_id": catId,

    "index": index,
    "cat_name": cat_name,
    "category_id": category_id,
    "sub_category_id": sub_category_id,
    "btype": btype,
    "product_id": productId,
    "name": name,
    "description": description,
    "image1": image1,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}


class ResponseImage10 {
  ResponseImage10({
    this.result,
    this.image,
    this.catId,
    this.productId,
    this.index,
    this.cat_name,
    this.category_id,
    this.sub_category_id,
    this.btype,

    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String index;
  String cat_name;
  String category_id;
  String sub_category_id;
  String btype;

  String productId;
  String name;
  String description;
  String image1;
  List<ItemImage10> items;

  factory ResponseImage10.fromJson(Map<String, dynamic> json) =>
      ResponseImage10(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        index: json["index"],
        cat_name: json["cat_name"],
        category_id: json["category_id"],
        sub_category_id: json["sub_category_id"],
        btype: json["btype"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImage10>.from(
            json["items"].map((x) => ItemImage10.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "image": image,
    "cat_id": catId,
    "index": index,
    "cat_name": cat_name,
    "category_id": category_id,
    "sub_category_id": sub_category_id,
    "btype": btype,
    "product_id": productId,
    "name": name,
    "description": description,
    "image1": image1,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

/// first banner
class ResponseBannerImageOne {
  ResponseBannerImageOne({
    this.result,
    this.image,
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemBannerImageOne> items;

  factory ResponseBannerImageOne.fromJson(Map<String, dynamic> json) =>
      ResponseBannerImageOne(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemBannerImageOne>.from(
            json["items"].map((x) => ItemBannerImageOne.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "image": image,
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

/// two banner
class ResponseBannerImageTwo {
  ResponseBannerImageTwo({
    this.result,
    this.image,
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemBannerImageTwo> items;

  factory ResponseBannerImageTwo.fromJson(Map<String, dynamic> json) =>
      ResponseBannerImageTwo(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemBannerImageTwo>.from(
            json["items"].map((x) => ItemBannerImageTwo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "image": image,
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ResponseImageTwo {
  ResponseImageTwo({
    this.result,
    this.image,
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String image;
  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImageTwo> items;

  factory ResponseImageTwo.fromJson(Map<String, dynamic> json) =>
      ResponseImageTwo(
        result: json["result"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImageTwo>.from(
            json["items"].map((x) => ItemImageTwo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "image": image,
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ResponseImageBig {
  ResponseImageBig({
    this.result,
    this.title,
    this.image,
    this.catId,
    this.productId,
    this.name,
    this.description,
    this.image1,
    this.items,
  });

  String result;
  String title;
  String image;
  String catId;
  String productId;
  String name;
  String description;
  String image1;
  List<ItemImageBig> items;

  factory ResponseImageBig.fromJson(Map<String, dynamic> json) =>
      ResponseImageBig(
        result: json["result"],
        title: json["title"],
        image: json["image"],
        catId: json["cat_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        items: List<ItemImageBig>.from(
            json["items"].map((x) => ItemImageBig.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "title": title,
        "image": image,
        "cat_id": catId,
        "product_id": productId,
        "name": name,
        "description": description,
        "image1": image1,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

class ItemSec {
  ItemSec({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemSec.fromJson(Map<String, dynamic> json) => ItemSec(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

class ItemImage {
  ItemImage({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImage.fromJson(Map<String, dynamic> json) => ItemImage(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

/// first banner
class ItemBannerImageOne {
  ItemBannerImageOne({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemBannerImageOne.fromJson(Map<String, dynamic> json) =>
      ItemBannerImageOne(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

/// two banner
class ItemBannerImageTwo {
  ItemBannerImageTwo({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemBannerImageTwo.fromJson(Map<String, dynamic> json) =>
      ItemBannerImageTwo(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

class ItemImageOne {
  ItemImageOne({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImageOne.fromJson(Map<String, dynamic> json) => ItemImageOne(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}


class ItemImageSix {
  ItemImageSix({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImageSix.fromJson(Map<String, dynamic> json) => ItemImageSix(
    id: json["id"],
    storeId: json["store_id"],
    productId: json["product_id"],
    versionId: json["version_id"],
    verShortDesc: json["ver_short_desc"],
    verCapacity: json["ver_capacity"],
    verUnit: json["ver_unit"],
    verPrice: json["ver_price"],
    offerPrice: json["offer_price"],
    isOutOfStock: json["is_out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "product_id": productId,
    "version_id": versionId,
    "ver_short_desc": verShortDesc,
    "ver_capacity": verCapacity,
    "ver_unit": verUnit,
    "ver_price": verPrice,
    "offer_price": offerPrice,
    "is_out_of_stock": isOutOfStock,
  };
}


class ItemImage7 {
  ItemImage7({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImage7.fromJson(Map<String, dynamic> json) => ItemImage7(
    id: json["id"],
    storeId: json["store_id"],
    productId: json["product_id"],
    versionId: json["version_id"],
    verShortDesc: json["ver_short_desc"],
    verCapacity: json["ver_capacity"],
    verUnit: json["ver_unit"],
    verPrice: json["ver_price"],
    offerPrice: json["offer_price"],
    isOutOfStock: json["is_out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "product_id": productId,
    "version_id": versionId,
    "ver_short_desc": verShortDesc,
    "ver_capacity": verCapacity,
    "ver_unit": verUnit,
    "ver_price": verPrice,
    "offer_price": offerPrice,
    "is_out_of_stock": isOutOfStock,
  };
}

class ItemImage8 {
  ItemImage8({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImage8.fromJson(Map<String, dynamic> json) => ItemImage8(
    id: json["id"],
    storeId: json["store_id"],
    productId: json["product_id"],
    versionId: json["version_id"],
    verShortDesc: json["ver_short_desc"],
    verCapacity: json["ver_capacity"],
    verUnit: json["ver_unit"],
    verPrice: json["ver_price"],
    offerPrice: json["offer_price"],
    isOutOfStock: json["is_out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "product_id": productId,
    "version_id": versionId,
    "ver_short_desc": verShortDesc,
    "ver_capacity": verCapacity,
    "ver_unit": verUnit,
    "ver_price": verPrice,
    "offer_price": offerPrice,
    "is_out_of_stock": isOutOfStock,
  };
}

class ItemImage9 {
  ItemImage9({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImage9.fromJson(Map<String, dynamic> json) => ItemImage9(
    id: json["id"],
    storeId: json["store_id"],
    productId: json["product_id"],
    versionId: json["version_id"],
    verShortDesc: json["ver_short_desc"],
    verCapacity: json["ver_capacity"],
    verUnit: json["ver_unit"],
    verPrice: json["ver_price"],
    offerPrice: json["offer_price"],
    isOutOfStock: json["is_out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "product_id": productId,
    "version_id": versionId,
    "ver_short_desc": verShortDesc,
    "ver_capacity": verCapacity,
    "ver_unit": verUnit,
    "ver_price": verPrice,
    "offer_price": offerPrice,
    "is_out_of_stock": isOutOfStock,
  };
}


class ItemImage10 {
  ItemImage10({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImage10.fromJson(Map<String, dynamic> json) => ItemImage10(
    id: json["id"],
    storeId: json["store_id"],
    productId: json["product_id"],
    versionId: json["version_id"],
    verShortDesc: json["ver_short_desc"],
    verCapacity: json["ver_capacity"],
    verUnit: json["ver_unit"],
    verPrice: json["ver_price"],
    offerPrice: json["offer_price"],
    isOutOfStock: json["is_out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "product_id": productId,
    "version_id": versionId,
    "ver_short_desc": verShortDesc,
    "ver_capacity": verCapacity,
    "ver_unit": verUnit,
    "ver_price": verPrice,
    "offer_price": offerPrice,
    "is_out_of_stock": isOutOfStock,
  };
}

class ItemImageTwo {
  ItemImageTwo({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImageTwo.fromJson(Map<String, dynamic> json) => ItemImageTwo(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

class ItemImageBig {
  ItemImageBig({
    this.id,
    this.storeId,
    this.productId,
    this.versionId,
    this.verShortDesc,
    this.verCapacity,
    this.verUnit,
    this.verPrice,
    this.offerPrice,
    this.isOutOfStock,
  });

  String id;
  String storeId;
  String productId;
  String versionId;
  String verShortDesc;
  String verCapacity;
  String verUnit;
  String verPrice;
  String offerPrice;
  String isOutOfStock;

  factory ItemImageBig.fromJson(Map<String, dynamic> json) => ItemImageBig(
        id: json["id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        versionId: json["version_id"],
        verShortDesc: json["ver_short_desc"],
        verCapacity: json["ver_capacity"],
        verUnit: json["ver_unit"],
        verPrice: json["ver_price"],
        offerPrice: json["offer_price"],
        isOutOfStock: json["is_out_of_stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "product_id": productId,
        "version_id": versionId,
        "ver_short_desc": verShortDesc,
        "ver_capacity": verCapacity,
        "ver_unit": verUnit,
        "ver_price": verPrice,
        "offer_price": offerPrice,
        "is_out_of_stock": isOutOfStock,
      };
}

var masterCategory = new List<MasterCategory>();
var productModel = new List<Response>();
var productModelSec = new List<ResponseSec>();
var productModelImage = new List<ResponseImage>();

var productModelBannerImageOne = new List<ResponseBannerImageOne>();

var productModelBannerImagetwo = new List<ResponseBannerImageTwo>();

var productModelImageOne = new List<ResponseImageOne>();








var productModelImageSix = new List<ResponseImageSix>();

var productModelImage7 = new List<ResponseImage7>();
var productModelImage8 = new List<ResponseImage8>();
var productModelImage9 = new List<ResponseImage9>();
var productModelImage10 = new List<ResponseImage10>();

var productModelImageTwo = new List<ResponseImageTwo>();
var productModelImageBig = new List<ResponseImageBig>();
List<String> dataimage = [];
List<NetworkImage> bannerimg = [];

List<String> bannerimg_new = [];

List<String> bannerimgtwo_new = [];

List<NetworkImage> bannerimgtwo = [];
List<String> dataimageOne = [];


List<String> dataimageSix = [];


List<String> dataimage7 = [];

List<String> dataimage8 = [];
List<String> dataimage9 = [];
List<String> dataimage10 = [];
List<String> dataimageTwo = [];
List<String> dataimageBig = [];

var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

class _HomeState extends StateMVC<Home> {
  int _counter = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();



  String value = 'Home';
  String Name = "Name";
  String Address = "Address";

  void getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString('id');

    setState(() {
      Name = prefs.getString('name');
      Address = prefs.getString('address');
      _runapi();
    });
  }

  var baseUrls = "https://desiflea.com/admin/api/desifleaapi.php";
  var category = new List<Category>();

  addStringToSF(String cur_balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Wallet', cur_balance);

    setState(() {
      TotalWallet = prefs.getString('Wallet');
    });
  }

  _runapi() async {
    String objText =
        '{"cdblock": "wallet_totalprice", "cust_id": ' + UserID + '}';
    var url = baseUrls + "?req=" + objText;

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        List<Balance> tagObjs =
            rest.map((tagJson) => Balance.fromJson(tagJson)).toList();

        if (tagObjs[0].result == "No data get") {
        } else {
          addStringToSF(tagObjs[0].cur_balance);
          print("Check Null === wallet_totalprice Category URL responce 0 = " +
              rest.toString());
        }
      });
    });
  }

  // _getUsers() {
  //   API.getUsers().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       category = list.map((model) => Category.fromJson(model)).toList();
  //     });
  //   });
  // }

  String TotalWallet = "0";
  String UserID;

  String check;
  bool MasterSrim = false;
  String device_token ="";
  /// master category
  _runapis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    check = prefs.getString("checkpopup");

    prefs.setString("checkpopup", "1");
    String objText = '{"cdblock": "MasterCategory", "user_id": "' + UserID + '", "device_token":"'+device_token+'"}';
    var url = baseUrl + "?req=" + objText;
    print("LuckyYuYU  = "+url);


    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        masterCategory =
            rest.map((tagJson) => MasterCategory.fromJson(tagJson)).toList();
        MasterSrim = true;
        if(check == "0"){
          showDialog(
              context: context, builder: (context) => ExitConfirmationDialog()

          );
        }

      });
    });
  }

  _runapiSec() async {
    String objText = '{"cdblock": "HomeRandomProducts"}';
    var url = baseUrl + "?req=" + objText;

    // { "response": [{"result":"Success","id":"14","name":"Lucky","mobile":"8840149029","email":"abc@gmail.com","address":"dgg","city":"dh"}] }

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        final ProductModel users = productModelFromJson(response.body);
        productModel = users.response[0];

      });
    });
  }

  bool topsearch = false;
  /// top_search_products
  _runapitopsearch() async {
    String objText = '{"cdblock": "top_search_products"}';
    var url = baseUrl + "?req=" + objText;

    http.get(url).then((response) {
      setState(() {
        var values = response.body;


        var data = json.decode(response.body);
        var rest = data["response"] as List;

        topSearchResponse =
            rest.map((tagJson) => TopSearchResponse.fromJson(tagJson)).toList();
        topsearch = true;
      });
    });
  }
  bool DesiProSrim = false;
  /// DesiProducts
  _runapiDesiProducts() async {
    String objText = '{"cdblock": "DesiProducts"}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;




        desiProductsResponse = rest
            .map((tagJson) => DesiProductsResponse.fromJson(tagJson))
            .toList();
        DesiProSrim = true;

      });
    });
  }

  /// top_best_saler_products
  _runapibestsealls() async {
    String objText = '{"cdblock": "top_best_saler_products"}';
    var url = baseUrl + "?req=" + objText;

    http.get(url).then((response) {
      setState(() {
        var values = response.body;


        var data = json.decode(response.body);
        var rest = data["response"] as List;

        topBestSellsResponse = rest
            .map((tagJson) => TopBestSellsResponse.fromJson(tagJson))
            .toList();
      });
    });
  }

  /// HomeRandomProducts
  _runapithree() async {
    String objText = '{"cdblock": "HomeRandomProducts"}';
    var url = baseUrl + "?req=" + objText;

    http.get(url).then((response) {
      setState(() {
        var values = response.body;
        final ProductModelSec users = productModelFromJsons(response.body);
        productModelSec = users.response[0];


      });
    });
  }

  /// banner_new id =1
  _runapiImage() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "1" + '}';
    var url = baseUrl + "?req=" + objText;

    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        if (bannerimg.length > 0) {
          bannerimg.clear();
          bannerimg_new.clear();
          productModelBannerImageOne.clear();
        }
        productModelBannerImageOne = rest
            .map((tagJson) => ResponseBannerImageOne.fromJson(tagJson))
            .toList();

        for (int i = 0; i < productModelBannerImageOne.length; i++) {
          bannerimg_new.add("https://desiflea.com/admin/prod_pics/" +
              productModelBannerImageOne[i].image);
          BannerName = productModelBannerImageOne[i].name;

          bannerimg.add(NetworkImage("https://desiflea.com/admin/prod_pics/" +
              productModelBannerImageOne[i].image));
        }
        banenrvisit = true;
      });
    });
  }

  /// banner_new id =1
  _runapiImagetwo() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "2" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        if (bannerimgtwo_new.length > 0) {
          bannerimgtwo_new.clear();
          productModelBannerImagetwo.clear();
        }
        productModelBannerImagetwo = rest
            .map((tagJson) => ResponseBannerImageTwo.fromJson(tagJson))
            .toList();

        for (int i = 0; i < productModelBannerImagetwo.length; i++) {

          bannerimgtwo_new.add("https://desiflea.com/admin/prod_pics/" +
              productModelBannerImagetwo[i].image);
          // bannerimgtwo.add(NetworkImage("https://desiflea.com/admin/prod_pics/" + productModelBannerImagetwo[i].image));

        }

      });
    });
  }

  /// banner_new id =3
  _runapiImageSec() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "3" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;


        productModelImageOne =
            rest.map((tagJson) => ResponseImageOne.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImageOne.length; i++) {
          dataimageOne.add("https://desiflea.com/admin/prod_pics/" +
              productModelImageOne[i].image);

        }
      });
    });
  }



  /// banner_new id =6
  _runapiImageSec6() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "6" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("NewLuckyYUYURiSHI===  6  "+rest.toString());


        productModelImageSix =
            rest.map((tagJson) => ResponseImageSix.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImageSix.length; i++) {
          dataimageSix.add("https://desiflea.com/admin/prod_pics/" +
              productModelImageSix[i].image);

        }
      });
    });
  }


  /// banner_new id =6
  _runapiImageSec7() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "7" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("NewLuckyYUYURiSHI===  7  "+rest.toString());


        productModelImage7 =
            rest.map((tagJson) => ResponseImage7.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImage7.length; i++) {
          dataimage7.add("https://desiflea.com/admin/prod_pics/" +
              productModelImage7[i].image);

        }
      });
    });
  }


  _runapiImageSec8() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "8" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("NewLuckyYUYURiSHI===  8  "+rest.toString());


        productModelImage8 =
            rest.map((tagJson) => ResponseImage8.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImage8.length; i++) {
          dataimage8.add("https://desiflea.com/admin/prod_pics/" +
              productModelImage8[i].image);

        }
      });
    });
  }

  _runapiImageSec9() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "9" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("NewLuckyYUYURiSHI===  9  "+rest.toString());


        productModelImage9 =
            rest.map((tagJson) => ResponseImage9.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImage9.length; i++) {
          dataimage9.add("https://desiflea.com/admin/prod_pics/" +
              productModelImage9[i].image);

        }
      });
    });
  }


  _runapiImageSec10() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "10" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;

        print("NewLuckyYUYURiSHI===  10  "+rest.toString());


        productModelImage10 =
            rest.map((tagJson) => ResponseImage10.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImage10.length; i++) {
          dataimage10.add("https://desiflea.com/admin/prod_pics/" +
              productModelImage10[i].image);

        }
      });
    });
  }

  /// banner_new id =4
  _runapiImageTwo() async {
    String objText = '{"cdblock": "banner_new", "id": ' + '"4"' + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;


        productModelImageTwo =
            rest.map((tagJson) => ResponseImageTwo.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImageTwo.length; i++) {
          dataimageTwo.add("https://desiflea.com/admin/prod_pics/" +
              productModelImageTwo[i].image);

        }
      });
    });
  }

  /// banner_new id =5
  _runapiImageBig() async {
    String objText = '{"cdblock": "banner_new", "id": ' + "5" + '}';
    var url = baseUrl + "?req=" + objText;


    http.get(url).then((response) {
      setState(() {
        var values = response.body;

        var data = json.decode(response.body);
        var rest = data["response"] as List;


        productModelImageBig =
            rest.map((tagJson) => ResponseImageBig.fromJson(tagJson)).toList();

        for (int i = 0; i < productModelImageBig.length; i++) {
          dataimageBig.add("https://desiflea.com/admin/prod_pics/" +
              productModelImageBig[i].image);

        }
      });
    });
  }

  String Popup;
  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    print('Lucky New on message body = '+body);
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();

              await
              Toast.show("Notification Clicked 2 ", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            },
          ),
        ],
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    print('Lucky New on message payload = '+payload+ 'Typetwo='+Typetwo);
    if (payload != null) {
      debugPrint('Lucky New notification payload: ' + payload);
    }
    if(Typetwo == "order"){

    }else if(Typetwo == "Wallet"){

    }
    await
    Toast.show("Notification Clicked 1"+payload, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    // await Fluttertoast.showToast(
    //     msg: "Notification Clicked",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIos: 1,
    //     backgroundColor: Colors.black54,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
    /*Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );*/
  }
  Future displayNotification(Map<String, dynamic> message) async{
    print('Lucky New on message 1 ${message}');
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'hello',);
    Typetwo = message['notification']['type'];

  }
  String Typetwo = "Login";


  bool check_cart = true;
  String countcartitems = "0";

  /// database
  final dbhandler = DbStudentMamager.instance;
  var rowall;
  void firstqueryall() async {
    rowall = await dbhandler.firstqueryall();

    print("Rishi Sir Lucky and YUYU = " + rowall.length.toString());
    if (rowall.length.toString() == "0") {
      setState(() {
        check_cart = true;
        countcartitems = "0";
        print("Rishi Sir Lucky and YUYU = 1" );
      });
    } else {
      setState(() {
        countcartitems = rowall.length.toString();
        print("Rishi Sir Lucky and YUYU = 2" );
        check_cart = false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    firstqueryall();


    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);

    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('Lucky New on message 2 ${message}');
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
        displayNotification(message);
        // _showItemDialog(message);
      },
      onResume: (Map<String, dynamic> message) {
        print('Lucky New on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('Lucky New on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Lucky New Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      device_token = token;
      print("Lucky New "+token);
      print("Lucky New device_token =  "+device_token);
      _runapis();
    });



    // _getUsers();
    getUserID();



    _runapiSec();

    _runapithree();

    // _runapiImage();

    _runapiImageSec();

    _runapiImageTwo();

    _runapiImageBig();

    _runapitopsearch();

    _runapibestsealls();


    /// first bannerExitConfirmationDialog
    _runapiImage();


    /// two banner
    _runapiImagetwo();

    // DialogHelper.exit(context);

    /// DesiProducts
       _runapiDesiProducts();





    _runapiImageSec6();

    _runapiImageSec7();



    _runapiImageSec8();

    _runapiImageSec9();

    _runapiImageSec10();

  }

  Column _buildItemsForListView(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Card(
          // color: Color(0xff10F2F7F9),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemsPage(
                            categoryID: masterCategory[index].id,
                            categoryName: masterCategory[index].name,
                            WalletPrice: TotalWallet,
                            tabindex: 0,
                          )));
            },
            child: Container(
                height: 140,
                width: 100,
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.05),
                          offset: Offset(0, 5),
                          blurRadius: 5)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 80,
                        child: Image.network(
                          masterCategory[index].img,
                          width: 90,
                          height: double.infinity,
                        )),
                    Expanded(
                        flex:20,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            masterCategory[index].name.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 8, color: Colors.black),
                          ),
                        )),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  int _current = 0;
  String BannerName = "";
  bool banenrvisit = false;


  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                  exit(0);
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 270;
    final double itemWidth = size.width / 2;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: ImageIcon(
                          AssetImage('images/icons/wallet.png'),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletHistoryActivity()),
                          );
                        }

//                getData,
                        ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletHistoryActivity()),
                        );
                      },
                      child: Text(
                        TotalWallet.length == 0 ? "₹ 0" : "₹ " + TotalWallet,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    check_cart
                        ? new IconButton(
                        icon: ImageIcon(
                          AssetImage('images/icons/ic_cart blk.png'),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCart()),
                          );
                        })
                        : new Stack(
                      children: [
                        IconButton(
                            icon: ImageIcon(
                              AssetImage('images/icons/ic_cart blk.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewCart()),
                              );
                            }),
                        Positioned(
                            left: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[500]),
                              child: Text(
                                countcartitems,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.0),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(3.0),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchProductPage()));
                        },
                        child: Container(
                          height: 50,
                          color: Color(0xffF8F9FD),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 15,
                                  child: Image.asset(
                                    "images/icons/ic_search.png",
                                    height: 15,
                                    width: 15,
                                  )),
                              Expanded(
                                  flex: 85,
                                  child: Text(
                                    "Search ",
                                    style: TextStyle(fontSize: 15),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                        alignment: Alignment.topLeft,
                        child: banenrvisit
                            ? new Text(
                                "",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            : new Shimmer.fromColors(
                                child: SizedBox(
                                  height: 20,
                                  width: 60,
                                ),
                                baseColor: Colors.red,
                                highlightColor: Colors.yellow)


                    ),

                    SizedBox(
                      height: 150.0,
                      width: double.infinity,
                      child: banenrvisit
                          ? new CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                height: 150,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                              ),
                              items: bannerimg_new.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(color: Colors.grey[300]),
                                        child: GestureDetector(child: Image.network(i, fit: BoxFit.fill),
                                            onTap: () {
                                              for (int z = 0; z < bannerimg_new.length; z++) {
                                                if (bannerimg_new[z] == i.toString()) {
                                                  if (bannerimg_new.length > z) {


                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailsPage(
                                                                  P_Id: productModelBannerImageOne[
                                                                          z]
                                                                      .productId,
                                                                  P_name:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .name,
                                                                  P_description:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .description,
                                                                  P_image1:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .image1,
                                                                  P_verShortDesc:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .items[
                                                                              0]
                                                                          .verShortDesc,
                                                                  P_verCapacity:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .items[
                                                                              0]
                                                                          .verCapacity,
                                                                  P_verUnit:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .items[
                                                                              0]
                                                                          .verUnit,
                                                                  P_verPrice:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .items[
                                                                              0]
                                                                          .verPrice,
                                                                  P_offerPrice:
                                                                      productModelBannerImageOne[
                                                                              z]
                                                                          .items[
                                                                              0]
                                                                          .offerPrice,
                                                                  walletprice:
                                                                      TotalWallet,
                                                                )));
                                                  }
                                                }
                                              }
                                            }));
                                  },
                                );
                              }).toList(),
                            )
                          : new Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: 140,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),

                                ),
                                Expanded(
                                  flex: 80,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: 140,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),

                                ),
                                Expanded(
                                  flex: 10,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: 140,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),

                                ),
                              ],
                            ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 24.0,bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Text(
                                "You order,",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "We deliver",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Container(
                          //       margin:
                          //           const EdgeInsets.fromLTRB(10, 15, 0, 10),
                          //       child: Text(
                          //         "Categories",
                          //         maxLines: 1,
                          //         softWrap: false,
                          //         overflow: TextOverflow.fade,
                          //         style: Theme.of(context).textTheme.headline4,
                          //         // style: TextStyle(
                          //         //     color: Color(0xff000000),
                          //         //     fontSize: 15,
                          //         //     fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 5.0,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),





                    //////////////////////////////////
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 33,
                            child: InkWell(
                              onTap: () {
                                if(productModelImageSix[0].btype == "NA"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
                                                P_Id: productModelImageSix[0]
                                                    .productId,
                                                P_name:
                                                productModelImageSix[0].name,
                                                P_description:
                                                productModelImageSix[0]
                                                    .description,
                                                P_image1: productModelImageSix[0]
                                                    .image1,
                                                P_verShortDesc:
                                                productModelImageSix[0]
                                                    .items[0]
                                                    .verShortDesc,
                                                P_verCapacity:
                                                productModelImageSix[0]
                                                    .items[0]
                                                    .verCapacity,
                                                P_verUnit: productModelImageSix[0]
                                                    .items[0]
                                                    .verUnit,
                                                P_verPrice:
                                                productModelImageSix[0]
                                                    .items[0]
                                                    .verPrice,
                                                P_offerPrice:
                                                productModelImageSix[0]
                                                    .items[0]
                                                    .offerPrice,
                                                walletprice: TotalWallet,
                                              )));
                                }else {
                                  int indexnew = 0;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ItemsPage(
                                            categoryID: productModelImageSix[0].category_id,
                                            categoryName: productModelImageSix[0].cat_name,
                                            WalletPrice: TotalWallet,
                                            tabindex: int.parse(productModelImageSix[0].index),
                                          )));
                                }

                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                width: double.infinity,
                                height: 130.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: dataimageSix.length == 0
                                          ? NetworkImage(
                                          'https://picsum.photos/250?image=9')
                                          : NetworkImage(dataimageSix[0])),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 33,
                            child: InkWell(
                              onTap: () {

                                if(productModelImage7[0].btype == "NA"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
                                                P_Id: productModelImage7[0]
                                                    .productId,
                                                P_name:
                                                productModelImage7[0].name,
                                                P_description:
                                                productModelImage7[0]
                                                    .description,
                                                P_image1: productModelImage7[0]
                                                    .image1,
                                                P_verShortDesc:
                                                productModelImage7[0]
                                                    .items[0]
                                                    .verShortDesc,
                                                P_verCapacity:
                                                productModelImage7[0]
                                                    .items[0]
                                                    .verCapacity,
                                                P_verUnit: productModelImage7[0]
                                                    .items[0]
                                                    .verUnit,
                                                P_verPrice:
                                                productModelImage7[0]
                                                    .items[0]
                                                    .verPrice,
                                                P_offerPrice:
                                                productModelImage7[0]
                                                    .items[0]
                                                    .offerPrice,
                                                walletprice: TotalWallet,
                                              )));
                                }else {
                                  int indexnew = 0;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ItemsPage(
                                            categoryID: productModelImage7[0].category_id,
                                            categoryName: productModelImage7[0].cat_name,
                                            WalletPrice: TotalWallet,
                                            tabindex: int.parse(productModelImage7[0].index),
                                          )));
                                }





                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 4, 0),
                                width: double.infinity,
                                height: 130.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: dataimage7.length == 0
                                          ? NetworkImage(
                                          'https://picsum.photos/250?image=9')
                                          : NetworkImage(dataimage7[0])),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 33,
                            child: InkWell(
                              onTap: () {

                                int indexnew = 0;






                                print("NewLuckyYUYURiSHI=== id ====    "+productModelImage8[0].category_id);
                                print("NewLuckyYUYURiSHI=== subid ====    "+productModelImage8[0].sub_category_id);

                                if(productModelImage8[0].btype == "NA"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
                                                P_Id: productModelImage8[0]
                                                    .productId,
                                                P_name:
                                                productModelImage8[0].name,
                                                P_description:
                                                productModelImage8[0]
                                                    .description,
                                                P_image1: productModelImage8[0]
                                                    .image1,
                                                P_verShortDesc:
                                                productModelImage8[0]
                                                    .items[0]
                                                    .verShortDesc,
                                                P_verCapacity:
                                                productModelImage8[0]
                                                    .items[0]
                                                    .verCapacity,
                                                P_verUnit: productModelImage8[0]
                                                    .items[0]
                                                    .verUnit,
                                                P_verPrice:
                                                productModelImage8[0]
                                                    .items[0]
                                                    .verPrice,
                                                P_offerPrice:
                                                productModelImage8[0]
                                                    .items[0]
                                                    .offerPrice,
                                                walletprice: TotalWallet,
                                              )));
                                }else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ItemsPage(
                                            categoryID: productModelImage8[0].category_id,
                                            categoryName: productModelImage8[0].cat_name,
                                            WalletPrice: TotalWallet,
                                            tabindex: int.parse(productModelImage8[0].index),
                                          )));

                                }




                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: double.infinity,
                                height: 130.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: dataimage8.length == 0
                                          ? NetworkImage(
                                          'https://picsum.photos/250?image=9')
                                          : NetworkImage(dataimage8[0])),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Row(children: [
                        Expanded(
                          flex: 67,
                          child: InkWell(
                            onTap: () {

                              if(productModelImage10[0].btype == "NA"){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailsPage(
                                          P_Id: productModelImage10[0].productId,
                                          P_name: productModelImage10[0].name,
                                          P_description:
                                          productModelImage10[0].description,
                                          P_image1:
                                          productModelImage10[0].image1,
                                          P_verShortDesc: productModelImage10[0]
                                              .items[0]
                                              .verShortDesc,
                                          P_verCapacity: productModelImage10[0]
                                              .items[0]
                                              .verCapacity,
                                          P_verUnit: productModelImage10[0]
                                              .items[0]
                                              .verUnit,
                                          P_verPrice: productModelImage10[0]
                                              .items[0]
                                              .verPrice,
                                          P_offerPrice: productModelImage10[0]
                                              .items[0]
                                              .offerPrice,
                                          walletprice: TotalWallet,
                                        )));
                              }else {
                                int indexnew = 0;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemsPage(
                                          categoryID: productModelImage10[0].category_id,
                                          categoryName: productModelImage10[0].cat_name,
                                          WalletPrice: TotalWallet,
                                          tabindex: int.parse(productModelImage10[0].index),
                                        )));
                              }




                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: double.infinity,
                              height: 270.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: dataimage10.length == 0
                                        ? NetworkImage(
                                        'https://picsum.photos/250?image=9')
                                        : NetworkImage(dataimage10[0])),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 33,
                          child: InkWell(
                            onTap: () {

                              if(productModelImage9[0].btype == "NA"){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              P_Id: productModelImage9[0]
                                                  .productId,
                                              P_name:
                                              productModelImage9[0].name,
                                              P_description:
                                              productModelImage9[0]
                                                  .description,
                                              P_image1: productModelImage9[0]
                                                  .image1,
                                              P_verShortDesc:
                                              productModelImage9[0]
                                                  .items[0]
                                                  .verShortDesc,
                                              P_verCapacity:
                                              productModelImage9[0]
                                                  .items[0]
                                                  .verCapacity,
                                              P_verUnit: productModelImage9[0]
                                                  .items[0]
                                                  .verUnit,
                                              P_verPrice:
                                              productModelImage9[0]
                                                  .items[0]
                                                  .verPrice,
                                              P_offerPrice:
                                              productModelImage9[0]
                                                  .items[0]
                                                  .offerPrice,
                                              walletprice: TotalWallet,
                                            )));
                              }else {
                                int indexnew = 0;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemsPage(
                                          categoryID: productModelImage9[0].category_id,
                                          categoryName: productModelImage9[0].cat_name,
                                          WalletPrice: TotalWallet,
                                          tabindex: int.parse(productModelImage9[0].index),
                                        )));
                              }






                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              width: double.infinity,
                              height: 270.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: dataimage9.length == 0
                                        ? NetworkImage(
                                        'https://picsum.photos/250?image=9')
                                        : NetworkImage(dataimage9[0])),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],),
                    ),


                    /////////////////

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 5),
                      child: Text(
                        "Categories",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),


                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 1, 10),
                      height: 160,
                      alignment: Alignment.topLeft,
                      child: MasterSrim
                        ? new






                      Stack(
                        children: <Widget>[
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(top: 1),
                              itemCount: masterCategory.length,
                              itemBuilder: _buildItemsForListView),
                        ],
                      )
                      : new Row(children: [

                        Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),

                        Card(child: Container(
                            height: 140,
                            width: 100,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).focusColor.withOpacity(0.05),
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 82,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),
                                ),
                                Expanded(
                                    flex: 18,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )),
                              ],
                            )),),

                        Card(child: Container(
                            height: 140,
                            width: 100,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).focusColor.withOpacity(0.05),
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 82,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),
                                ),
                                Expanded(
                                    flex: 18,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )),
                              ],
                            )),),


                      ],),
                    ),



                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 5),
                      child: Text(
                        "Fruits and Vegetables",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 1, 10),
                      height: 160,
                      alignment: Alignment.topLeft,
                      child: MasterSrim
                          ? new






                      Stack(
                        children: <Widget>[
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(top: 1),
                              itemCount: masterCategory.length,
                              itemBuilder: _buildItemsForListView),
                        ],
                      )
                          : new Row(children: [

                        Card(child: Container(
                            height: 140,
                            width: 100,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).focusColor.withOpacity(0.05),
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 82,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),
                                ),
                                Expanded(
                                    flex: 18,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )),
                              ],
                            )),),

                        Card(child: Container(
                            height: 140,
                            width: 100,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).focusColor.withOpacity(0.05),
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 82,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),
                                ),
                                Expanded(
                                    flex: 18,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )),
                              ],
                            )),),

                        Card(child: Container(
                            height: 140,
                            width: 100,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).focusColor.withOpacity(0.05),
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 82,
                                  child: Shimmer.fromColors(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white),
                                ),
                                Expanded(
                                    flex: 18,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )),
                              ],
                            )),),


                      ],),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 5),
                      child: Text(
                        "Desi Products",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: MasterSrim
                          ? new GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            desiProductsResponse.length, (index) {
                          return new InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.08),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              P_Id: desiProductsResponse[index]
                                                  .product_id,
                                              P_name:
                                                  desiProductsResponse[index]
                                                      .name,
                                              P_description:
                                                  desiProductsResponse[index]
                                                      .description,
                                              P_image1:
                                                      desiProductsResponse[
                                                              index]
                                                          .image1,
                                              P_verShortDesc:
                                                  desiProductsResponse[index].items[0]
                                                      .ver_short_desc,
                                              P_verCapacity:
                                                  desiProductsResponse[index].items[0]
                                                      .ver_capacity,
                                              P_verUnit:
                                                  desiProductsResponse[index].items[0]
                                                      .ver_unit,
                                              P_verPrice:
                                                  desiProductsResponse[index].items[0]
                                                      .ver_price,
                                              P_offerPrice:
                                                  desiProductsResponse[index].items[0]
                                                      .offer_price,
                                              walletprice: TotalWallet,
                                            )));
                              },
                              child: Card(
                                child: Container(
                                    height: 140,

                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.05),
                                              offset: Offset(0, 5),
                                              blurRadius: 5)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 80,
                                            child: Image.network(

                                                  desiProductsResponse[index]
                                                      .image1,
                                              width: 100,
                                              height: double.infinity,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            flex: 20,
                                            child: Text(
                                              desiProductsResponse[index]
                                                  .name
                                                  .toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black),
                                            )),
                                      ],
                                    )),
                              ));
                        }),
                      ) :
                      new Column(children: [
                        Row(children: [
                          Expanded(
                          flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),

                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),





                        ],),
                        Row(children: [
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),

                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),





                        ],),
                      ],),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 5),
                      child: Text(
                        "Top Searched",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: topsearch
                          ? new GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                        childAspectRatio: (itemWidth / itemHeight),
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            topSearchResponse.length, (index) {
                          return new InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.08),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              P_Id: topSearchResponse[index]
                                                  .product_id,
                                              P_name:
                                                  topSearchResponse[index].name,
                                              P_description:
                                                  topSearchResponse[index]
                                                      .description,
                                              P_image1:
                                                  "https://desiflea.com/admin/prod_pics/" +
                                                      topSearchResponse[index]
                                                          .image1,
                                              P_verShortDesc:
                                                  topSearchResponse[index]
                                                      .ver_short_desc,
                                              P_verCapacity:
                                                  topSearchResponse[index]
                                                      .ver_capacity,
                                              P_verUnit:
                                                  topSearchResponse[index]
                                                      .ver_unit,
                                              P_verPrice:
                                                  topSearchResponse[index]
                                                      .ver_price,
                                              P_offerPrice:
                                                  topSearchResponse[index]
                                                      .offer_price,
                                              walletprice: TotalWallet,
                                            )));
                              },
                              child: Card(
                                child: Container(
                                    height: 140,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.05),
                                              offset: Offset(0, 5),
                                              blurRadius: 5)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 80,
                                            child: Image.network(
                                              "https://desiflea.com/admin/prod_pics/" +
                                                  topSearchResponse[index]
                                                      .image1,
                                              width: 100,
                                              height: double.infinity,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            flex: 20,
                                            child: Text(
                                              topSearchResponse[index]
                                                  .name
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black),
                                            )),
                                      ],
                                    )),
                              ));
                        }),
                      ) :
                      new Column(children: [
                        Row(children: [
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),

                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),





                        ],),
                        Row(children: [
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),
                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),

                          Expanded(
                            flex: 33,
                            child: Card(child: Container(
                                height: 140,
                                width: 100,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).focusColor.withOpacity(0.05),
                                          offset: Offset(0, 5),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 82,
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    ),
                                    Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Shimmer.fromColors(
                                              child: Container(
                                                height: 20,
                                                width: 80,
                                                color: Colors.grey,
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                              ),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white),
                                        )),
                                  ],
                                )),),
                          ),





                        ],),
                      ],),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: SizedBox(
                        height: 100.0,
                        width: double.infinity,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            height: 100,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                          ),
                          items: bannerimgtwo_new.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: GestureDetector(
                                        child:
                                            Image.network(i, fit: BoxFit.fill),
                                        onTap: () {
                                          for (int z = 0;
                                              z < bannerimgtwo_new.length;
                                              z++) {
                                            if (bannerimgtwo_new[z] ==
                                                i.toString()) {
                                              if (bannerimgtwo_new.length > z) {

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsPage(
                                                              P_Id:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .productId,
                                                              P_name:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .name,
                                                              P_description:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .description,
                                                              P_image1:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .image1,
                                                              P_verShortDesc:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .items[0]
                                                                      .verShortDesc,
                                                              P_verCapacity:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .items[0]
                                                                      .verCapacity,
                                                              P_verUnit:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .items[0]
                                                                      .verUnit,
                                                              P_verPrice:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .items[0]
                                                                      .verPrice,
                                                              P_offerPrice:
                                                                  productModelBannerImagetwo[
                                                                          z]
                                                                      .items[0]
                                                                      .offerPrice,
                                                              walletprice:
                                                                  TotalWallet,
                                                            )));
                                              }
                                            }
                                          }
                                        }));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // SizedBox(
                    //     height: 150.0,
                    //     width: double.infinity,
                    //     child: Carousel(
                    //       // onImageTap: ,
                    //       images: bannerimgtwo_new,
                    //       dotSize: 4.0,
                    //       dotSpacing: 15.0,
                    //       dotColor: Colors.lightGreenAccent,
                    //       indicatorBgPadding: 5.0,
                    //       dotBgColor: Colors.purple.withOpacity(0.5),
                    //       borderRadius: false,
                    //     )
                    // ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 10),
                      child: Text(
                        "Best Seller",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                        childAspectRatio: (itemWidth / itemHeight),
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            topBestSellsResponse.length, (index) {
                          return new InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.08),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              P_Id: topBestSellsResponse[index]
                                                  .product_id,
                                              P_name:
                                                  topBestSellsResponse[index]
                                                      .name,
                                              P_description:
                                                  topBestSellsResponse[index]
                                                      .description,
                                              P_image1:
                                                  topBestSellsResponse[index]
                                                      .image1,
                                              P_verShortDesc:
                                                  topBestSellsResponse[index]
                                                      .ver_short_desc,
                                              P_verCapacity:
                                                  topBestSellsResponse[index]
                                                      .ver_capacity,
                                              P_verUnit:
                                                  topBestSellsResponse[index]
                                                      .ver_unit,
                                              P_verPrice:
                                                  topBestSellsResponse[index]
                                                      .ver_price,
                                              P_offerPrice:
                                                  topBestSellsResponse[index]
                                                      .offer_price,
                                              walletprice: TotalWallet,
                                            )));
                              },
                              child: Card(
                                child: Container(
                                    height: 140,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.05),
                                              offset: Offset(0, 5),
                                              blurRadius: 5)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 80,
                                            child: Image.network(
                                              topBestSellsResponse[index]
                                                  .image1,
                                              width: 100,
                                              height: double.infinity,
                                            )),
                                        Expanded(
                                            flex: 20,
                                            child: Text(
                                              topBestSellsResponse[index].name,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black),
                                            )),
                                      ],
                                    )),
                              ));
                        }),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(24.0, 8, 0, 10),
                      child: Text(
                        "",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              P_Id: productModelImageOne[0]
                                                  .productId,
                                              P_name:
                                                  productModelImageOne[0].name,
                                              P_description:
                                                  productModelImageOne[0]
                                                      .description,
                                              P_image1: productModelImageOne[0]
                                                  .image1,
                                              P_verShortDesc:
                                                  productModelImageOne[0]
                                                      .items[0]
                                                      .verShortDesc,
                                              P_verCapacity:
                                                  productModelImageOne[0]
                                                      .items[0]
                                                      .verCapacity,
                                              P_verUnit: productModelImageOne[0]
                                                  .items[0]
                                                  .verUnit,
                                              P_verPrice:
                                                  productModelImageOne[0]
                                                      .items[0]
                                                      .verPrice,
                                              P_offerPrice:
                                                  productModelImageOne[0]
                                                      .items[0]
                                                      .offerPrice,
                                              walletprice: TotalWallet,
                                            )));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                width: double.infinity,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: dataimageOne.length == 0
                                          ? NetworkImage(
                                              'https://picsum.photos/250?image=9')
                                          : NetworkImage(dataimageOne[0])),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              P_Id: productModelImageTwo[0]
                                                  .productId,
                                              P_name:
                                                  productModelImageTwo[0].name,
                                              P_description:
                                                  productModelImageTwo[0]
                                                      .description,
                                              P_image1: productModelImageTwo[0]
                                                  .image1,
                                              P_verShortDesc:
                                                  productModelImageTwo[0]
                                                      .items[0]
                                                      .verShortDesc,
                                              P_verCapacity:
                                                  productModelImageTwo[0]
                                                      .items[0]
                                                      .verCapacity,
                                              P_verUnit: productModelImageTwo[0]
                                                  .items[0]
                                                  .verUnit,
                                              P_verPrice:
                                                  productModelImageTwo[0]
                                                      .items[0]
                                                      .verPrice,
                                              P_offerPrice:
                                                  productModelImageTwo[0]
                                                      .items[0]
                                                      .offerPrice,
                                              walletprice: TotalWallet,
                                            )));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                width: double.infinity,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: dataimageTwo.length == 0
                                          ? NetworkImage(
                                              'https://picsum.photos/250?image=9')
                                          : NetworkImage(dataimageTwo[0])),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                        P_Id: productModelImageBig[0].productId,
                                        P_name: productModelImageBig[0].name,
                                        P_description:
                                            productModelImageBig[0].description,
                                        P_image1:
                                            productModelImageBig[0].image1,
                                        P_verShortDesc: productModelImageBig[0]
                                            .items[0]
                                            .verShortDesc,
                                        P_verCapacity: productModelImageBig[0]
                                            .items[0]
                                            .verCapacity,
                                        P_verUnit: productModelImageBig[0]
                                            .items[0]
                                            .verUnit,
                                        P_verPrice: productModelImageBig[0]
                                            .items[0]
                                            .verPrice,
                                        P_offerPrice: productModelImageBig[0]
                                            .items[0]
                                            .offerPrice,
                                        walletprice: TotalWallet,
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          height: 180.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: dataimageBig.length == 0
                                    ? NetworkImage(
                                        'https://picsum.photos/250?image=9')
                                    : NetworkImage(dataimageBig[0])),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("images/logos/applogo.png"),
                  ),
                  accountName: Text(Name),
                  accountEmail: Container(
                      child: Text(
                    Address,
                    maxLines: 2,
                    style: TextStyle(fontSize: 11),
                  )),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_basket),
                  title: Text("Order"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text("Wallet"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WalletHistoryActivity()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text("Issue with order"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RaiseRequestActivity()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text("Referrals"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReferPageActivity()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delivery_dining),
                  title: Text("Delivery slot"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeliverySlot()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text("Contact Us"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsActivity()),
                    );
                  },
                ),
              ],
            ),
          ),
        ));

    ;
  }

  Expanded buildGrid() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: new List<Widget>.generate(productModel.length, (index) {
            return new InkWell(
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context).accentColor.withOpacity(0.08),
                onTap: () {},
                child: Card(
                  color: Color(0xffF2F7F9),
                  child: Container(
                      height: 90,
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.05),
                                offset: Offset(0, 5),
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 7,
                              child: Image.network(
                                productModel[index].image1,
                                height: 70,
                                width: 70,
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                productModel[index].name,
                                style: TextStyle(
                                    fontSize: 11, color: Colors.black),
                              )),
                        ],
                      )),
                ));
          }),
        ),
      ),
    );
  }

  Expanded buildGridSec() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: new List<Widget>.generate(productModelSec.length, (index) {
            return new InkWell(
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context).accentColor.withOpacity(0.08),
                onTap: () {},
                child: Card(
                  color: Color(0xffF2F7F9),
                  child: Container(
                      height: 90,
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.05),
                                offset: Offset(0, 5),
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 7,
                              child: Image.network(
                                productModelSec[index].image1,
                                height: 70,
                                width: 70,
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                productModelSec[index].name,
                                style: TextStyle(
                                    fontSize: 11, color: Colors.black),
                              )),
                        ],
                      )),
                ));
          }),
        ),
      ),
    );
  }
}
