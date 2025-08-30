import 'package:ticky/model/tickets/ticket_data.dart';

class TicketWorkResponse {
  bool? success;
  String? message;
  TicketData? ticketData;

  TicketWorkResponse({this.success, this.message, this.ticketData});

  TicketWorkResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    ticketData = json['data'] != null ? TicketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.ticketData != null) data['data'] = this.ticketData!.toJson();
    return data;
  }
}
