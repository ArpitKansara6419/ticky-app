class DocumentData {
  int? id;
  var userId;
  String? documentType;
  String? issueDate;
  String? expiryDate;
  var status;
  String? updatedAt;
  String? createdAt;
  List<String>? media;

  DocumentData({
    this.userId,
    this.issueDate,
    this.documentType,
    this.expiryDate,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.media,
  });

  DocumentData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    documentType = json['document_type'];
    status = json['status'];
    issueDate = json['issue_date'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    id = json['id'];
    media = json['media_file'] is List
        ? List<String>.from(json['media_file'])
        : json['media_file'] is String
            ? [json['media_file']]
            : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['document_type'] = this.documentType;
    data['status'] = this.status;
    data['issue_date'] = this.issueDate;
    data['expiry_date'] = this.expiryDate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['media_file'] = this.media;
    return data;
  }
}
