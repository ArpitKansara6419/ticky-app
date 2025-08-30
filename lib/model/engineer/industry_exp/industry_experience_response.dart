import 'package:ticky/model/engineer/industry_exp/industry_experience_data.dart';

class IndustryExperienceResponse {
  List<IndustryExperienceData>? industryExperienceData;
  String? message;

  IndustryExperienceResponse({this.industryExperienceData, this.message});

  IndustryExperienceResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      industryExperienceData = <IndustryExperienceData>[];
      json['data'].forEach((v) {
        industryExperienceData!.add(new IndustryExperienceData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.industryExperienceData != null) {
      data['data'] = this.industryExperienceData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
