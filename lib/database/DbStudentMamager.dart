import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbStudentMamager {
  static final _databasename = "grofer.db";
  static final _databaseversion = 1;
  static final createuserTable = 'create_user';
  static final firstTable = 'first_table';
  static final secondTable = 'second_table';
  static final addressTable = 'address_table';

  static final colId = 'id';
  static final email = 'email';
  static final mobile = 'mobile';
  static final username = 'name';
  static final password = 'password';

  static final address = 'address';
  static final city = 'city';
  static final state = 'state';
  static final pincode = 'pincode';
  static final street = 'street';



  static final productqty = 'productqty';
  static final userid = 'userid';
  static final productname = 'productname';
  static final productid = 'productid';
  static final productimg = 'productimg';
  static final qty = 'qty';
  static final price = 'price';
  static final itemtype = 'itemtype';
  static final totalprice = 'totalprice';

  static Database _database;

  DbStudentMamager._privateConstruct();

  static final DbStudentMamager instance = DbStudentMamager._privateConstruct();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);

    return await openDatabase(path,
        version: _databaseversion, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $createuserTable (
      $colId INTEGER PRIMARY KEY,
      $userid TEXT NOT NULL,
      $email TEXT NOT NULL,
      $mobile TEXT NOT NULL,
      $username TEXT NOT NULL,
      $password TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $firstTable (
      $colId INTEGER PRIMARY KEY,
      $userid TEXT NOT NULL,
      $productid TEXT NOT NULL,
      $productname TEXT NOT NULL,
      $productimg TEXT NOT NULL,
      $qty TEXT NOT NULL,
      $price TEXT NOT NULL,
      $itemtype TEXT NOT NULL,
      $totalprice TEXT NOT NULL,
      $productqty TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $secondTable (
      $colId INTEGER PRIMARY KEY,
      $userid TEXT NOT NULL,
      $productid TEXT NOT NULL,
      $totalprice TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $addressTable (
      $colId INTEGER PRIMARY KEY,
      $email TEXT NOT NULL,
      $mobile TEXT NOT NULL,
      $username TEXT NOT NULL,
      $address TEXT NOT NULL,
      $city TEXT NOT NULL,
      $state TEXT NOT NULL,
      $pincode TEXT NOT NULL,
      $street TEXT NOT NULL
      )
      ''');


  }

  /// Address Table  inset query

  Future<int> insertaddress(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(addressTable, row);
  }

  /// Address Table  show query
  Future<List<Map<String, dynamic>>> queryalladdress() async {
    Database db = await instance.database;
    return await db.query(addressTable);
  }





  /// User Table  inset query

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(createuserTable, row);
  }

  /// User Table  show query
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;
    return await db.query(createuserTable);
  }

  /// User Table  delete query
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res =
        await db.delete(createuserTable, where: "id = ?", whereArgs: [id]);
    return res;
  }

  /// User Table update query
  Future<int> update(int id) async {
    Database db = await instance.database;
    var res =
        await db.update(createuserTable, {}, where: "id = ?", whereArgs: [id]);
    return res;
  }

  /// firstTable Table  inset query

  Future<int> firstinsert(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(firstTable, row);
  }

  /// firstTable Table  show query
  Future<List<Map<String, dynamic>>> firstqueryall() async {
    Database db = await instance.database;
    return await db.query(firstTable);
  }

  /// firstTable Table  check table empty or not
  Future<int> firstEmpty() async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT count(*) FROM first_table');
    var count = Sqflite.firstIntValue(res);
    return count;
  }

  /// firstTable Table update query
  Future<int> firstupdate(int id, int qty, int totalprice, Map<String, dynamic> row) async {
    Database db = await instance.database;
    var res = await db.rawUpdate('''
    UPDATE first_table SET qty = ?, totalprice = ?  WHERE productid = ?''',[qty, totalprice, id]);
    return res;
  }



  //// check row present or not
  Future<int> checkrow(int id) async {
    Database db = await instance.database;
    int res = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT * FROM first_table  WHERE productid = ?''',[id]));
    return res;
  }






  /// firstTable TotalPrice Table update query
  Future<String> firsttotalprice() async {
    Database db = await instance.database;
    var res =
        await db.rawQuery('SELECT SUM(totalprice) as Total FROM first_table');
    return res[0]['Total'].toString();
  }

  //// delete table in sqlite database
  Future<int> deleteLoginResponse() async {
    Database db = await instance.database;
    var result = await db.delete(firstTable);

    return result;
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(firstTable);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        colId: maps[i]['id'],
        userid: maps[i]['userid'],
        productid: maps[i]['productid'],
        productname: maps[i]['productname'],
        qty: maps[i]['qty'],
        price: maps[i]['price'],
        itemtype: maps[i]['itemtype'],
        totalprice: maps[i]['totalprice'],
      );
    });
  }

// Now, use the method above to retrieve all the dogs.

}

class Dog {
  final String colId;
  final String userid;
  final String productid;
  final String productname;
  final String qty;
  final String price;
  final String itemtype;
  final String totalprice;
  final String productqty;

  Dog(
      {this.colId,
      this.userid,
      this.productid,
      this.productname,
      this.qty,
      this.price,
      this.itemtype,
      this.totalprice,
      this.productqty});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': colId,
      'userid': userid,
      'productid': productid,
      'productname': productname,
      'qty': qty,
      'price': price,
      'itemtype': itemtype,
      'totalprice': totalprice,
      'productqty':productqty,
    };
  }
}
