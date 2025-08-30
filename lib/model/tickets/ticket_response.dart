import 'package:ticky/model/tickets/ticket_data.dart';

class TicketListResponse {
  List<TicketData>? ticketData;

  TicketListResponse({this.ticketData});

  TicketListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      ticketData = <TicketData>[];
      json['data'].forEach((v) {
        ticketData!.add(new TicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ticketData != null) {
      data['data'] = this.ticketData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
