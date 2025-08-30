class TechnicalCertificationData {
  int? id;
  int? userId;
  String? certificationType;
  String? certificationId;
  String? certificateFile;
  String? issueDate;
  String? expireDate;
  String? status;

  TechnicalCertificationData({
    this.id,
    this.userId,
    this.certificationType,
    this.certificationId,
    this.certificateFile,
    this.issueDate,
    this.expireDate,
    this.status,
  });

  TechnicalCertificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    certificationType = json['certification_type'];
    certificationId = json['certification_id'];
    certificateFile = json['certificate_file'];
    issueDate = json['issue_date'];
    expireDate = json['expire_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['certification_type'] = this.certificationType;
    data['certification_id'] = this.certificationId;
    data['certificate_file'] = this.certificateFile;
    data['issue_date'] = this.issueDate;
    data['expire_date'] = this.expireDate;
    data['status'] = this.status;
    return data;
  }
}
