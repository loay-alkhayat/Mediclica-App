class AIModel {
  String? status;
  String? message;
  List<AiData>? data;

  AIModel({this.status, this.message, this.data});

  AIModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AiData>[];
      json['data'].forEach((v) {
        data!.add(new AiData.fromJson(v));
      });
    }
  }
}

class AiData {
  double? chances;
  String? description;
  String? disease;
  String? specialist;

  AiData({this.chances, this.description, this.disease, this.specialist});

  AiData.fromJson(Map<String, dynamic> json) {
    chances = json['Chances'];
    description = json['Description'];
    disease = json['Disease'];
    specialist = json['Specialist'];
  }
}
