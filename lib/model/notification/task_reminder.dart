class TaskReminderRequest {
  const TaskReminderRequest({
    required this.userResponse,
    required this.reason,
});

  final String userResponse;
  final String reason;

  Map<String,dynamic> toJson() => {
    'user_response': userResponse,
    'reason': reason,
  };
}

class TaskReminderResponse {
  const TaskReminderResponse({
    required this.status,
    required this.message,
});

  final bool status;
  final String message;

  factory TaskReminderResponse.fromJson(Map<String,dynamic> json) => TaskReminderResponse(
    status: json['status'],
    message: json['message'],
  );

  Map<String,dynamic> toJson() => {
    'status': status,
    'message': message,
  };
}