class IndustryExperienceData {
  int? id;
  int? userId;
  String? name;
  String? experience;

  IndustryExperienceData({this.id, this.userId, this.name, this.experience});

  IndustryExperienceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['experience'] = this.experience;
    return data;
  }
}
