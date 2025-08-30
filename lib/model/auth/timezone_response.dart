class TimezoneResponse {
  bool? status;
  String? message;
  Timezone? zone;

  TimezoneResponse({this.status, this.message, this.zone});

  TimezoneResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    zone = json['data'] != null ?  Timezone.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.zone != null) {
      data['data'] = this.zone!.toJson();
    }
    return data;
  }
}

class Timezone {
  List<Timezones>? timezones;
  String? name;
  String? phoneCode;
  String? iso2;

  Timezone({this.timezones, this.name, this.phoneCode, this.iso2});

  Timezone.fromJson(Map<String, dynamic> json) {
    if (json['timezones'] != null) {
      timezones = <Timezones>[];
      json['timezones'].forEach((v) {
        timezones!.add(new Timezones.fromJson(v));
      });
    }
    name = json['name'];
    phoneCode = json['phone_code'];
    iso2 = json['iso2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezones != null) {
      data['timezones'] = this.timezones!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['phone_code'] = this.phoneCode;
    data['iso2'] = this.iso2;
    return data;
  }
}

class Timezones {
  String? zoneName;
  int? gmtOffset;
  String? gmtOffsetName;
  String? abbreviation;
  String? tzName;

  Timezones({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  Timezones.fromJson(Map<String, dynamic> json) {
    zoneName = json['zoneName'];
    gmtOffset = json['gmtOffset'];
    gmtOffsetName = json['gmtOffsetName'];
    abbreviation = json['abbreviation'];
    tzName = json['tzName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['zoneName'] = zoneName;
    data['gmtOffset'] = gmtOffset;
    data['gmtOffsetName'] = gmtOffsetName;
    data['abbreviation'] = abbreviation;
    data['tzName'] = tzName;
    return data;
  }

  /// Override equality for use in dropdown value matching
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Timezones && other.zoneName == zoneName && other.gmtOffset == gmtOffset && other.gmtOffsetName == gmtOffsetName && other.abbreviation == abbreviation && other.tzName == tzName;
  }

  @override
  int get hashCode {
    return zoneName.hashCode ^ gmtOffset.hashCode ^ gmtOffsetName.hashCode ^ abbreviation.hashCode ^ tzName.hashCode;
  }

  /// Optional: Add copyWith for flexibility
  Timezones copyWith({
    String? zoneName,
    int? gmtOffset,
    String? gmtOffsetName,
    String? abbreviation,
    String? tzName,
  }) {
    return Timezones(
      zoneName: zoneName ?? this.zoneName,
      gmtOffset: gmtOffset ?? this.gmtOffset,
      gmtOffsetName: gmtOffsetName ?? this.gmtOffsetName,
      abbreviation: abbreviation ?? this.abbreviation,
      tzName: tzName ?? this.tzName,
    );
  }
}
