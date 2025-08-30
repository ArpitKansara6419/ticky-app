class AttendanceResponse {
  bool? status;
  AttendanceData? attendanceData;

  AttendanceResponse({this.status, this.attendanceData});

  AttendanceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    attendanceData = json['data'] != null ? new AttendanceData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.attendanceData != null) {
      data['data'] = this.attendanceData!.toJson();
    }
    return data;
  }
}

class AttendanceData {
  String? date;
  bool? availability;
  String? checkInTime;
  String? checkOutTime;
  String? breakTime;
  int? totalTickets;

  AttendanceData({this.date, this.availability, this.checkInTime, this.checkOutTime, this.breakTime, this.totalTickets});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    availability = json['availability'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    breakTime = json['break_time'];
    totalTickets = json['total_tickets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['availability'] = this.availability;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['break_time'] = this.breakTime;
    data['total_tickets'] = this.totalTickets;
    return data;
  }
}
