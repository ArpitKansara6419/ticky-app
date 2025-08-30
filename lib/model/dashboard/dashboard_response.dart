import 'package:ticky/model/tickets/ticket_data.dart';

class DashboardResponse {
  bool? success;
  String? message;
  DashboardData? dashboardData;

  DashboardResponse({this.success, this.message, this.dashboardData});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    dashboardData = json['data'] != null ? new DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.dashboardData != null) {
      data['data'] = this.dashboardData!.toJson();
    }
    return data;
  }
}

class DashboardData {
  Dashboard? dashboard;

  DashboardData({this.dashboard});

  DashboardData.fromJson(Map<String, dynamic> json) {
    dashboard = json['dashboard'] != null ? new Dashboard.fromJson(json['dashboard']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.toJson();
    }
    return data;
  }
}

class Dashboard {
  Overview? overview;
  List<WeeklyData>? weeklyData;
  List<TicketData>? tickets;

  Dashboard({this.overview, this.weeklyData, this.tickets});

  Dashboard.fromJson(Map<String, dynamic> json) {
    overview = json['overview'] != null ? new Overview.fromJson(json['overview']) : null;
    if (json['weeklyData'] != null) {
      weeklyData = <WeeklyData>[];
      json['weeklyData'].forEach((v) {
        weeklyData!.add(new WeeklyData.fromJson(v));
      });
    }
    if (json['tickets'] != null) {
      tickets = <TicketData>[];
      json['tickets'].forEach((v) {
        tickets!.add(new TicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overview != null) {
      data['overview'] = this.overview!.toJson();
    }
    if (this.weeklyData != null) {
      data['weeklyData'] = this.weeklyData!.map((v) => v.toJson()).toList();
    }
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Overview {
  num? weeklyTickets;
  num? pendingApprovals;
  num? resolvedTickets;
  num? payout;

  Overview({this.weeklyTickets, this.pendingApprovals, this.resolvedTickets, this.payout});

  Overview.fromJson(Map<String, dynamic> json) {
    weeklyTickets = json['monthly_tickets'];
    pendingApprovals = json['pending_approvals'];
    resolvedTickets = json['resolved_tickets'];
    payout = json['payouts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekly_tickets'] = this.weeklyTickets;
    data['pending_approvals'] = this.pendingApprovals;
    data['resolved_tickets'] = this.resolvedTickets;
    data['payouts'] = this.payout;
    return data;
  }
}

class WeeklyData {
  String? x;
  int? y;

  WeeklyData({this.x, this.y});

  WeeklyData.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
