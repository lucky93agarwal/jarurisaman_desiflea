class Qty {
  String id;
  String name;
  String unit;

  String price;
  String offerprice;
  String opstock;

  String storeid;

  Qty(String id, String name, String unit, String price, String offerprice,
      String opstock, String storeid) {
    this.id = id;
    this.name = name;
    this.unit = unit;

    this.price = price;
    this.offerprice = offerprice;
    this.opstock = opstock;
    this.storeid = storeid;
  }

  Qty.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        unit = json['unit'],
        price = json['price'],
        offerprice = json['offer_price'],
        opstock = json['op_stock'],
        storeid = json['store_id'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'price': price,
      'offer_price': offerprice,
      'op_stock': opstock,
      'store_id': storeid
    };
  }
}
