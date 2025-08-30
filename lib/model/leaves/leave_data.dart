import 'package:ticky/utils/config.dart';

class LeaveData {
  int? id;
  int? engineerId;
  String? paidFromDate;
  String? paidToDate;
  String? unpaidFromDate;
  String? unpaidToDate;
  String? paidLeaveDays;
  String? unpaidLeaveDays;
  String? unpaidReason;
  String? note;
  String? paidDocument;
  String? paidSignedDocument;
  String? unpaidDocument;
  String? unpaidSignedDocument;
  String? leaveApproveStatus;

  LeaveData(
      {this.id,
      this.engineerId,
      this.paidFromDate,
      this.paidToDate,
      this.unpaidFromDate,
      this.unpaidToDate,
      this.paidLeaveDays,
      this.unpaidLeaveDays,
      this.unpaidReason,
      this.note,
      this.paidDocument,
      this.unpaidDocument,
      this.paidSignedDocument,
      this.unpaidSignedDocument,
      this.leaveApproveStatus});

  LeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineerId = json['engineer_id'];
    paidFromDate = json['paid_from_date'];
    paidToDate = json['paid_to_date'];
    unpaidFromDate = json['unpaid_from_date'];
    unpaidToDate = json['unpaid_to_date'];
    paidLeaveDays = json['paid_leave_days'];
    unpaidLeaveDays = json['unpaid_leave_days'];
    unpaidReason = json['unpaid_reason'];
    note = json['note'];
    paidDocument = json['unsigned_paid_document'] != null ? Config.imageUrl + json['unsigned_paid_document'] : null;
    unpaidDocument = json['unsigned_unpaid_document'] != null ? Config.imageUrl + json['unsigned_unpaid_document'] : null;
    paidSignedDocument = json['signed_paid_document'] != null ? Config.imageUrl + json['signed_paid_document'] : null;
    unpaidSignedDocument = json['signed_unpaid_document'] != null ? Config.imageUrl + json['signed_unpaid_document'] : null;
    leaveApproveStatus = json['leave_approve_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['engineer_id'] = this.engineerId;
    data['paid_from_date'] = this.paidFromDate;
    data['paid_to_date'] = this.paidToDate;
    data['unpaid_from_date'] = this.unpaidFromDate;
    data['unpaid_to_date'] = this.unpaidToDate;
    data['paid_leave_days'] = this.paidLeaveDays;
    data['unpaid_leave_days'] = this.unpaidLeaveDays;
    data['unpaid_reason'] = this.unpaidReason;
    data['note'] = this.note;
    data['unsigned_paid_document'] = this.paidDocument;
    data['unsigned_unpaid_document'] = this.unpaidDocument;
    data['signed_paid_document'] = this.paidSignedDocument;
    data['signed_unpaid_document'] = this.unpaidSignedDocument;
    data['leave_approve_status'] = this.leaveApproveStatus;
    return data;
  }
}
