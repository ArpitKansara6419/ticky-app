import 'package:ticky/model/engineer/payments/payment_details_data.dart';

class PaymentDetailsResponse {
  PaymentDetailsData? data;
  bool? success;
  String? message;

  PaymentDetailsResponse({this.data, this.success, this.message});

  PaymentDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PaymentDetailsData.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
