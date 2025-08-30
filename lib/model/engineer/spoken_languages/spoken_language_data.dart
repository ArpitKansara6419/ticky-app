class SpokenLanguageData {
  int? id;
  int? userId;
  String? languageName;
  String? proficiencyLevel;
  int? read;
  int? write;
  int? speak;

  SpokenLanguageData({this.id, this.userId, this.languageName, this.proficiencyLevel, this.read, this.write, this.speak});

  SpokenLanguageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    languageName = json['language_name'];
    proficiencyLevel = json['proficiency_level'];
    read = json['read'];
    write = json['write'];
    speak = json['speak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['language_name'] = this.languageName;
    data['proficiency_level'] = this.proficiencyLevel;
    data['read'] = this.read;
    data['write'] = this.write;
    data['speak'] = this.speak;
    return data;
  }
}
