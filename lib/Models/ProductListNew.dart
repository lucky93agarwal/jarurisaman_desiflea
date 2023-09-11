
import 'package:delivoo/Models/ItemLIst.dart';
class ProductListNew {
  String productid;
  String name;
  String descritpion;
  String image;
  int numberofitems =0;
  List<ItemList> itemList;



  ProductListNew(this.productid, this.name, this.descritpion, this.image, [this.itemList]);

  factory ProductListNew.fromJson(dynamic json) {
      var tagObjsJson = json['items'] as List;
      List<ItemList> _tags = tagObjsJson.map((tagJson) => ItemList.fromJson(tagJson)).toList();

      return ProductListNew(
          json['product_id'] as String,
          json['name'] as String,
          json['description'] as String,
          json['image1'] as String,
          _tags
      );

  }

  @override
  String toString() {
    return '{ ${this.productid}, ${this.name}, ${this.descritpion}, ${this.image}, ${this.itemList} }';
  }
}