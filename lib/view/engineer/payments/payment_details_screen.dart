import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/custom_check_box_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';
import 'package:ticky/view/engineer/payments/components/AccountNumberFormatter.dart';
import 'package:ticky/view/engineer/payments/components/IBANFormatter.dart';

import '../../../utils/widgets/save_button_widget.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  List<AppModel> accountTypeList = getAccountType();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    paymentDetailsStore.init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    paymentDetailsStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Payment Details"),
      body: Observer(
        builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.paymentDetailApiState].validate(),
            child: Form(
              key: paymentDetailsStore.paymentFormState,
              child: SaveButtonWidget(
                buttonName: "Save Payment Details",
                onSubmit: () {
                  hideKeyboard(context);
                  paymentDetailsStore.onSubmit();
                },
                children: [
                  ScreenTitleWidget("Manage Your Payment Details"),
                  ScreenSubTitleWidget("Add, update, or remove payment details to ensure accurate and timely processing"),
                  20.height,
                  TitleFormComponent(
                    text: 'Payment Currency',
                    child: AppTextField(
                      textFieldType: TextFieldType.NUMBER,
                      readOnly: true,
                      controller: paymentDetailsStore.currencyCont,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                      onTap: () async {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (Currency currency) {
                            print('Select currency: ${currency.toJson()}');
                            paymentDetailsStore.currencyValue = currency;
                            paymentDetailsStore.currencyCont.text = currency.code.validate();
                          },
                        );
                      },
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Bank Name',
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: paymentDetailsStore.bankNameCont,
                      focus: paymentDetailsStore.bankNameFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Account Type',
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: radius()),
                      child: Wrap(
                        children: List.generate(
                          accountTypeList.length,
                          (index) {
                            AppModel data = accountTypeList[index];
                            return InkWell(
                              onTap: () {
                                paymentDetailsStore.setAccountType(data);
                              },
                              borderRadius: radius(),
                              child: Container(
                                width: context.width() / 2 - 17,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Observer(
                                      builder: (context) => CustomCheckBoxWidget(isChecked: paymentDetailsStore.accountType?.value == data.value),
                                    ),
                                    8.width,
                                    Text(data.title.validate(), style: primaryTextStyle()),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Name associated with the bank account',
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: paymentDetailsStore.nameAssociatedWithBankCont,
                      focus: paymentDetailsStore.nameAssociatedWithBankFocusNode,
                      nextFocus: paymentDetailsStore.sortCodeFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Sort number - UK accounts only',
                    child: AppTextField(
                      textFieldType: TextFieldType.NUMBER,
                      isValidationRequired: false,
                      controller: paymentDetailsStore.sortCodeCont,
                      focus: paymentDetailsStore.sortCodeFocusNode,
                      nextFocus: paymentDetailsStore.accountNumberFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Sort code"),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Account number',
                    child: AppTextField(
                      textFieldType: TextFieldType.NUMBER,
                      inputFormatters: [
                        AccountNumberFormatter(),
                      ],
                      controller: paymentDetailsStore.accountNumberCont,
                      focus: paymentDetailsStore.accountNumberFocusNode,
                      nextFocus: paymentDetailsStore.bankAddressFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Account Number"),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Bank address',
                    child: AppTextField(
                      minLines: 1,
                      textFieldType: TextFieldType.MULTILINE,
                      isValidationRequired: false,
                      controller: paymentDetailsStore.bankAddressCont,
                      focus: paymentDetailsStore.bankAddressFocusNode,
                      nextFocus: paymentDetailsStore.ibanFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Bank Address"),
                    ),
                  ),
                  16.height,
                  /*                TitleFormComponent(
                    text: 'Country of Residence for the bank account',
                    child: AppTextField(
                      minLines: 1,
                      textFieldType: TextFieldType.OTHER,
                      controller: paymentDetailsStore.countryOfResidenceCont,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  16.height,*/
                  TitleFormComponent(
                    text: 'IBAN (International accounts)',
                    child: AppTextField(
                      minLines: 1,
                      isValidationRequired: false,
                      inputFormatters: [
                        IBANFormatter(),
                      ],
                      textFieldType: TextFieldType.OTHER,
                      controller: paymentDetailsStore.ibanCont,
                      focus: paymentDetailsStore.ibanFocusNode,
                      nextFocus: paymentDetailsStore.swiftFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter IBAN Number"),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'SWIFT/BIC code (International accounts)',
                    child: AppTextField(
                      minLines: 1,
                      isValidationRequired: false,
                      textFieldType: TextFieldType.OTHER,
                      controller: paymentDetailsStore.swiftCont,
                      focus: paymentDetailsStore.swiftFocusNode,
                      nextFocus: paymentDetailsStore.routingFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "SWIFT/BIC code"),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Routing',
                    child: AppTextField(
                      minLines: 1,
                      textFieldType: TextFieldType.OTHER,
                      isValidationRequired: false,
                      controller: paymentDetailsStore.routingCont,
                      focus: paymentDetailsStore.routingFocusNode,
                      nextFocus: paymentDetailsStore.personalTaxIdFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Personal Tax ID',
                    child: AppTextField(
                      minLines: 1,
                      textFieldType: TextFieldType.OTHER,
                      isValidationRequired: false,
                      controller: paymentDetailsStore.personalTaxIdCont,
                      focus: paymentDetailsStore.personalTaxIdFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  16.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
