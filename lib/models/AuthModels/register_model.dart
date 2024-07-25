class RegisterModel {
  String? status;
  Data? data;

  RegisterModel({this.status, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }
}

class User {
  String? email;
  String? phone;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.email,
      this.phone,
      this.role,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
