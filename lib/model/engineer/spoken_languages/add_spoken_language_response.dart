import 'package:ticky/model/engineer/spoken_languages/spoken_language_data.dart';

class AddSpokenLanguageResponse {
  SpokenLanguageData? data;
  String? message;

  AddSpokenLanguageResponse({this.data, this.message});

  AddSpokenLanguageResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SpokenLanguageData.fromJson(json['data']) : null;
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
