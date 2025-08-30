import 'package:ticky/model/engineer/spoken_languages/spoken_language_data.dart';

class SpokenLanguageResponse {
  List<SpokenLanguageData>? spokenLanguageData;
  String? message;

  SpokenLanguageResponse({this.spokenLanguageData, this.message});

  SpokenLanguageResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      spokenLanguageData = <SpokenLanguageData>[];
      json['data'].forEach((v) {
        spokenLanguageData!.add(new SpokenLanguageData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.spokenLanguageData != null) {
      data['data'] = this.spokenLanguageData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
