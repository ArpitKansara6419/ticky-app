import 'package:ticky/model/engineer/education/education_data.dart';

class EducationResponse {
  List<EducationData>? educationData;
  String? message;

  EducationResponse({this.educationData, this.message});

  EducationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      educationData = <EducationData>[];
      json['data'].forEach((v) {
        educationData!.add(new EducationData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.educationData != null) {
      data['data'] = this.educationData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
