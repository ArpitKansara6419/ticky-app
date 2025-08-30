import 'package:ticky/model/engineer/industry_exp/industry_experience_data.dart';

class AddIndustryExperienceResponse {
  IndustryExperienceData? data;
  String? message;

  AddIndustryExperienceResponse({this.data, this.message});

  AddIndustryExperienceResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new IndustryExperienceData.fromJson(json['data']) : null;
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
