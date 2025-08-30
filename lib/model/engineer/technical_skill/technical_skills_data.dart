class TechnicalSkillData {
  int? id;
  int? userId;
  String? name;
  String? level;

  TechnicalSkillData({this.id, this.userId, this.name, this.level});

  TechnicalSkillData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}
