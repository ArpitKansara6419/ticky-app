import 'package:ticky/model/engineer/travel_details/travel_details_data.dart';

class TravelDetailsResponse {
  TravelDetailsData? data;
  bool? success;
  String? message;

  TravelDetailsResponse({this.data, this.success, this.message});

  TravelDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TravelDetailsData.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
