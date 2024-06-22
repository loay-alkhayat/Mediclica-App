class DoctorServicesModel {
  String? status;
  String? message;
  List<DoctorServicesData>? data;

  DoctorServicesModel({this.status, this.message, this.data});

  DoctorServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DoctorServicesData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorServicesData.fromJson(v));
      });
    }
  }
}

class DoctorServicesData {
  int? id;
  Attributes? attributes;
  Relationships? relationships;

  DoctorServicesData({this.id, this.attributes, this.relationships});

  DoctorServicesData.fromJson(Map<String, dynamic> json) {
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
  int? duration;
  String? price;
  String? createdAt;
  String? updatedAt;
  bool? active;

  Attributes(
      {this.name,
      this.duration,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.active});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    duration = json['duration'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    active = json['active'];
  }
}

class Relationships {
  int? doctorId;

  Relationships({this.doctorId});

  Relationships.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
  }
}
