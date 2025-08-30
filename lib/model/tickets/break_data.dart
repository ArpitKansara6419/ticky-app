import 'package:nb_utils/nb_utils.dart';

class BreakData {
  int? id;
  int? ticketWorkId;
  int? ticketId;
  int? engineerId;
  String? workDate;
  String? startTime;
  String? endTime;
  String? totalBreakTime;
  int? status;

  BreakData({
    this.id,
    this.ticketWorkId,
    this.ticketId,
    this.engineerId,
    this.workDate,
    this.startTime,
    this.endTime,
    this.totalBreakTime,
    this.status,
  });

  static String calculateTotalBreakTime(List<BreakData> breakDataList) {
    Duration totalDuration = Duration.zero;

    for (var breakData in breakDataList) {
      if (breakData.totalBreakTime != null) {
        final parts = breakData.totalBreakTime!.split(':');
        if (parts.length == 3) {
          final hours = int.tryParse(parts[0]) ?? 0;
          final minutes = int.tryParse(parts[1]) ?? 0;
          final seconds = int.tryParse(parts[2]) ?? 0;
          totalDuration += Duration(hours: hours, minutes: minutes, seconds: seconds);
        }
      }
    }

    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes % 60;
    // final seconds = totalDuration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  static String totalTime(String workStartTime, String workEndTime, String workDate, String endDate, List<BreakData> breakDataList) {
    if (workEndTime.validate().isEmpty) return "--"; // Convert work start and end times to DateTime
    if (endDate.validate().isEmpty) return "--"; // Convert work start and end times to DateTime
    DateTime startTime = DateTime.parse("$workDate " + workStartTime);
    DateTime endTime = DateTime.parse("$endDate " + workEndTime);

    // Calculate total work duration
    Duration workDuration = endTime.difference(startTime);

    // Calculate total break duration
    Duration totalBreakDuration = Duration.zero;
    for (var breakData in breakDataList) {
      if (breakData.totalBreakTime != null) {
        final parts = breakData.totalBreakTime!.split(':');
        if (parts.length == 3) {
          final hours = int.tryParse(parts[0]) ?? 0;
          final minutes = int.tryParse(parts[1]) ?? 0;
          final seconds = int.tryParse(parts[2]) ?? 0;
          totalBreakDuration += Duration(hours: hours, minutes: minutes, seconds: seconds);
        }
      }
    }

    // Subtract break duration from work duration
    Duration finalWorkDuration = workDuration - totalBreakDuration;

    final hours = finalWorkDuration.inHours;
    final minutes = finalWorkDuration.inMinutes % 60;
    // final seconds = finalWorkDuration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}hr';
  }

  BreakData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketWorkId = json['ticket_work_id'];
    ticketId = json['ticket_id'];
    engineerId = json['engineer_id'];
    workDate = json['work_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalBreakTime = json['total_break_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_work_id'] = this.ticketWorkId;
    data['ticket_id'] = this.ticketId;
    data['engineer_id'] = this.engineerId;
    data['work_date'] = this.workDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_break_time'] = this.totalBreakTime;
    data['status'] = this.status;
    return data;
  }
}

class BreakResponse {
  bool? status;
  String? message;
  BreakData? data;

  BreakResponse({this.status, this.message, this.data});

  BreakResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BreakData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
