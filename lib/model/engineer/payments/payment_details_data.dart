class PaymentDetailsData {
  dynamic userId;
  String? paymentCurrency;
  String? bankName;
  String? bankAddress;
  String? countryOfResidence;
  String? accountNumber;
  String? accountType;
  String? holderName;
  String? personalTaxId;
  String? iban;
  String? swiftCode;
  String? routing;
  String? sortCode;

  PaymentDetailsData({
    this.userId,
    this.paymentCurrency,
    this.bankName,
    this.bankAddress,
    this.countryOfResidence,
    this.accountNumber,
    this.accountType,
    this.holderName,
    this.personalTaxId,
    this.iban,
    this.swiftCode,
    this.routing,
    this.sortCode,
  });

  PaymentDetailsData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    paymentCurrency = json['payment_currency'];
    bankName = json['bank_name'];
    bankAddress = json['bank_address'];
    // countryOfResidence = json['country_of_residence'];
    accountNumber = json['account_number'];
    accountType = json['account_type'];
    holderName = json['holder_name'];
    personalTaxId = json['personal_tax_id'];
    iban = json['iban'];
    swiftCode = json['swift_code'];
    routing = json['routing'];
    sortCode = json['sort_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['payment_currency'] = this.paymentCurrency;
    data['bank_name'] = this.bankName;
    // data['country_of_residence'] = this.countryOfResidence;
    data['bank_address'] = this.bankAddress;
    data['account_number'] = this.accountNumber;
    data['account_type'] = this.accountType;
    data['holder_name'] = this.holderName;
    data['personal_tax_id'] = this.personalTaxId;
    data['iban'] = this.iban;
    data['swift_code'] = this.swiftCode;
    data['routing'] = this.routing;
    data['sort_code'] = this.sortCode;
    return data;
  }
}
