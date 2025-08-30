import 'package:ticky/model/engineer/payments/payment_details_data.dart';

class AddPaymentDetailResponse {
  PaymentDetailsData? data;
  String? message;

  AddPaymentDetailResponse({this.data, this.message});

  AddPaymentDetailResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PaymentDetailsData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
