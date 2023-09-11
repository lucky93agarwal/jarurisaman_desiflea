class ItemListinCart {
  String colId;
  final String userid;
  final String productid;
  final String productname;
  final String productimg;
  final String qty;
  final String price;
  final String itemtype;
  final String totalprice;
  final String productqty;
  int numberofitems = 0;

  String get myValue => colId;

  set myValue(String value) {
    colId = value;
  }

  ItemListinCart(
      this.colId,
      this.userid,
      this.productid,
      this.productname,
      this.productimg,
      this.qty,
      this.price,
      this.itemtype,
      this.totalprice,
      this.productqty,
      this.numberofitems);

  ItemListinCart.fromJson(Map<String, dynamic> json)
      : colId = json['id'],
        userid = json['userid'],
        productid = json['productid'],
        productname = json['productname'],
        productimg = json['productimg'],
        qty = json['qty'],
        price = json['price'],
        itemtype = json['itemtype'],
        totalprice = json['totalprice'],
        productqty = json['productqty'],
        numberofitems = json['numberofitems'];

  Map<String, dynamic> toJson() => {
        'id': colId,
        'userid': userid,
        'productid': productid,
        'productname': productname,
        'productimg': productimg,
        'qty': qty,
        'price': price,
        'itemtype': itemtype,
        'totalprice': totalprice,
        'productqty': productqty,
      };
}
