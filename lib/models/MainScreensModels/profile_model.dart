class ProfileModel {
  String? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  Attributes? attributes;
  Relationships? relationships;

  Data({this.id, this.attributes, this.relationships});

  Data.fromJson(Map<String, dynamic> json) {
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
  String? gender;
  String? birthDate;
  String? fcmToken;

  Attributes(
      {this.firstName,
      this.lastName,
      this.gender,
      this.birthDate,
      this.fcmToken});

  Attributes.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    fcmToken = json['fcm_token'];
  }
}

class Relationships {
  User? user;

  Relationships({this.user});

  Relationships.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? email;
  String? phone;

  List<String>? imageable;

  User({this.id, this.email, this.phone, this.imageable});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];

    // if (json['imageable'] != null) {
    //   imageable = <String>[];
    //   json['imageable'].forEach((v) {
    //     imageable!.add(new Null.fromJson(v));
    //   });
    // }
  }
}
