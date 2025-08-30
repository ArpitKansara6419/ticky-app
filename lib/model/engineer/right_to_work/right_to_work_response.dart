class RightToWorkResponse {
  bool? success;
  String? message;
  RightToWorkData? rightToWorkData;

  RightToWorkResponse({this.success, this.message, this.rightToWorkData});

  RightToWorkResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    rightToWorkData = json['data'] != null ? new RightToWorkData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.rightToWorkData != null) {
      data['data'] = this.rightToWorkData!.toJson();
    }
    return data;
  }
}

class RightToWorkData {
  int? userId;
  String? type;
  String? documentType;
  String? documentFile;
  String? universityCertificateFile;
  String? visaCopyFile;
  String? otherName;
  String? issueDate;
  String? expireDate;
  int? status;

  RightToWorkData({this.userId, this.type, this.documentType, this.documentFile, this.universityCertificateFile, this.visaCopyFile, this.otherName, this.issueDate, this.expireDate, this.status});

  RightToWorkData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    documentType = json['document_type'];
    documentFile = json['document_file'];
    universityCertificateFile = json['university_certificate_file'];
    visaCopyFile = json['visa_copy_file'];
    otherName = json['other_name'];
    issueDate = json['issue_date'];
    expireDate = json['expire_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['document_type'] = this.documentType;
    data['document_file'] = this.documentFile;
    data['university_certificate_file'] = this.universityCertificateFile;
    data['visa_copy_file'] = this.visaCopyFile;
    data['other_name'] = this.otherName;
    data['issue_date'] = this.issueDate;
    data['expire_date'] = this.expireDate;
    data['status'] = this.status;
    return data;
  }
}
