class LoginModel {
  String? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  User? user;
  String? token;
  String? role;

  Data({this.user, this.token, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    role = json['role'];
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
  // String? image;

  User({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.role,
    this.createdAt,
    this.updatedAt,
    // this.image
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['imageable'] != null) {
    //   if (json['imageable'] is List) {
    //     // Handle the list case, for example, take the first element
    //     image = json['imageable'];
    //   } else {
    //     // Handle the string case
    //     image = json['imageable'];
    //   }
    // }
    // if (json['imageable'] != null) {
    //   image = <Null>[];
    //   json['imageable'].forEach((v) {
    //     image!.add(new Null.fromJson(v));
    //   });
    // }
  }
}
