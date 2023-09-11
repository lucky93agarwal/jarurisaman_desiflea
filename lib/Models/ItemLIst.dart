class ItemList {
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



//
//  String id;
//  String name;
//  String unit;
//
//  String price;
//  String offerprice;
//  String opstock;
//
//  String storeid;

  ItemList(String id, String store_id, String product_id, String version_id, String ver_short_desc,
      String ver_capacity, String ver_unit, String ver_price, String offer_price, String is_out_of_stock) {
    this.id = id;
    this.store_id = store_id;
    this.product_id = product_id;

    this.version_id = version_id;
    this.ver_short_desc = ver_short_desc;
    this.ver_capacity = ver_capacity;
    this.ver_unit = ver_unit;
    this.ver_price = ver_price;
    this.offer_price = offer_price;
    this.is_out_of_stock = is_out_of_stock;
  }

  ItemList.fromJson(Map json)
      : id = json['id'],
        store_id = json['store_id'],
        product_id = json['product_id'],
        version_id = json['version_id'],
        ver_short_desc = json['ver_short_desc'],
        ver_capacity = json['ver_capacity'],
        ver_unit = json['ver_unit']

  ,
        ver_price = json['ver_price'],
        offer_price = json['offer_price'],
        is_out_of_stock = json['is_out_of_stock'];

  Map toJson() {
    return {
      'id': id,
      'store_id': store_id,
      'product_id': product_id,
      'version_id': version_id,
      'ver_short_desc': ver_short_desc,
      'ver_capacity': ver_capacity,
      'ver_unit': ver_unit,
      'ver_price': ver_price,
      'offer_price': offer_price,
      'is_out_of_stock': is_out_of_stock
    };
  }
}
