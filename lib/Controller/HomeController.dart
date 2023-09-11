



import 'package:delivoo/Models/Category.dart';
import 'package:delivoo/repository/category_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];




  HomeController() {
    listenForCategories();
  }


  Future<void> listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }




  Future<void> refreshHome() async {
    setState(() {
      categories = <Category>[];

    });

    await listenForCategories();

  }
}