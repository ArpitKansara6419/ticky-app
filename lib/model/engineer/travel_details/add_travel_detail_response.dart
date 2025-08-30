import 'package:ticky/model/engineer/travel_details/travel_details_data.dart';

class AddTravelDetailsResponse {
  TravelDetailsData? data;
  String? message;

  AddTravelDetailsResponse({this.data, this.message});

  AddTravelDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TravelDetailsData.fromJson(json['data']) : null;
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
