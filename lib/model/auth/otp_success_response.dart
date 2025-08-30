class OtpSuccessResponse {
  String? message;
  bool? status;
  int? otp;

  OtpSuccessResponse({
    this.message,
    this.status,
    this.otp,
  });

  OtpSuccessResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['otp'] = this.otp;
    return data;
  }
}
