class TicketWorkNotes {
  int? id;
  int? workId;
  String? note;
  List<String>? documents;

  TicketWorkNotes({this.id, this.workId, this.note, this.documents});

  TicketWorkNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workId = json['work_id'];
    note = json['note'];
    documents = json['documents'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_id'] = this.workId;
    data['note'] = this.note;
    data['documents'] = this.documents;
    return data;
  }
}
