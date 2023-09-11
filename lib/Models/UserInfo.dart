class UserInfo {
  String id;
  String name;
  String email;
  String mobile;
  String address;
  String street;
  String pincode;
  String city;
  String state;

  UserInfo(String id, String name, String email, String mobile, String address,
      String street, String pincode, String city, String state) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.mobile = mobile;
    this.address = address;
    this.street = street;
    this.pincode = pincode;
    this.city = city;
    this.state = state;
  }

  UserInfo.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        mobile = json['mobile'],
        address = json['address'],
        street = json['street'],
        pincode = json['pincode'],
        city = json['city'],
        state = json['state'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'mobile': mobile, 'address': address, 'street': street, 'pincode': pincode, 'city': city, 'state': state};
  }
}
