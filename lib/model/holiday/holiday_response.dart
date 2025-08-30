import 'package:ticky/model/holiday/holiday_data.dart';

class HolidayResponse {
  bool? status;
  List<HolidayData>? holidayData;

  HolidayResponse({this.status, this.holidayData});

  HolidayResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      holidayData = <HolidayData>[];
      json['data'].forEach((v) {
        holidayData!.add(new HolidayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.holidayData != null) {
      data['data'] = this.holidayData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
