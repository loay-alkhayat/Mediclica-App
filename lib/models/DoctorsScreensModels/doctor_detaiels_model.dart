class DoctorDetaielsModel {
  String? status;
  String? message;
  DoctorDetaielsData? data;

  DoctorDetaielsModel({this.status, this.message, this.data});

  DoctorDetaielsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new DoctorDetaielsData.fromJson(json['data'])
        : null;
  }
}

class DoctorDetaielsData {
  int? id;
  Attributes? attributes;
  Relationships? relationships;

  DoctorDetaielsData({this.id, this.attributes, this.relationships});

  DoctorDetaielsData.fromJson(Map<String, dynamic> json) {
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
  List<Location>? location;
  WorkHours? workHours;

  Relationships({this.category, this.user, this.location, this.workHours});

  Relationships.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(new Location.fromJson(v));
      });
    }
    workHours = json['work_hours'] != null
        ? new WorkHours.fromJson(json['work_hours'])
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
  List<Imageable>? imageable;

  User(
      {this.id,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.phone,
      this.role,
      this.fcmToken,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.imageable});

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
    if (json['imageable'] != null) {
      imageable = <Imageable>[];
      json['imageable'].forEach((v) {
        imageable!.add(new Imageable.fromJson(v));
      });
    }
  }
}

class Imageable {
  int? id;
  String? path;
  String? imageType;
  String? imageableType;
  int? imageableId;
  String? createdAt;
  String? updatedAt;

  Imageable(
      {this.id,
      this.path,
      this.imageType,
      this.imageableType,
      this.imageableId,
      this.createdAt,
      this.updatedAt});

  Imageable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    imageType = json['image_type'];
    imageableType = json['imageable_type'];
    imageableId = json['imageable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['image_type'] = this.imageType;
    data['imageable_type'] = this.imageableType;
    data['imageable_id'] = this.imageableId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
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

class WorkHours {
  int? id;
  String? day;
  String? startDate;
  String? endDate;
  String? startHour;
  String? endHour;
  String? centerId;
  int? doctorId;
  String? createdAt;
  String? updatedAt;

  WorkHours(
      {this.id,
      this.day,
      this.startDate,
      this.endDate,
      this.startHour,
      this.endHour,
      this.centerId,
      this.doctorId,
      this.createdAt,
      this.updatedAt});

  WorkHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    centerId = json['center_id'];
    doctorId = json['doctor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
