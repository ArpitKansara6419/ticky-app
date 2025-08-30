import 'package:ticky/model/attendance/attendance_model.dart';

class AttendanceDateWiseData {
  DateTime? date;
  AttendanceModel? data;

  AttendanceDateWiseData({this.date, this.data});

  AttendanceDateWiseData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    data = json['data'] != null ? new AttendanceModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
