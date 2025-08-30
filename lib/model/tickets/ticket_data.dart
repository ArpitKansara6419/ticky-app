/*
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/model/tickets/lead_data.dart';
import 'package:nb_utils/nb_utils.dart';

class TicketData {
  int? id;
  int? engineerId;
  int? customerId;
  int? leadId;
  User? engineer;
  Customer? customer;
  LeadData? lead;
  List<TicketWorks>? ticketWorks;
  String? clientName;
  String? clientAddress;
  String? taskDate;
  String? taskTime;
  String? scopeOfWork;
  String? pocDetails;
  String? reDetails;
  String? callInvites;
  String? refSignSheet;
  String? documents;
  int? standardRate;
  int? travelCost;
  int? toolCost;
  String? foodExpenses;
  String? miscExpenses;
  String? currencyType;
  String? status;
  String? apartment;
  String? addLine1;
  String? addLine2;
  String? city;
  String? country;
  String? engineerStatus;

  TicketData(
      {this.id,
      this.engineerId,
      this.customerId,
      this.leadId,
      this.engineer,
      this.customer,
      this.lead,
      this.ticketWorks,
      this.clientName,
      this.clientAddress,
      this.taskDate,
      this.taskTime,
      this.scopeOfWork,
      this.pocDetails,
      this.reDetails,
      this.callInvites,
      this.refSignSheet,
      this.documents,
      this.standardRate,
      this.travelCost,
      this.toolCost,
      this.foodExpenses,
      this.miscExpenses,
      this.currencyType,
      this.status,
      this.apartment,
      this.addLine1,
      this.addLine2,
      this.city,
      this.country,
      this.engineerStatus});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineerId = json['engineer_id'];
    customerId = json['customer_id'];
    leadId = json['lead_id'];
    engineer = json['engineer'] != null ? new User.fromJson(json['engineer']) : null;
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    lead = json['lead'] != null ? new LeadData.fromJson(json['lead']) : null;
    // lead = json['lead'];
    if (json['ticket_works'] != null) {
      ticketWorks = <TicketWorks>[];
      json['ticket_works'].forEach((v) {
        ticketWorks!.add(new TicketWorks.fromJson(v));
      });
    }
    clientName = json['client_name'];
    clientAddress = json['client_address'];
    taskDate = json['task_date'];
    taskTime = json['task_time'];
    scopeOfWork = json['scope_of_work'];
    pocDetails = json['poc_details'];
    reDetails = json['re_details'];
    callInvites = json['call_invites'];
    refSignSheet = json['ref_sign_sheet'];
    documents = json['documents'];
    // standardRate = json['standard_rate'];
    travelCost = json['travel_cost'];
    toolCost = json['tool_cost'];
    foodExpenses = json['food_expenses'];
    miscExpenses = json['misc_expenses'];
    currencyType = json['currency_type'];
    status = json['status'];
    apartment = json['apartment'];
    addLine1 = json['add_line_1'];
    addLine2 = json['add_line_2'];
    city = json['city'];
    country = json['country'];
    engineerStatus = json['engineer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['engineer_id'] = this.engineerId;
    data['customer_id'] = this.customerId;
    data['lead_id'] = this.leadId;
    if (this.engineer != null) {
      data['engineer'] = this.engineer!.toJson();
    }
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['lead'] = this.lead;
    if (this.ticketWorks != null) {
      data['ticket_works'] = this.ticketWorks!.map((v) => v.toJson()).toList();
    }
    data['client_name'] = this.clientName;
    data['client_address'] = this.clientAddress;
    data['task_date'] = this.taskDate;
    data['task_time'] = this.taskTime;
    data['scope_of_work'] = this.scopeOfWork;
    data['poc_details'] = this.pocDetails;
    data['re_details'] = this.reDetails;
    data['call_invites'] = this.callInvites;
    data['ref_sign_sheet'] = this.refSignSheet;
    data['documents'] = this.documents;
    data['standard_rate'] = this.standardRate;
    data['travel_cost'] = this.travelCost;
    data['tool_cost'] = this.toolCost;
    data['food_expenses'] = this.foodExpenses;
    data['misc_expenses'] = this.miscExpenses;
    data['currency_type'] = this.currencyType;
    data['status'] = this.status;
    data['apartment'] = this.apartment;
    data['add_line_1'] = this.addLine1;
    data['add_line_2'] = this.addLine2;
    data['city'] = this.city;
    data['country'] = this.country;
    data['engineer_status'] = this.engineerStatus;
    return data;
  }

  String toAddressJson() {
    // Collect all the address parts and validate them
    final parts = [
      apartment,
      addLine1,
      addLine2,
      country,
      city,
      // zipcode,
    ].map((e) => e?.validate() ?? '').toList();

    // Join the non-null parts with a delimiter (e.g., ", ")
    return parts.where((e) => e.isNotEmpty).join(', ');
  }
}


*/
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/model/tickets/break_data.dart';
import 'package:ticky/model/tickets/lead_data.dart';
import 'package:ticky/model/tickets/ticket_work_notes.dart';
import 'package:ticky/model/tickets/workexpense.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/functions.dart';
import 'package:ticky/view/tickets/functions.dart';

