class Workexpense {
  int? id;
  int? ticketWorkId;
  int? engineerId;
  int? ticketId;
  num? expense;
  String? document;
  String? name;
  int? status;

  Workexpense({this.id, this.ticketWorkId, this.engineerId, this.ticketId, this.name, this.expense, this.document, this.status});

  Workexpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketWorkId = json['ticket_work_id'];
    engineerId = json['engineer_id'];
    ticketId = json['ticket_id'];
    name = json['name'];
    expense = json['expense'];
    document = json['document'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_work_id'] = this.ticketWorkId;
    data['engineer_id'] = this.engineerId;
    data['ticket_id'] = this.ticketId;
    data['expense'] = this.expense;
    data['name'] = this.name;
    data['document'] = this.document;
    data['status'] = this.status;
    return data;
  }
}
