class MyAppointmentModel {
  String? status;
  String? message;
  List<MyAppointmentData>? data;

  MyAppointmentModel({this.status, this.message, this.data});

  MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(new MyAppointmentData.fromJson(v));
      });
    }
  }
}

class MyAppointmentData {
  int? id;
  Attributes? attributes;
  Relationships? relationships;

  MyAppointmentData({this.id, this.attributes, this.relationships});

  MyAppointmentData.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? startTime;
  String? endTime;
  String? comment;
  String? status;
  String? category;

  Attributes(
      {this.date,
      this.startTime,
      this.endTime,
      this.comment,
      this.status,
      this.category});

  Attributes.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    comment = json['comment'];
    status = json['status'];
    category = json['category'];
  }
}

class Relationships {
  Doctor? doctor;
  Service? service;
  Client? client;
  String? image;

  Relationships({this.doctor, this.service, this.client});

  Relationships.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }
}

class Doctor {
  int? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? bio;
  String? gender;
  String? hasPlace;
  int? userId;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;
  String? image;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.displayName,
      this.bio,
      this.gender,
      this.hasPlace,
      this.userId,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.image});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    bio = json['bio'];
    gender = json['gender'];
    hasPlace = json['has_place'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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

class Service {
  int? id;
  String? name;
  int? duration;
  String? price;
  int? doctorId;
  Null? centerId;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
      this.name,
      this.duration,
      this.price,
      this.doctorId,
      this.centerId,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    duration = json['duration'];
    price = json['price'];
    doctorId = json['doctor_id'];
    centerId = json['center_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Client {
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? birthDate;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Client(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthDate,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