class TicketData {
  int? id;
  String? ticketCode;
  int? engineerId;
  int? customerId;
  int? leadId;
  User? engineer;
  Customer? customer;
  LeadData? lead;
  num? ticketCurrentWorkId;
  List<TicketWorks>? ticketWorks;
  String? clientName;
  String? clientAddress;
  String? taskName;
  String? taskStartDate;
  String? taskEndDate;
  String? taskTime;
  String? ticketTimeTz;
  String? ticket_start_date_tz;
  String? ticket_end_date_tz;
  String? scopeOfWork;
  String? pocDetails;
  String? reDetails;
  String? callInvites;
  String? refSignSheet;
  String? documents;
  int? standardRate;
  num? travelCost;
  num? toolCost;
  num? foodExpenses;
  num? miscExpenses;
  String? currencyType;
  String? engineerStatus;
  String? apartment;
  String? addLine1;
  String? addLine2;
  String? city;
  String? country;
  String? zipcode;
  String? ticketStatus;
  String? ticketLat;
  String? ticketLng;
  String? rateType;
  num? engineerAgreedRate;
  int? isEngineerAgreedRate;

  //local
  TicketDayType? ticketDayType;

  TicketData({
    this.id,
    this.ticketCode,
    this.engineerId,
    this.customerId,
    this.leadId,
    this.engineer,
    this.customer,
    this.lead,
    this.ticketCurrentWorkId,
    this.ticketWorks,
    this.clientName,
    this.clientAddress,
    this.taskName,
    this.taskStartDate,
    this.ticketTimeTz,
    this.taskEndDate,
    this.taskTime,
    this.scopeOfWork,
    this.pocDetails,
    this.reDetails,
    this.ticket_start_date_tz,
    this.ticket_end_date_tz,
    this.callInvites,
    this.refSignSheet,
    this.documents,
    this.standardRate,
    this.travelCost,
    this.toolCost,
    this.foodExpenses,
    this.miscExpenses,
    this.currencyType,
    this.engineerStatus,
    this.apartment,
    this.addLine1,
    this.addLine2,
    this.city,
    this.country,
    this.zipcode,
    this.ticketStatus,
    this.ticketDayType,
    this.ticketLat,
    this.ticketLng,
    this.rateType,
    this.engineerAgreedRate,
    this.isEngineerAgreedRate,
  });

  bool isProgress() => engineerStatus == "inprogress";

  bool isBreak() => engineerStatus == "break";

  bool isHold() => engineerStatus == "hold";

  bool isClose() => engineerStatus == "close";

  bool isExpired() => engineerStatus.toString().toLowerCase() == "expire" || engineerStatus.toString().toLowerCase() == "expired";

  bool isAgreedRateForEngineer() => engineerAgreedRate.validate() > 0;

  bool isTaskDateToday() {
    if (taskStartDate != null) {
      final parsedDate = DateTime.tryParse(taskStartDate!);
      if (parsedDate != null) {
        final today = DateTimeUtils.convertDateTimeToUTC(
          dateTime: DateTime.now(),
        );
        return parsedDate.year == today.year && parsedDate.month == today.month && parsedDate.day == today.day;
      }
    }
    return false; // Return false if the task date is null or invalid
  }

