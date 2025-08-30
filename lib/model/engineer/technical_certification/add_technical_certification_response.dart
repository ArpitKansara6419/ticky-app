import 'package:ticky/model/engineer/technical_certification/technical_certification_data.dart';

class AddTechnicalCertificationResponse {
  TechnicalCertificationData? data;
  String? message;

  AddTechnicalCertificationResponse({this.data, this.message});

  AddTechnicalCertificationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TechnicalCertificationData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
