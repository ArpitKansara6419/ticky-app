import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class AddressComponent extends StatefulWidget {
  const AddressComponent({
    super.key,
    required this.listOfAreaUnderPinCode,
    this.selectedArea,
  });

  final List<String> listOfAreaUnderPinCode;
  final String? selectedArea;

  @override
  State<AddressComponent> createState() => _AddressComponentState();
}

class _AddressComponentState extends State<AddressComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: personalDetailsStore.addressFormState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Text('My Current Address', style: boldTextStyle(size: 18)),
          16.height,
          TitleFormComponent(
            text: 'Apartment',
            child: AppTextField(
              textFieldType: TextFieldType.MULTILINE,
              controller: personalDetailsStore.apartmentCont,
              focus: personalDetailsStore.apartmentFocusNode,
              nextFocus: personalDetailsStore.apartmentOneFocusNode,
              isValidationRequired: false,
              minLines: 1,
              decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Apartment"),
            ),
          ),
          16.height,
          TitleFormComponent(
            text: 'Address Line 1 ',
            child: AppTextField(
              textFieldType: TextFieldType.MULTILINE,
              controller: personalDetailsStore.address1Cont,
              focus: personalDetailsStore.apartmentOneFocusNode,
              nextFocus: personalDetailsStore.apartmentTwoFocusNode,
              minLines: 1,
              decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Address Line 1"),
            ),
          ),
          16.height,
          TitleFormComponent(
            text: 'Address Line 2',
            child: AppTextField(
              textFieldType: TextFieldType.MULTILINE,
              isValidationRequired: false,
              controller: personalDetailsStore.address2Cont,
              focus: personalDetailsStore.apartmentTwoFocusNode,
              nextFocus: personalDetailsStore.zipCodeFocusNode,
              minLines: 1,
              decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Address Line 2"),
            ),
          ),
          16.height,
          Observer(
            builder: (context) => TitleFormComponent(
              text: 'Zip Code',
              child: AppTextField(
                textFieldType: TextFieldType.NAME,
                controller: personalDetailsStore.zipCodeCont,
                focus: personalDetailsStore.zipCodeFocusNode,
                nextFocus: personalDetailsStore.cityFocusNode,
                minLines: 1,
                decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Zip Code"),
              ),
            ),
          ),
          16.height,
          Row(
            children: [
              TitleFormComponent(
                text: 'City',
                child: AppTextField(
                  textFieldType: TextFieldType.MULTILINE,
                  controller: personalDetailsStore.cityCont,
                  focus: personalDetailsStore.cityFocusNode,
                  nextFocus: personalDetailsStore.countryFocusNode,
                  minLines: 1,
                  decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter City"),
                ),
              ).expand(),
              16.width,
              TitleFormComponent(
                text: 'Country',
                child: AppTextField(
                  textFieldType: TextFieldType.MULTILINE,
                  controller: personalDetailsStore.countryCont,
                  focus: personalDetailsStore.countryFocusNode,
                  minLines: 1,
                  decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Country"),
                ),
              ).expand(),
            ],
          ),
          26.height,
          AppButton(
            text: "Save Address",
            width: context.width(),
            onTap: () {
              if (personalDetailsStore.addressFormState.currentState!.validate()) {
                personalDetailsStore.addressFormState.currentState!.save();

                Address address = Address(
                  apartment: personalDetailsStore.apartmentCont.text,
                  addressLine1: personalDetailsStore.address1Cont.text,
                  addressLine2: personalDetailsStore.address2Cont.text,
                  zipcode: personalDetailsStore.zipCodeCont.text,
                  country: personalDetailsStore.countryCont.text,
                  city: personalDetailsStore.cityCont.text,
                );
                finish(context, address);
              }
            },
          ),
          16.height,
          if (isIOS) 16.height,
        ],
      ),
    );
  }
}
