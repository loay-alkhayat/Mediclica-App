class CategoriesModel {
  String? status;
  String? message;
  List<Data>? data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }
}

class Attributes {
  String? name;
  String? image;

  Attributes({this.name, this.image});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
