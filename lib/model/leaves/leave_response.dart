import 'package:ticky/model/leaves/leave_data.dart';

class LeaveResponse {
  LeaveResponseData? leaveResponseData;
  bool? success;
  String? message;

  LeaveResponse({this.leaveResponseData, this.success, this.message});

  LeaveResponse.fromJson(Map<String, dynamic> json) {
    leaveResponseData = json['data'] != null ? new LeaveResponseData.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveResponseData != null) {
      data['data'] = this.leaveResponseData!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class LeaveResponseData {
  Stats? stats;
  List<LeaveData>? leaveData;

  LeaveResponseData({this.stats, this.leaveData});

  LeaveResponseData.fromJson(Map<String, dynamic> json) {
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    if (json['list'] != null) {
      leaveData = <LeaveData>[];
      json['list'].forEach((v) {
        leaveData!.add(new LeaveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    if (this.leaveData != null) {
      data['list'] = this.leaveData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  String? leaveBalance;
  int? leaveApproved;
  int? leavePending;
  int? leaveCancelled;
  String? freezeLeaveBalance;

  Stats({this.leaveBalance, this.leaveApproved, this.leavePending, this.leaveCancelled, this.freezeLeaveBalance});

  Stats.fromJson(Map<String, dynamic> json) {
    leaveBalance = json['leave_balance'];
    leaveApproved = json['leave_approved'];
    leavePending = json['leave_pending'];
    leaveCancelled = json['leave_cancelled'];
    freezeLeaveBalance = json['freezed_leave_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_balance'] = this.leaveBalance;
    data['leave_approved'] = this.leaveApproved;
    data['leave_pending'] = this.leavePending;
    data['leave_cancelled'] = this.leaveCancelled;
    data['freezed_leave_balance'] = this.freezeLeaveBalance;
    return data;
  }
}
