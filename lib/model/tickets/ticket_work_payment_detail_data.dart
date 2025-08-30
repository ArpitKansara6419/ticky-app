class TicketWorkPaymentDetailData {
  String? ticketId;
  String? userId;
  String? workStartDate;
  String? workEndDate;
  String? startTime;
  String? endTime;
  String? totalWorkTime;
  int? hourlyRate;
  int? halfdayRate;
  int? fulldayRate;
  int? monthlyRate;
  int? hourlyPayable;
  int? overtimePayable;
  int? clientPayable;
  int? isOvertime;
  int? isOvertimeApproved;
  int? isHoliday;
  int? isWeekend;
  int? isOutOfOfficeHours;
  String? documentFile;
  int? overtimeHour;
  int? travelCost;
  int? toolCost;
  int? foodCost;
  int? otherPay;
  String? note;
  String? location;
  String? address;
  String? engineerPayoutStatus;
  String? clientPaymentStatus;
  String? status;

  TicketWorkPaymentDetailData({
    this.ticketId,
    this.userId,
    this.workStartDate,
    this.workEndDate,
    this.startTime,
    this.endTime,
    this.totalWorkTime,
    this.hourlyRate,
    this.halfdayRate,
    this.fulldayRate,
    this.monthlyRate,
    this.hourlyPayable,
    this.overtimePayable,
    this.clientPayable,
    this.isOvertime,
    this.isOvertimeApproved,
    this.isHoliday,
    this.isWeekend,
    this.isOutOfOfficeHours,
    this.documentFile,
    this.overtimeHour,
    this.travelCost,
    this.toolCost,
    this.foodCost,
    this.otherPay,
    this.note,
    this.location,
    this.address,
    this.engineerPayoutStatus,
    this.clientPaymentStatus,
    this.status,
  });

  TicketWorkPaymentDetailData.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    workStartDate = json['work_start_date'];
    workEndDate = json['work_end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalWorkTime = json['total_work_time'];
    hourlyRate = json['hourly_rate'];
    halfdayRate = json['halfday_rate'];
    fulldayRate = json['fullday_rate'];
    monthlyRate = json['monthly_rate'];
    hourlyPayable = json['hourly_payable'];
    overtimePayable = json['overtime_payable'];
    clientPayable = json['client_payable'];
    isOvertime = json['is_overtime'];
    isOvertimeApproved = json['is_overtime_approved'];
    isHoliday = json['is_holiday'];
    isWeekend = json['is_weekend'];
    isOutOfOfficeHours = json['is_out_of_office_hours'];
    documentFile = json['document_file'];
    overtimeHour = json['overtime_hour'];
    travelCost = json['travel_cost'];
    toolCost = json['tool_cost'];
    foodCost = json['food_cost'];
    otherPay = json['other_pay'];
    note = json['note'];
    location = json['location'];
    address = json['address'];
    engineerPayoutStatus = json['engineer_payout_status'];
    clientPaymentStatus = json['client_payment_status'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['user_id'] = this.userId;
    data['work_start_date'] = this.workStartDate;
    data['work_end_date'] = this.workEndDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_work_time'] = this.totalWorkTime;
    data['hourly_rate'] = this.hourlyRate;
    data['halfday_rate'] = this.halfdayRate;
    data['fullday_rate'] = this.fulldayRate;
    data['monthly_rate'] = this.monthlyRate;
    data['hourly_payable'] = this.hourlyPayable;
    data['overtime_payable'] = this.overtimePayable;
    data['client_payable'] = this.clientPayable;
    data['is_overtime'] = this.isOvertime;
    data['is_overtime_approved'] = this.isOvertimeApproved;
    data['is_holiday'] = this.isHoliday;
    data['is_weekend'] = this.isWeekend;
    data['is_out_of_office_hours'] = this.isOutOfOfficeHours;
    data['document_file'] = this.documentFile;
    data['overtime_hour'] = this.overtimeHour;
    data['travel_cost'] = this.travelCost;
    data['tool_cost'] = this.toolCost;
    data['food_cost'] = this.foodCost;
    data['other_pay'] = this.otherPay;
    data['note'] = this.note;
    data['location'] = this.location;
    data['address'] = this.address;
    data['engineer_payout_status'] = this.engineerPayoutStatus;
    data['client_payment_status'] = this.clientPaymentStatus;
    data['status'] = this.status;
    return data;
  }
}
