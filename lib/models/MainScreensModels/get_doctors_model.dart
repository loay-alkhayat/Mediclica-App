class GetDoctorModel {
  String? status;
  int? message;
  List<GetDoctorsData>? data;

  GetDoctorModel({this.status, this.message, this.data});

  GetDoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetDoctorsData>[];
      json['data'].forEach((v) {
        data!.add(new GetDoctorsData.fromJson(v));
      });
    }
  }
}

class GetDoctorsData {
  int? id;
  Attributes? attributes;
  Relationships? relationships;

  GetDoctorsData({this.id, this.attributes, this.relationships});

  GetDoctorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    relationships = json['relationships'] != null
        ? new Relationships.fromJson(json['relationships'])
        : null;
  }
}

class Attributes {
  String? firstName;
  String? lastName;
  String? displayName;
  String? bio;
  String? image;

  Attributes(
      {this.firstName, this.lastName, this.displayName, this.bio, this.image});

  Attributes.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    bio = json['bio'];
    image = json['image'];
  }
}

class Relationships {
  Category? category;
  User? user;

  Relationships({this.category, this.user});

  Relationships.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.name, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class User {
  int? id;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;
  List<Null>? imageable;

  User(
      {this.id,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.imageable});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['imageable'] != null) {
    //   imageable = <Null>[];
    //   json['imageable'].forEach((v) {
    //     imageable!.add(new Null.fromJson(v));
    //   });
    // }
  }
}
