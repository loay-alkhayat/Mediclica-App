class BookAppointmentModel {
  String? status;
  String? message;

  BookAppointmentModel({this.status, this.message});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
