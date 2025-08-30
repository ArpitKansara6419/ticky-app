import 'package:ticky/model/engineer/technical_certification/technical_certification_data.dart';

class TechnicalCertificationResponse {
  List<TechnicalCertificationData>? technicalSkillData;
  String? message;

  TechnicalCertificationResponse({this.technicalSkillData, this.message});

  TechnicalCertificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      technicalSkillData = <TechnicalCertificationData>[];
      json['data'].forEach((v) {
        technicalSkillData!.add(new TechnicalCertificationData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.technicalSkillData != null) {
      data['data'] = this.technicalSkillData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
