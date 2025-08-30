import 'package:nb_utils/nb_utils.dart';

class User {
  int? id;
  String? engineerCode;
  String? name;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? contact;
  String? countryCode;
  String? deviceToken;
  String? contactIso;
  String? alternateContactIso;
  String? timezone;
  String? profileImage;
  String? about;
  String? gender;
  String? alternativeContact;
  String? alternateCountryCode;
  Address? address;
  String? addressText;
  String? birthdate;
  String? jobType;
  String? jobTitle;
  Payrates? payRates;
  Extrapayrates? extraPayRates;
  String? jobStartDate;
  int? emailVerification;
  int? adminVerification;
  int? phoneVerification;
  int? isDeleted;
  int? gdprConsent;

  User(
      {this.id,
      this.engineerCode,
      this.name,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.contact,
      this.deviceToken,
      this.countryCode,
      this.profileImage,
      this.about,
      this.gender,
      this.contactIso,
      this.alternateContactIso,
      this.alternativeContact,
      this.alternateCountryCode,
      this.address,
      this.addressText,
      this.birthdate,
      this.jobType,
      this.jobTitle,
      this.payRates,
      this.extraPayRates,
      this.jobStartDate,
      this.emailVerification,
      this.adminVerification,
      this.phoneVerification,
      this.isDeleted,
      this.timezone,
      this.gdprConsent});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineerCode = json['engineer_code'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    deviceToken = json['device_token'];
    email = json['email'];
    contact = json['contact'];
    countryCode = json['country_code'];
    contactIso = json['contact_iso'];
    alternateContactIso = json['alternate_contact_iso'];
    profileImage = json['profile_image'];
    about = json['about'];
    gender = json['gender'];
    alternativeContact = json['alternative_contact'];
    alternateCountryCode = json['alternate_country_code'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    addressText = json['address_text'];
    birthdate = json['birthdate'];
    jobType = json['job_type'];
    timezone = json['timezone'];
    jobTitle = json['job_title'];
    payRates = json['payrates'] != null ? new Payrates.fromJson(json['payrates']) : null;
    extraPayRates = json['extrapayrates'] != null ? new Extrapayrates.fromJson(json['extrapayrates']) : null;
    jobStartDate = json['job_start_date'];
    emailVerification = json['email_verification'];
    adminVerification = json['admin_verification'];
    phoneVerification = json['phone_verification'];
    isDeleted = json['is_deleted'];
    gdprConsent = json['gdpr_consent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.engineerCode != null) data['engineer_code'] = this.engineerCode;
    if (this.name != null) data['name'] = this.name;
    if (this.firstName != null) data['first_name'] = this.firstName;
    if (this.lastName != null) data['last_name'] = this.lastName;
    if (this.username != null) data['username'] = this.username;
    if (this.email != null) data['email'] = this.email;
    if (this.contact != null) data['contact'] = this.contact;
    if (this.deviceToken != null) data['device_token'] = this.deviceToken;
    if (this.timezone != null) data['timezone'] = this.timezone;
    if (this.countryCode != null) data['country_code'] = this.countryCode;
    if (this.profileImage != null) data['profile_image'] = this.profileImage;
    if (this.about != null) data['about'] = this.about;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.alternativeContact != null) data['alternative_contact'] = this.alternativeContact;
    if (this.alternateCountryCode != null) data['alternate_country_code'] = this.alternateCountryCode;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.contactIso != null) data['contact_iso'] = this.contactIso;
    if (this.alternateContactIso != null) data['alternate_contact_iso'] = this.alternateContactIso;
    if (this.addressText != null) data['address_text'] = this.addressText;
    if (this.birthdate != null) data['birthdate'] = this.birthdate;
    if (this.jobType != null) data['job_type'] = this.jobType;
    if (this.jobTitle != null) data['job_title'] = this.jobTitle;
    if (this.payRates != null) {
      data['payrates'] = this.payRates!.toJson();
    }
    if (this.extraPayRates != null) {
      data['extrapayrates'] = this.extraPayRates!.toJson();
    }
    if (this.jobStartDate != null) data['job_start_date'] = this.jobStartDate;
    if (this.emailVerification != null) data['email_verification'] = this.emailVerification;
    if (this.adminVerification != null) data['admin_verification'] = this.adminVerification;
    if (this.phoneVerification != null) data['phone_verification'] = this.phoneVerification;
    if (this.isDeleted != null) data['is_deleted'] = this.isDeleted;
    if (this.gdprConsent != null) data['gdpr_consent'] = this.gdprConsent;
    return data;
  }
}

class Address {
  String? apartment;
  String? street;
  String? addressLine1;
  String? addressLine2;
  String? zipcode;
  String? city;
  String? country;

  Address({this.apartment, this.street, this.addressLine1, this.addressLine2, this.zipcode, this.city, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    apartment = json['apartment'];
    street = json['street'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    zipcode = json['zipcode'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apartment'] = this.apartment;
    data['street'] = this.street;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }

  String toAddressJson() {
    // Collect all the address parts and validate them
    final parts = [
      apartment,
      street,
      addressLine1,
      addressLine2,
      country,
      city,
      zipcode,
    ].map((e) => e?.validate() ?? '').toList();

    // Join the non-null parts with a delimiter (e.g., ", ")
    return parts.where((e) => e.isNotEmpty).join(', ');
  }
}

class Payrates {
  int? id;
  int? engineerId;
  int? hourlyCharge;
  int? halfDayCharge;
  int? fullDayCharge;
  int? monthlyCharge;
  String? checkInTime;
  String? checkOutTime;
  String? currencyType;
  String? createdAt;
  String? updatedAt;

  Payrates(
      {this.id,
      this.engineerId,
      this.hourlyCharge,
      this.halfDayCharge,
      this.fullDayCharge,
      this.monthlyCharge,
      this.checkInTime,
      this.checkOutTime,
      this.currencyType,
      this.createdAt,
      this.updatedAt});

  Payrates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineerId = json['engineer_id'];
    hourlyCharge = json['hourly_charge'];
    halfDayCharge = json['half_day_charge'];
    fullDayCharge = json['full_day_charge'];
    monthlyCharge = json['monthly_charge'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    currencyType = json['currency_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['engineer_id'] = this.engineerId;
    data['hourly_charge'] = this.hourlyCharge;
    data['half_day_charge'] = this.halfDayCharge;
    data['full_day_charge'] = this.fullDayCharge;
    data['monthly_charge'] = this.monthlyCharge;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['currency_type'] = this.currencyType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Extrapayrates {
  int? id;
  int? engineerId;
  int? overtime;
  int? outOfOfficeHour;
  int? weekend;
  int? publicHoliday;
  int? status;
  String? createdAt;
  String? updatedAt;

  Extrapayrates({this.id, this.engineerId, this.overtime, this.outOfOfficeHour, this.weekend, this.publicHoliday, this.status, this.createdAt, this.updatedAt});

  Extrapayrates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineerId = json['engineer_id'];
    overtime = json['overtime'];
    outOfOfficeHour = json['out_of_office_hour'];
    weekend = json['weekend'];
    publicHoliday = json['public_holiday'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['engineer_id'] = this.engineerId;
    data['overtime'] = this.overtime;
    data['out_of_office_hour'] = this.outOfOfficeHour;
    data['weekend'] = this.weekend;
    data['public_holiday'] = this.publicHoliday;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
