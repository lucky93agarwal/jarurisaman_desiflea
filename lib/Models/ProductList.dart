import 'package:delivoo/Models/ItemLIst.dart';
class ProductList {
  String productid;
  String name;
  String descritpion;
  String image;
  int numberofitems = 0;





  ProductList(String productid, String name, String descritpion, String image, int numberofitems) {
    this.productid = productid;
    this.name = name;
    this.descritpion = descritpion;

    this.image = image;

    this.numberofitems = numberofitems;


  }





  ProductList.fromJson(Map json)
      : productid = json['product_id'],
        name = json['name'],
        descritpion = json['description'],
        image = json['image1'];






  Map toJson() {
    return {'product_id': productid, 'item_id': name, 'product_name': descritpion, 'item_name': image, 'numberofitems':numberofitems};
  }
}
