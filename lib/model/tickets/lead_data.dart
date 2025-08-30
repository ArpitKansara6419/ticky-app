import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/functions.dart';

class LeadData {
  int? id;
  String? name;
  int? customerId;
  String? leadType;
  String? taskDate;
  String? taskTime;
  String? taskLocation;
  String? scopeOfWork;
  String? rateType;
  num? hourlyRate;
  num? halfDayRate;
  num? fullDayRate;
  num? monthlyRate;
  String? currencyType;
  String? leadStatus;
  String? rescheduleDate;
  num? travelCost;
  num? toolCost;
  String? apartment;
  String? addLine1;
  String? addLine2;
  String? zipcode;
  String? city;
  String? country;
  String? createdAt;
  String? updatedAt;

  LeadData(
      {this.id,
      this.name,
      this.customerId,
      this.leadType,
      this.taskDate,
      this.taskTime,
      this.taskLocation,
      this.scopeOfWork,
      this.rateType,
      this.hourlyRate,
      this.halfDayRate,
      this.fullDayRate,
      this.monthlyRate,
      this.currencyType,
      this.leadStatus,
      this.rescheduleDate,
      this.travelCost,
      this.toolCost,
      this.apartment,
      this.addLine1,
      this.addLine2,
      this.zipcode,
      this.city,
      this.country,
      this.createdAt,
      this.updatedAt});

  LeadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    customerId = json['customer_id'];
    leadType = json['lead_type'];
    taskDate = json['task_date'];
    taskTime = json['task_time'];
    taskLocation = json['task_location'];
    scopeOfWork = json['scope_of_work'];
    rateType = json['rate_type'];
    hourlyRate = json['hourly_rate'];
    halfDayRate = json['half_day_rate'];
    fullDayRate = json['full_day_rate'];
    monthlyRate = json['monthly_rate'];
    currencyType = json['currency_type'].toString().validate().getCurrencyType();
    leadStatus = json['lead_status'];
    rescheduleDate = json['reschedule_date'];
    travelCost = json['travel_cost'];
    toolCost = json['tool_cost'];
    apartment = json['apartment'];
    addLine1 = json['add_line_1'];
    addLine2 = json['add_line_2'];
    zipcode = json['zipcode'];
    city = json['city'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['customer_id'] = this.customerId;
    data['lead_type'] = this.leadType;
    data['task_date'] = this.taskDate;
    data['task_time'] = this.taskTime;
    data['task_location'] = this.taskLocation;
    data['scope_of_work'] = this.scopeOfWork;
    data['rate_type'] = this.rateType;
    data['hourly_rate'] = this.hourlyRate;
    data['half_day_rate'] = this.halfDayRate;
    data['full_day_rate'] = this.fullDayRate;
    data['monthly_rate'] = this.monthlyRate;
    data['currency_type'] = this.currencyType;
    data['lead_status'] = this.leadStatus;
    data['reschedule_date'] = this.rescheduleDate;
    data['travel_cost'] = this.travelCost;
    data['tool_cost'] = this.toolCost;
    data['apartment'] = this.apartment;
    data['add_line_1'] = this.addLine1;
    data['add_line_2'] = this.addLine2;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
