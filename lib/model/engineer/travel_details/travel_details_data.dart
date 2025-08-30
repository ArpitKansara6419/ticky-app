class TravelDetailsData {
  String? userId;
  int? drivingLicense;
  int? ownVehicle;
  int? workingRadius;
  List<String>? typeOfVehicle;

  TravelDetailsData({this.userId, this.drivingLicense, this.ownVehicle, this.workingRadius, this.typeOfVehicle});

  TravelDetailsData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    drivingLicense = json['driving_license'];
    ownVehicle = json['own_vehicle'];
    workingRadius = json['working_radius'];
    typeOfVehicle = json['type_of_vehicle'] != null ? List<String>.from(json['type_of_vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['driving_license'] = this.drivingLicense;
    data['own_vehicle'] = this.ownVehicle;
    data['working_radius'] = this.workingRadius;
    data['type_of_vehicle'] = this.typeOfVehicle;
    return data;
  }
}
