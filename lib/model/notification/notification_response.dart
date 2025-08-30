class NotificationResponse {
  bool? status;
  int? total;
  int? totalUnseen;
  String? message;
  List<NotificationData>? notificationData;

  NotificationResponse({
    this.status,
    this.total,
    this.totalUnseen,
    this.message,
    this.notificationData,
  });

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool? ?? false;
    total = json['total'];
    totalUnseen = json['total_unseen'];
    message = json['message'];
    if (json['data'] != null) {
      notificationData = <NotificationData>[];
      json['data'].forEach((v) {
        notificationData!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total'] = this.total;
    data['total_unseen'] = this.totalUnseen;
    data['message'] = this.message;
    if (this.notificationData != null) {
      data['data'] = this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  int? engineerId;
  String? title;
  String? body;
  String? notificationType;
  ResponseAdditionalData? responseAdditionalData;
  Null seenAt;
  int? isSeen;
  String? createdAt;

  NotificationData({this.id, this.engineerId, this.title, this.body, this.notificationType, this.responseAdditionalData, this.seenAt, this.isSeen, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineerId = json['engineer_id'];
    title = json['title'];
    body = json['body'];
    notificationType = json['notification_type'];
    responseAdditionalData = json['response_additional_data'] != null ? new ResponseAdditionalData.fromJson(json['response_additional_data']) : null;
    seenAt = json['seen_at'];
    isSeen = json['is_seen'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['engineer_id'] = this.engineerId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['notification_type'] = this.notificationType;
    if (this.responseAdditionalData != null) {
      data['response_additional_data'] = this.responseAdditionalData!.toJson();
    }
    data['seen_at'] = this.seenAt;
    data['is_seen'] = this.isSeen;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ResponseAdditionalData {
  String? ticketId;
  String? ticketCode;
  String? notifyType;
  String? taskID;

  ResponseAdditionalData({this.ticketId, this.ticketCode, this.notifyType ,this.taskID});

  ResponseAdditionalData.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'].toString();
    ticketCode = json['ticket_code'];
    notifyType = json['notify_type'];
    taskID = json['task_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_code'] = this.ticketCode;
    data['notify_type'] = this.notifyType;
    data['task_id'] = this.taskID;
    return data;
  }
}
