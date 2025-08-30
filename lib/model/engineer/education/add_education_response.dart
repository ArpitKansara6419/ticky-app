import 'package:ticky/model/engineer/education/education_data.dart';

class AddEducationResponse {
  EducationData? data;
  String? message;

  AddEducationResponse({this.data, this.message});

  AddEducationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new EducationData.fromJson(json['data']) : null;
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
