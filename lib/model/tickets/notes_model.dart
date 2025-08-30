class NotesModel {
  String? message;
  List<NotesData>? notesData;

  NotesModel({this.message, this.notesData});

  NotesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      notesData = <NotesData>[];
      json['data'].forEach((v) {
        notesData!.add(new NotesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.notesData != null) {
      data['data'] = this.notesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotesData {
  int? id;
  String? notes;

  NotesData({this.id, this.notes});

  NotesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['note_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note_content'] = this.notes;
    return data;
  }

  Map<String, dynamic> toSaveJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note_content'] = this.notes;
    return data;
  }
}
