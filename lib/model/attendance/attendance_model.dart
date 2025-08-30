import 'package:flutter/material.dart';

class AttendanceModel {
  String? icon;
  String? name;
  DateTime? value;
  Color? color;

  AttendanceModel({this.icon, this.name, this.color, this.value});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    value = json['value'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['color'] = this.color;
    data['value'] = this.value;
    return data;
  }
}
