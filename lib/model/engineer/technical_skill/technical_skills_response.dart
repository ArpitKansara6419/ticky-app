import 'package:ticky/model/engineer/technical_skill/technical_skills_data.dart';

class TechnicalSkillResponse {
  List<TechnicalSkillData>? technicalSkillData;
  String? message;

  TechnicalSkillResponse({this.technicalSkillData, this.message});

  TechnicalSkillResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      technicalSkillData = <TechnicalSkillData>[];
      json['data'].forEach((v) {
        technicalSkillData!.add(new TechnicalSkillData.fromJson(v));
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
