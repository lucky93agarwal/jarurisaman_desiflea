class Error {
  String error;

  Error(String error) {
    this.error = error;
    
  }
  Error.fromJson(Map json)
      : error = json['error'];


  Map toJson() {
    return {'error': error};
  }
}