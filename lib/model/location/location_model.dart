class LocationModel {
  double? latitude;
  double? longitude;
  String? address;
  String? timestamp;

  LocationModel({this.latitude, this.longitude, this.address, this.timestamp});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
