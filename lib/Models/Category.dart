

import 'Media.dart';

class Category {
  String id;
  String name;
  String image;

  Category(String id, String name, String image) {
    this.id = id;
    this.name = name;
    this.image = image;
  }

  Category.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];


  Map toJson() {
    return {'id': id, 'name': name, 'image': image};
  }

}