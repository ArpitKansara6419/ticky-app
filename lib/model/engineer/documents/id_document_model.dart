class IdDocumentModel {
  String? name;
  String? value;
  bool? hasExpiry;

  IdDocumentModel({this.name, this.hasExpiry, this.value});

  IdDocumentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    hasExpiry = json['hasExpiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['hasExpiry'] = this.hasExpiry;
    return data;
  }
}

List<IdDocumentModel> getDocumentList() {
  return [
    IdDocumentModel(name: 'Passport', hasExpiry: true, value: "passport"),
    IdDocumentModel(name: 'National ID Card', hasExpiry: true, value: "national_id_card"),
    IdDocumentModel(name: 'Driver’s License', hasExpiry: true, value: "drivers_license"),
    IdDocumentModel(name: 'Visa', hasExpiry: true, value: "visa"),
    IdDocumentModel(name: 'Birth Certificate', hasExpiry: false, value: "birth_certificate"),
    IdDocumentModel(name: 'Refugee Travel Document', hasExpiry: true, value: "refugee_travel_document"),
    IdDocumentModel(name: 'Residence Permit', hasExpiry: true, value: "residence_permit"),
    IdDocumentModel(name: 'Work Permit', hasExpiry: true, value: "work_permit"),
    IdDocumentModel(name: 'Permanent Resident Card (Green Card)', hasExpiry: true, value: "permanent_resident_card"),
    IdDocumentModel(name: 'Health Insurance Card', hasExpiry: true, value: "health_insurance_card"),
    IdDocumentModel(name: 'Vaccination Certificates', hasExpiry: true, value: "vaccination_certificates"),
    IdDocumentModel(name: 'Bank Statement', hasExpiry: false, value: "bank_statement"),
    IdDocumentModel(name: 'Tax Identification Number (TIN)', hasExpiry: false, value: "tax_identification_number"),
    IdDocumentModel(name: 'Diplomas and Transcripts', hasExpiry: false, value: "diplomas_transcripts"),
    IdDocumentModel(name: 'Student ID', hasExpiry: true, value: "student_id"),
    IdDocumentModel(name: 'Marriage Certificate', hasExpiry: false, value: "marriage_certificate"),
    IdDocumentModel(name: 'Divorce Certificate', hasExpiry: false, value: "divorce_certificate"),
  ];
}