  TicketDayType getTicketDayType() {
    int dayDifference = 0;
    DateTime? taskStartDateLocal;
    DateTime? taskEndDateLocal;

    DateTime todayDate = DateFormat(ShowDateFormat.apiCallingDate).parse(
      DateFormat(ShowDateFormat.apiCallingDate).format(
        DateTimeUtils.convertDateTimeToUTC(
          dateTime: DateTime.now(),
        ),
      ),
    );

    if (taskStartDate != null && taskStartDate!.isNotEmpty) {
      taskStartDateLocal = DateFormat(ShowDateFormat.apiCallingDate).parse(taskStartDate!);
    }

    if (taskEndDate != null && taskEndDate!.isNotEmpty) {
      taskEndDateLocal = DateFormat(ShowDateFormat.apiCallingDate).parse(taskEndDate!);
    }

    if (taskStartDateLocal != null && taskEndDateLocal != null) {
      dayDifference = taskEndDateLocal.difference(taskStartDateLocal).inDays;
    }

    /// same day
    if (dayDifference == 0) {
      return TicketDayType.SameDay;
    }

    if (taskStartDateLocal != null && DateFormat(ShowDateFormat.apiCallingDate).format(todayDate) == DateFormat(ShowDateFormat.apiCallingDate).format(taskStartDateLocal)) {
      return TicketDayType.StartingDay;
    }
    if (taskStartDateLocal != null && taskEndDateLocal != null && taskStartDateLocal.isBefore(todayDate) && taskEndDateLocal.isAfter(todayDate)) {
      return TicketDayType.MiddleDay;
    }
    if (taskEndDateLocal != null && DateFormat(ShowDateFormat.apiCallingDate).format(todayDate) == DateFormat(ShowDateFormat.apiCallingDate).format(taskEndDateLocal)) {
      return TicketDayType.EndingDay;
    }
    return TicketDayType.None;
  }

