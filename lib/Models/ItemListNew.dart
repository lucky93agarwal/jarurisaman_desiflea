class ItemListNew{
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



  ItemListNew(this.id, this.store_id, this.product_id, this.version_id, this.ver_short_desc, this.ver_capacity, this.ver_unit, this.ver_price, this.offer_price, this.is_out_of_stock);

  factory ItemListNew.fromJson(dynamic json) {
    return ItemListNew(json['id'] as String, json['store_id'] as String, json['product_id'] as String, json['version_id'] as String, json['ver_short_desc'] as String, json['ver_capacity'] as String
        , json['ver_unit'] as String, json['ver_price'] as String, json['offer_price'] as String, json['is_out_of_stock'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.store_id}, ${this.product_id}, ${this.version_id}, ${this.ver_short_desc}, ${this.ver_capacity}, ${this.ver_unit}, ${this.ver_price}, ${this.offer_price}, ${this.is_out_of_stock} }';
  }
}