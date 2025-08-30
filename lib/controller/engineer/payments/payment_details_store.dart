import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/payments/payment_detail_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/payments/payment_details_data.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';

part 'payment_details_store.g.dart';

class PaymentDetailsStore = PaymentDetailsStoreBase with _$PaymentDetailsStore;

abstract class PaymentDetailsStoreBase with Store {
  @observable
  GlobalKey<FormState> paymentFormState = GlobalKey();

  @observable
  Currency? currencyValue;

  @observable
  TextEditingController currencyCont = TextEditingController();

  @observable
  TextEditingController bankNameCont = TextEditingController();

  @observable
  AppModel? accountType;

  @action
  void setAccountType(AppModel value) => accountType = value;

  @observable
  TextEditingController nameAssociatedWithBankCont = TextEditingController();

  @observable
  TextEditingController sortCodeCont = TextEditingController();

  @observable
  TextEditingController accountNumberCont = TextEditingController();

  @observable
  TextEditingController bankAddressCont = TextEditingController();

  @observable
  TextEditingController countryOfResidenceCont = TextEditingController();

  @observable
  TextEditingController ibanCont = TextEditingController();

  @observable
  TextEditingController swiftCont = TextEditingController();

  @observable
  TextEditingController routingCont = TextEditingController();

  @observable
  TextEditingController personalTaxIdCont = TextEditingController();

  @observable
  PaymentDetailsData? paymentDetailsData;

  @observable
  FocusNode bankNameFocusNode = FocusNode();

  @observable
  FocusNode nameAssociatedWithBankFocusNode = FocusNode();

  @observable
  FocusNode sortCodeFocusNode = FocusNode();

  @observable
  FocusNode accountNumberFocusNode = FocusNode();

  @observable
  FocusNode bankAddressFocusNode = FocusNode();

  @observable
  FocusNode countryOfResidenceFocusNode = FocusNode();

  @observable
  FocusNode ibanFocusNode = FocusNode();

  @observable
  FocusNode swiftFocusNode = FocusNode();

  @observable
  FocusNode routingFocusNode = FocusNode();

  @observable
  FocusNode personalTaxIdFocusNode = FocusNode();

  void init() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.paymentDetailApiState, value: true);

    await PaymentDetailController.getPaymentDetailListApi().then((value) {
      paymentDetailsData = value.data!;

      if (paymentDetailsData != null) {
        List<AppModel> accountTypeList = getAccountType();

        if (paymentDetailsData!.paymentCurrency.validate().isNotEmpty) {
          currencyCont.text = paymentDetailsData!.paymentCurrency.validate();
        }
        if (paymentDetailsData!.accountType.validate().isNotEmpty) {
          setAccountType(accountTypeList.firstWhere((e) {
            log(e.value);
            return e.value == paymentDetailsData!.accountType.validate();
          }));
        }
        if (paymentDetailsData!.bankName.validate().isNotEmpty) bankNameCont.text = paymentDetailsData!.bankName.validate();
        if (paymentDetailsData!.holderName.validate().isNotEmpty) nameAssociatedWithBankCont.text = paymentDetailsData!.holderName.validate();
        if (paymentDetailsData!.sortCode.validate().isNotEmpty) sortCodeCont.text = paymentDetailsData!.sortCode.validate();
        if (paymentDetailsData!.accountNumber.validate().isNotEmpty) accountNumberCont.text = paymentDetailsData!.accountNumber.validate();
        if (paymentDetailsData!.bankAddress.validate().isNotEmpty) bankAddressCont.text = paymentDetailsData!.bankAddress.validate();
        // if (paymentDetailsData!.countryOfResidence.validate().isNotEmpty) countryOfResidenceCont.text = paymentDetailsData!.countryOfResidence.validate();
        if (paymentDetailsData!.iban.validate().isNotEmpty) ibanCont.text = paymentDetailsData!.iban.validate();
        if (paymentDetailsData!.swiftCode.validate().isNotEmpty) swiftCont.text = paymentDetailsData!.swiftCode.validate();
        if (paymentDetailsData!.routing.validate().isNotEmpty) routingCont.text = paymentDetailsData!.routing.validate();
        if (paymentDetailsData!.personalTaxId.validate().isNotEmpty) personalTaxIdCont.text = paymentDetailsData!.personalTaxId.validate();
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.paymentDetailApiState, value: false);
    });
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.paymentDetailApiState, value: false);
  }

  @observable
  Future<void> onSubmit() async {
    if (paymentFormState.currentState!.validate()) {
      paymentFormState.currentState!.save();
      String paymentCurrency = currencyValue != null ? currencyValue!.code.validate() : paymentDetailsData!.paymentCurrency.validate();

      Map<String, dynamic> request = {
        "user_id": userStore.userId.validate(),
        "payment_currency": paymentCurrency,
        "bank_name": bankNameCont.text.trim(),
        "account_type": accountType?.value.validate(),
        "holder_name": nameAssociatedWithBankCont.text.trim(),
        "sort_code": sortCodeCont.text.trim(),
        "account_number": accountNumberCont.text.trim(),
        "bank_address": bankAddressCont.text.trim(),
        // "country_of_residence": countryOfResidenceCont.text.trim(),
        "iban": ibanCont.text.trim(),
        "swift_code": swiftCont.text.trim(),
        "routing": routingCont.text.trim(),
        "personal_tax_id": personalTaxIdCont.text.trim(),
      };

      log("Request: ${jsonEncode(request)}");
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.paymentDetailApiState, value: true);

      await PaymentDetailController.addPaymentDetailApi(request: request).then((res) {
        toast(res.message.validate());

        finish(getContext);
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.paymentDetailApiState, value: false);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.paymentDetailApiState, value: false);
        toast(e.toString(), print: true);
      });
    }
  }

  void dispose() {
    currencyValue = null;
    currencyCont.clear();
    bankNameCont.clear();
    nameAssociatedWithBankCont.clear();
    sortCodeCont.clear();
    accountNumberCont.clear();
    bankAddressCont.clear();
    // countryOfResidenceCont.clear();
    ibanCont.clear();
    swiftCont.clear();
    routingCont.clear();
    personalTaxIdCont.clear();
  }
}
