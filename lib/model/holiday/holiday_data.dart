class HolidayData {
  int? id;
  String? title;
  String? date;
  String? note;
  int? status;

  HolidayData({this.id, this.title, this.date, this.note, this.status});

  HolidayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['note'] = this.note;
    data['status'] = this.status;
    return data;
  }
}
