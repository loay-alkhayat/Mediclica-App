class CenterDetaielsModel {
  String? status;
  String? message;
  CenterDetaielsData? data;

  CenterDetaielsModel({this.status, this.message, this.data});

  CenterDetaielsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new CenterDetaielsData.fromJson(json['data'])
        : null;
  }
}

class CenterDetaielsData {
  int? id;
  Attributes? attributes;
  Relationships? relationships;

  CenterDetaielsData({this.id, this.attributes, this.relationships});

  CenterDetaielsData.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? bio;
  String? image;
  bool? expanded;

  Attributes({this.name, this.bio, this.image});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    image = json['image'];
    expanded = json['expanded'];
  }
}

class Relationships {
  User? user;
  Location? location;
  List<Categories>? categories;

  Relationships({this.user, this.location, this.categories});

  Relationships.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }
}

class User {
  int? id;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? phone;
  String? role;
  String? fcmToken;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.phone,
    this.role,
    this.fcmToken,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    fcmToken = json['fcm_token'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Location {
  int? id;
  String? address;
  String? lat;
  String? lng;
  int? centerId;
  int? doctorId;
  int? governorateId;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.id,
      this.address,
      this.lat,
      this.lng,
      this.centerId,
      this.doctorId,
      this.governorateId,
      this.createdAt,
      this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    centerId = json['center_id'];
    doctorId = json['doctor_id'];
    governorateId = json['governorate_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Categories {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Categories({this.id, this.name, this.createdAt, this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
