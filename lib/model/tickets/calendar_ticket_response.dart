import 'package:ticky/model/tickets/ticket_data.dart';

class CalendarTicketResponse {
  bool status;
  Map<String, DateTickets> data;

  CalendarTicketResponse({required this.status, required this.data});

  factory CalendarTicketResponse.fromJson(Map<String, dynamic> json) {
    var dataMap = <String, DateTickets>{};
    json['data'].forEach((key, value) {
      dataMap[key] = DateTickets.fromJson(value);
    });
    return CalendarTicketResponse(
      status: json['status'],
      data: dataMap,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {'status': status};
    data['data'] = this.data.map((key, value) => MapEntry(key, value.toJson()));
    return data;
  }
}

class DateTickets {
  List<TicketData> tickets;
  String? attendanceStatus;
  String? checkIn;
  String? checkout;

  String? breakTime;

  DateTickets({required this.tickets, this.attendanceStatus, this.checkIn, this.checkout, this.breakTime});

  factory DateTickets.fromJson(Map<String, dynamic> json) {
    String? status = json['attendance_status'] as String?;
    String? checkIn = json['check_in'] as String?;
    String? checkout = json['check_out'] as String?;
    String? breakTime = json['break_time'] as String?;
    List list = json['tickets'] as List;
    List<TicketData> ticketsList = list.map((i) => TicketData.fromJson(i)).toList();
    return DateTickets(
      tickets: ticketsList,
      attendanceStatus: status,
      checkIn: checkIn,
      checkout: checkout,
      breakTime: breakTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance_status': attendanceStatus,
      'check_in': checkIn,
      'check_out': checkout,
      'break_time': breakTime,
      'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
    };
  }
}
