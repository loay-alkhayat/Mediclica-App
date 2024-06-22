class DoctorDatesModel {
  String? status;
  String? message;
  List<DoctorDatesData>? data;

  DoctorDatesModel({this.status, this.message, this.data});

  DoctorDatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DoctorDatesData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorDatesData.fromJson(v));
      });
    }
  }
}

class DoctorDatesData {
  String? date;
  String? dayName;
  bool? isVacation;

  DoctorDatesData({this.date, this.dayName, this.isVacation});

  DoctorDatesData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dayName = json['day_name'];
    isVacation = json['is_vacation'];
  }
}
