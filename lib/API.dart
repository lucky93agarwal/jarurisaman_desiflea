import 'dart:async';
import 'package:http/http.dart' as http;
const baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

class API {
  static Future getUsers() {
    var url = baseUrl + "MasterCategory";
    return http.get(url);
  }
  static String getAPIUrl() {

    return baseUrl;
  }
  static Future getUsersTwo() {
    var url = baseUrl + "Displaysubproduct";
    return http.get(url);
  }


  static Future getSubCategory() {
    var url = baseUrl + "SubCategories";
    return http.get(url);
  }
}