class DoctorWorkHoursModel {
  String? status;
  String? message;
  List<DoctorWorkHoursData>? data;

  DoctorWorkHoursModel({this.status, this.message, this.data});

  DoctorWorkHoursModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DoctorWorkHoursData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorWorkHoursData.fromJson(v));
      });
    }
  }
}

class DoctorWorkHoursData {
  String? hour;
  bool? available;

  DoctorWorkHoursData({this.hour, this.available});

  DoctorWorkHoursData.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    available = json['available'];
  }
}