  bool get isSameDay {
    // Parse the start and end dates from the ticket
    DateTime start = DateTime.parse(taskStartDate.validate());
    DateTime end = DateTime.parse(taskEndDate.validate());

    // Ensure start and end dates are without time
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);
    return start.isAtSameMomentAs(end);
  }

  bool get isTimeEnable {
    if (taskStartDate != null && taskTime != null && taskStartDate!.isNotEmpty && taskTime!.isNotEmpty) {
      final DateTime taskStartDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('${formatDate(DateTime.now().toString(), outputFormat: ShowDateFormat.yyyyMmDdDash)} ${taskTime!}');
      final DateTime now = DateTime.now();
      // Check if task is today and within 10 minutes
      final bool isToday = taskStartDateTime.year == now.year && taskStartDateTime.month == now.month && taskStartDateTime.day == now.day;

      final bool isWithin10MinutesBefore = taskStartDateTime.difference(now).inMinutes < 10;

      return isToday && isWithin10MinutesBefore;
    }
    return false;
  }

  bool canStartWorkNew({DateTime? focusedDay}) {
    try {
      // Get the current date without time
      DateTime currentDate = DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

      // Parse the start and end dates from the ticket
      DateTime start = DateTime.parse(taskStartDate.validate());
      DateTime end = DateTime.parse(taskEndDate.validate());

      // Ensure start and end dates are without time
      start = DateTime(start.year, start.month, start.day);
      end = DateTime(end.year, end.month, end.day);

      // If focusedDay is provided (e.g., for UI checks), use it; otherwise, use currentDate
      DateTime checkDate = focusedDay ?? currentDate;
      checkDate = DateTime(checkDate.year, checkDate.month, checkDate.day);

      // Find the last recorded work date in ticketWorks
      DateTime? lastWorkDate;
      if (ticketWorks.validate().isNotEmpty) {
        lastWorkDate = ticketWorks.validate().map((work) => DateTime.parse(work.workStartDate.validate())).reduce((a, b) => a.isAfter(b) ? a : b);
        lastWorkDate = DateTime(lastWorkDate.year, lastWorkDate.month, lastWorkDate.day);
      }

      // Check if work has already been started today
      bool hasWorkStartedToday = ticketWorks.validate().any((work) {
        DateTime workStartDate = DateTime.parse(work.workStartDate.validate());
        workStartDate = DateTime(workStartDate.year, workStartDate.month, workStartDate.day);
        return workStartDate.isAtSameMomentAs(currentDate);
      });

      // ✅ Special Case: Only one login per day
      if (hasWorkStartedToday) return false;

      // ✅ Case 1: Same-Day Ticket Carry Forward
      if (start.isAtSameMomentAs(end) && checkDate.isAtSameMomentAs(start)) {
        // If the ticket is not completed, allow login on all following days
        return true;
      } else if (start.isAtSameMomentAs(end) && isHold()) {
        return true;
      }

      // ✅ Case 2: Multi-Day Ticket (Daily login option till the end date)
      if (checkDate.isAtSameMomentAs(start) || (checkDate.isAfter(start) && checkDate.isBefore(end)) || checkDate.isAtSameMomentAs(end)) {
        return true;
      }

      // Default: Work cannot start
      return false;
    } catch (e) {
      throw Exception('Invalid date format: $e');
    }
  }

  String toAddressJson() {
    // Collect all the address parts and validate them
    final parts = [
      apartment,
      addLine1,
      addLine2,
      country,
      city,
      zipcode,
    ].map((e) => e?.validate() ?? '').toList();

    // Join the non-null parts with a delimiter (e.g., ", ")
    return parts.where((e) => e.isNotEmpty).join(', ');
  }

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketCode = json['ticket_code'];
    engineerId = json['engineer_id'];
    customerId = json['customer_id'];
    leadId = json['lead_id'];
    engineer = json['engineer'] != null ? new User.fromJson(json['engineer']) : null;
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    lead = json['lead'] != null ? new LeadData.fromJson(json['lead']) : null;
    ticketCurrentWorkId = json['ticket_current_work_id'];
    if (json['ticket_works'] != null) {
      ticketWorks = <TicketWorks>[];
      json['ticket_works'].forEach((v) {
        ticketWorks!.add(new TicketWorks.fromJson(v));
      });
    }
    clientName = json['client_name'];
    ticketTimeTz = json['ticket_time_tz'];
    ticket_start_date_tz = json['ticket_start_date_tz'];
    ticket_end_date_tz = json['ticket_end_date_tz'];
    clientAddress = json['client_address'];
    taskName = json['task_name'];
    taskStartDate = json['task_start_date'];
    taskEndDate = json['task_end_date'];
    taskTime = json['task_time'];
    scopeOfWork = json['scope_of_work'];
    pocDetails = json['poc_details'];
    reDetails = json['re_details'];
    callInvites = json['call_invites'];
    refSignSheet = json['ref_sign_sheet'];
    documents = json['documents'];
    standardRate = json['standard_rate'];
    engineerAgreedRate = json['engineer_agreed_rate'];
    isEngineerAgreedRate = json['is_engineer_agreed_rate'];
    travelCost = json['travel_cost'];
    toolCost = json['tool_cost'];
    foodExpenses = json['food_expenses'];
    miscExpenses = json['misc_expenses'];
    currencyType = json['currency_type'];
    engineerStatus = json['status'];
    apartment = json['apartment'];
    addLine1 = json['add_line_1'];
    addLine2 = json['add_line_2'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    ticketStatus = json['engineer_status'];
    ticketDayType = getTicketDayType();
    ticketLat = json['latitude'];
    ticketLng = json['longitude'];
    rateType = json['rate_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_code'] = this.ticketCode;
    data['engineer_id'] = this.engineerId;
    data['engineer_agreed_rate'] = this.engineerAgreedRate;
    data['is_engineer_agreed_rate'] = this.isEngineerAgreedRate;
    data['customer_id'] = this.customerId;
    data['lead_id'] = this.leadId;
    if (this.engineer != null) {
      data['engineer'] = this.engineer!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    data['ticket_current_work_id'] = this.ticketCurrentWorkId;
    if (this.ticketWorks != null) {
      data['ticket_works'] = this.ticketWorks!.map((v) => v.toJson()).toList();
    }
    data['client_name'] = this.clientName;
    data['ticket_start_date_tz'] = this.ticket_start_date_tz;
    data['ticket_end_date_tz'] = this.ticket_end_date_tz;
    data['client_address'] = this.clientAddress;
    data['task_name'] = this.taskName;
    data['task_start_date'] = this.taskStartDate;
    data['task_end_date'] = this.taskEndDate;
    data['task_time'] = this.taskTime;
    data['scope_of_work'] = this.scopeOfWork;
    data['poc_details'] = this.pocDetails;
    data['re_details'] = this.reDetails;
    data['call_invites'] = this.callInvites;
    data['ref_sign_sheet'] = this.refSignSheet;
    data['documents'] = this.documents;
    data['standard_rate'] = this.standardRate;
    data['travel_cost'] = this.travelCost;
    data['tool_cost'] = this.toolCost;
    data['food_expenses'] = this.foodExpenses;
    data['misc_expenses'] = this.miscExpenses;
    data['currency_type'] = this.currencyType;
    data['status'] = this.engineerStatus;
    data['apartment'] = this.apartment;
    data['add_line_1'] = this.addLine1;
    data['add_line_2'] = this.addLine2;

    data['ticket_time_tz'] = this.ticketTimeTz;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['engineer_status'] = this.ticketStatus;
    data['longitude'] = this.ticketLng;
    data['longitude'] = this.ticketLat;
    data['rate_type'] = this.rateType;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? customerType;
  String? companyRegNo;
  String? address;
  String? vatNo;
  String? email;
  String? authPerson;
  String? authPersonEmail;
  String? authPersonContact;
  String? profileImage;
  String? docRef;
  int? status;

  Customer(
      {this.id,
      this.name,
      this.customerType,
      this.companyRegNo,
      this.address,
      this.vatNo,
      this.email,
      this.authPerson,
      this.authPersonEmail,
      this.authPersonContact,
      this.profileImage,
      this.docRef,
      this.status});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    customerType = json['customer_type'];
    companyRegNo = json['company_reg_no'];
    address = json['address'];
    vatNo = json['vat_no'];
    email = json['email'];
    authPerson = json['auth_person'];
    authPersonEmail = json['auth_person_email'];
    authPersonContact = json['auth_person_contact'];
    profileImage = json['profile_image'];
    docRef = json['doc_ref'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['customer_type'] = this.customerType;
    data['company_reg_no'] = this.companyRegNo;
    data['address'] = this.address;
    data['vat_no'] = this.vatNo;
    data['email'] = this.email;
    data['auth_person'] = this.authPerson;
    data['auth_person_email'] = this.authPersonEmail;
    data['auth_person_contact'] = this.authPersonContact;
    data['profile_image'] = this.profileImage;
    data['doc_ref'] = this.docRef;
    data['status'] = this.status;
    return data;
  }
}

class TicketWorks {
  int? workId;
  int? ticketId;
  int? userId;
  String? workStartDate;
  String? workEndDate;
  String? startTime;
  String? endTime;
  String? totalWorkTime;
  num? hourlyRate;
  double? latitude;

  double? longitude;
  num? halfdayRate;
  num? fulldayRate;
  num? monthlyRate;
  num? hourlyPayable;
  num? overtimePayable;
  num? out_of_office_payable;
  num? weekend_payable;
  num? holiday_payable;
  num? isOvertime;
  num? isOvertimeApproved;
  num? isHoliday;
  num? isWeekend;
  num? isOutOfOfficeHours;
  String? out_of_office_duration;
  String? documentFile;
  String? overtimeHour;
  num? travelCost;
  num? toolCost;
  num? foodCost;
  num? otherPay;
  String? note;
  String? address;
  String? engineerPayoutStatus;
  String? status;
  List<BreakData>? breaks;
  List<Workexpense>? workexpense;
  List<TicketWorkNotes>? ticketWorkNotes;

  TicketWorks({
    this.workId,
    this.ticketId,
    this.userId,
    this.workStartDate,
    this.workEndDate,
    this.startTime,
    this.endTime,
    this.out_of_office_duration,
    this.out_of_office_payable,
    this.totalWorkTime,
    this.hourlyRate,
    this.halfdayRate,
    this.fulldayRate,
    this.weekend_payable,
    this.holiday_payable,
    this.monthlyRate,
    this.hourlyPayable,
    this.overtimePayable,
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
    this.address,
    this.latitude,
    this.longitude,
    this.engineerPayoutStatus,
    this.status,
    this.breaks,
    this.workexpense,
    this.ticketWorkNotes,
  });

  TicketWorks.fromJson(Map<String, dynamic> json) {
    workId = json['id'];
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    workStartDate = json['work_start_date'];
    workEndDate = json['work_end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalWorkTime = json['total_work_time'];
    hourlyRate = json['hourly_rate'];
    out_of_office_duration = json['out_of_office_duration'];
    out_of_office_payable = json['out_of_office_payable'];
    halfdayRate = json['halfday_rate'];
    fulldayRate = json['fullday_rate'];
    monthlyRate = json['monthly_rate'];
    out_of_office_duration = json['out_of_office_duration'];
    hourlyPayable = json['hourly_payable'];
    overtimePayable = json['overtime_payable'];
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
    weekend_payable = json['weekend_payable'];
    holiday_payable = json['holiday_payable'];
    otherPay = json['other_pay'];
    note = json['note'];
    address = json['address'];
    engineerPayoutStatus = json['engineer_payout_status'];
    status = json['status'];
    if (json['breaks'] != null) {
      breaks = <BreakData>[];
      json['breaks'].forEach((v) {
        breaks!.add(new BreakData.fromJson(v));
      });
    }
    if (json['workexpense'] != null) {
      workexpense = <Workexpense>[];
      json['workexpense'].forEach((v) {
        workexpense!.add(new Workexpense.fromJson(v));
      });
    }
    if (json['ticket_work_notes'] != null) {
      ticketWorkNotes = <TicketWorkNotes>[];
      json['ticket_work_notes'].forEach((v) {
        ticketWorkNotes!.add(new TicketWorkNotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.workId;
    data['ticket_id'] = this.ticketId;
    data['user_id'] = this.userId;
    data['work_start_date'] = this.workStartDate;
    data['work_end_date'] = this.workEndDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_work_time'] = this.totalWorkTime;
    data['hourly_rate'] = this.hourlyRate;
    data['out_of_office_duration'] = this.out_of_office_duration;
    data['out_of_office_payable'] = this.out_of_office_payable;
    data['weekend_payable'] = this.weekend_payable;
    data['holiday_payable'] = this.holiday_payable;
    data['halfday_rate'] = this.halfdayRate;
    data['fullday_rate'] = this.fulldayRate;
    data['monthly_rate'] = this.monthlyRate;
    data['hourly_payable'] = this.hourlyPayable;
    data['overtime_payable'] = this.overtimePayable;
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
    data['address'] = this.address;
    data['engineer_payout_status'] = this.engineerPayoutStatus;
    data['status'] = this.status;
    if (this.workexpense != null) {
      data['workexpense'] = this.workexpense!.map((v) => v.toJson()).toList();
    }
    if (this.ticketWorkNotes != null) {
      data['ticket_work_notes'] = this.ticketWorkNotes!.map((v) => v.toJson()).toList();
    }

    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Method to consolidate all documents into a single list
  List<String> getAllDocuments() {
    return ticketWorkNotes
            ?.where((note) => note.documents != null) // Filter out null document lists
            .expand((note) => note.documents!) // Flatten the lists
            .toList() ??
        [];
  }

  Map<String, dynamic> toStartWorkSaveJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userStore.userId.validate();
    data['ticket_id'] = this.ticketId;
    data['start_time'] = this.startTime;
    data['work_start_date'] = getCurrentDate();
    data['address'] = this.address;
    data['status'] = "in_progress";
    return data;
  }

  Map<String, dynamic> toStartBreakJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_work_id'] = this.workId;
    data['ticket_id'] = this.ticketId;
    data['break_start_date'] = getCurrentDate();
    data['engineer_id'] = userStore.userId.validate();
    data['work_date'] = getCurrentDate();
    data['status'] = "1";
    data['start_time'] = getCurrentTime();
    return data;
  }

  Map<String, dynamic> toEndBreakJson({required int ticketBreakId}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_break_id'] = ticketBreakId;
    data['break_end_date'] = getCurrentDate();
    data['end_time'] = getCurrentTime();
    return data;
  }

  Map<String, dynamic> toNotesJson({
    int? id,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    mainLog(message: this.workId.toString(), label: 'this.workId');
    if (id != null) {
      data['id'] = id;
    }
    data['work_id'] = this.workId;
    data['note'] = ticketStartWorkStore.notesCont.text.trim();
    data['status'] = "1";
    return data;
  }

  Map<String, dynamic> toFoodExpenseJson({required String expenseName, required String expenseCost, int? id}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) {
      data['id'] = id;
    }
    data['ticket_work_id'] = this.workId;
    data['ticket_id'] = this.ticketId;
    data['engineer_id'] = userStore.userId.validate();
    data['expense'] = expenseCost;
    data['name'] = expenseName;
    data['status'] = "1";
    return data;
  }

  Map<String, dynamic> toEndWorkSaveJson({String? status}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_work_id'] = this.workId;
    data['work_end_date'] = getCurrentDate();
    data['end_time'] = getCurrentTime();
    data['status'] = status ?? "hold";
    return data;
  }
}
