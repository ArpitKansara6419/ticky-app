class ProfileCompletionResponse {
  ProfileCompletionData? profileCompletionData;
  bool? success;
  String? message;

  ProfileCompletionResponse({this.profileCompletionData, this.success, this.message});

  ProfileCompletionResponse.fromJson(Map<String, dynamic> json) {
    profileCompletionData = json['data'] != null ? new ProfileCompletionData.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileCompletionData != null) {
      data['data'] = this.profileCompletionData!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
/*

class ProfileCompletionData {
  int? educationDetails;
  int? idDocuments;
  int? rightToWork;
  int? paymentDetails;
  int? personalDetails;

  ProfileCompletionData(
      {this.educationDetails,
        this.idDocuments,
        this.rightToWork,
        this.paymentDetails,
        this.personalDetails});

  ProfileCompletionData.fromJson(Map<String, dynamic> json) {
    educationDetails = json['education_details'];
    idDocuments = json['id_documents'];
    rightToWork = json['right_to_work'];
    paymentDetails = json['payment_details'];
    personalDetails = json['personal_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education_details'] = this.educationDetails;
    data['id_documents'] = this.idDocuments;
    data['right_to_work'] = this.rightToWork;
    data['payment_details'] = this.paymentDetails;
    data['personal_details'] = this.personalDetails;
    return data;
  }
}
*/

class ProfileCompletionData {
  int? personalDetails;
  int? educationDetails;
  int? idDocuments;
  int? rightToWork;
  int? paymentDetails;

  ProfileCompletionData({
    this.personalDetails,
    this.educationDetails,
    this.idDocuments,
    this.rightToWork,
    this.paymentDetails,
  });

  // Factory constructor to create the object from a JSON map
  ProfileCompletionData.fromJson(Map<String, dynamic> json) {
    personalDetails = json['personal_details'];
    educationDetails = json['education_details'];
    idDocuments = json['id_documents'];
    rightToWork = json['right_to_work'];
    paymentDetails = json['payment_details'];
  }

  // Convert the object to JSON format

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personal_details'] = personalDetails;
    data['education_details'] = educationDetails;
    data['id_documents'] = idDocuments;
    data['right_to_work'] = rightToWork;
    data['payment_details'] = paymentDetails;
    return data;
  }

  /// Method to calculate profile completion percentage
  num calculateProfileCompletion() {
    // List of fields to check
    final List<int?> fields = [
      personalDetails,
      educationDetails,
      idDocuments,
      rightToWork,
      paymentDetails,
    ];

    // Count the number of completed fields (value == 1)
    int completedFields = fields.where((value) => value == 1).length;

    // Calculate and return the completion percentage
    return (completedFields / fields.length) * 100;
  }
}
