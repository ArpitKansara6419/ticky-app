class EducationData {
  int? id;
  dynamic userId;
  String? degreeName;
  String? universityName;
  String? issueDate;
  List<String>? mediaFiles;
  dynamic status;

  EducationData({this.id, this.userId, this.degreeName, this.universityName, this.issueDate, this.mediaFiles, this.status});

  EducationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    degreeName = json['degree_name'];
    universityName = json['university_name'];
    issueDate = json['issue_date'];
    mediaFiles = json['media_files'] != null ? List<String>.from(json['media_files']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['degree_name'] = this.degreeName;
    data['university_name'] = this.universityName;
    data['issue_date'] = this.issueDate;
    data['media_files'] = this.mediaFiles;
    data['status'] = this.status;
    return data;
  }
}
