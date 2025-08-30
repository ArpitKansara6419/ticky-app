import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/custom_check_box_widget.dart';
import 'package:ticky/utils/widgets/date_picker_input_widget.dart';
import 'package:ticky/utils/widgets/form_component_device_based.dart';
import 'package:ticky/utils/widgets/phone_number_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/auth/timezone_dropdown.dart';
import 'package:ticky/view/engineer/personal_details/components/address_component.dart';
import 'package:ticky/view/setting/engineer/mobile_otp_verification_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  Future<MasterDataResponse>? genderListFuture;
  List<String> listOfAreaUnderPinCode = [];
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (personalDetailsStore.genderInitialData == null) {
      genderListFuture = MasterDataController.getGenderListApi();
    }
    personalDetailsStore.init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    personalDetailsStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: commonAppBarWidget("Personal Details"),
      body: Observer(
        builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.personalDataApiState].validate(),
            child: SaveButtonWidget(
              onSubmit: () async {
                await personalDetailsStore.onSubmit();
              },
              children: [
                16.height,
                FormComponentDeviceBased(
                  child1: TitleFormComponent(
                    text: 'First Name',
                    child: AppTextField(
                      cursorHeight: 16,
                      textAlignVertical: TextAlignVertical.center,
                      textFieldType: TextFieldType.NAME,
                      controller: personalDetailsStore.firstNameCont,
                      focus: personalDetailsStore.firstNameFocusNode,
                      nextFocus: personalDetailsStore.lastNameFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  child2: TitleFormComponent(
                    text: 'Last Name',
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: personalDetailsStore.lastNameCont,
                      focus: personalDetailsStore.lastNameFocusNode,
                      nextFocus: personalDetailsStore.phoneNumberFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: 'Email',
                  child: AppTextField(
                    textFieldType: TextFieldType.EMAIL_ENHANCED,
                    readOnly: true,
                    controller: personalDetailsStore.emailNameCont,
                    decoration: inputDecoration(svgImage: AppSvgIcons.icEmail).copyWith(
                      suffixIcon: Observer(builder: (context) => Icon(Icons.verified, color: userStore.isEmailVerified.validate() ? Colors.green : Colors.grey)),
                    ),
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: "Mobile Number",
                  child: Observer(builder: (context) {
                    return PhoneNumberWidget(
                      hint: "Enter Mobile Number",
                      initialCountryCode: personalDetailsStore.countryCode,
                      controller: personalDetailsStore.phoneNumberCont,
                      focusNode: personalDetailsStore.phoneNumberFocusNode,
                      nextFocus: personalDetailsStore.alternateNumberFocusNode,
                      validator: (s) {
                        if (s!.trim().isEmpty) {
                          return errorThisFieldRequired.validate(value: errorThisFieldRequired);
                        }
                        return null;
                      },
                      onInit: (country) {
                        if (country != null) {
                          personalDetailsStore.contactIso = country.code;
                          personalDetailsStore.countryCode = country.dialCode;
                        }
                      },
                      onCountrySelected: (Country country) {
                        personalDetailsStore.countryCode = country.dialCode;
                        personalDetailsStore.contactIso = country.code;
                        personalDetailsStore.getTimezone();
                      },
                      showSuffixIcon: IconButton(
                        icon: Icon(Icons.verified, color: userStore.isPhoneNumberVerified.validate() ? Colors.green : Colors.grey),
                        onPressed: userStore.isPhoneNumberVerified.validate()
                            ? null
                            : () {
                                MobileOtpVerificationScreen(
                                  mobileNumber: personalDetailsStore.phoneNumberCont.text.trim(),
                                  countryCode: personalDetailsStore.countryCode.validate(),
                                ).launch(context);
                              },
                      ),
                    );
                  }),
                ),
                16.height,
                TitleFormComponent(
                  text: 'Alternate Number',
                  child: Observer(builder: (context) {
                    return PhoneNumberWidget(
                      hint: "Enter Alternate Number",
                      initialCountryCode: personalDetailsStore.altCountryCode,
                      controller: personalDetailsStore.alternateNumberCont,
                      focusNode: personalDetailsStore.alternateNumberFocusNode,
                      validator: (s) {
                        if (s!.trim().isEmpty) {
                          return errorThisFieldRequired.validate(value: errorThisFieldRequired);
                        }
                        return null;
                      },
                      onInit: (country) {
                        if (country != null) {
                          personalDetailsStore.alternateContactIso = country.code;
                        }
                      },
                      onCountrySelected: (Country country) {
                        personalDetailsStore.altCountryCode = country.dialCode;
                        personalDetailsStore.alternateContactIso = country.code;
                        setState(() {});
                      },
                    );
                  }),
                ),
                16.height,
                Observer(builder: (context) {
                  return TitleFormComponent(
                    text: "Timezone*",
                    child: Row(
                      children: [
                        if (signupStore.currentTimeZone != null)
                          TimezoneDropdown(
                            timezones: signupStore.currentTimeZone!.timezones.validate(),
                            initialValue: signupStore.selectedTimeZone,
                            onChanged: (p0) {
                              signupStore.setTimezone(p0);
                            },
                          ).expand()
                        else ...[
                          4.height,
                          Text(
                            "Loading Timezone...",
                            style: secondaryTextStyle(size: 12),
                          ),
                          4.height,
                        ],
                        if (appLoaderStore.appLoadingState[AppLoaderStateName.timezoneApiState].validate()) ...[
                          16.width,
                          aimLoader(context, size: 20),
                        ]
                      ],
                    ),
                  );
                }),
                16.height,
                Observer(builder: (context) {
                  return DatePickerInputWidget(
                    title: 'Birthdate',
                    firstDate: DateTime(1900),
                    showDateFormat: "dd MMM, yyyy",
                    selectedDate: personalDetailsStore.birthDate,
                    onDatePicked: (DateTime? value) {
                      personalDetailsStore.birthDate = value;
                      setState(() {});
                    },
                    controller: personalDetailsStore.birthDateCont,
                  );
                }),
                16.height,
                FutureBuilder<MasterDataResponse>(
                  initialData: personalDetailsStore.genderInitialData,
                  future: genderListFuture,
                  builder: (context, snap) {
                    return TitleFormComponent(
                      text: 'Gender',
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: radius()),
                        child: snap.hasData
                            ? Wrap(
                                children: List.generate(
                                  snap.data!.masterDataList.validate().length,
                                  (index) {
                                    MasterData data = snap.data!.masterDataList.validate()[index];
                                    return InkWell(
                                      onTap: () {
                                        personalDetailsStore.setGender(data);
                                      },
                                      child: Container(
                                        width: context.width() / 2 - 17,
                                        padding: EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Observer(
                                              builder: (context) => CustomCheckBoxWidget(isChecked: personalDetailsStore.selectedGenderData?.value.validate() == data.value.validate()),
                                            ),
                                            8.width,
                                            Text(data.label.validate(), style: primaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : snapWidgetHelper(snap, loadingWidget: aimLoader(context, size: 24)),
                      ),
                    );
                  },
                ),
                16.height,
                TitleFormComponent(
                  text: 'Address',
                  child: AppTextField(
                    textFieldType: TextFieldType.MULTILINE,
                    controller: personalDetailsStore.addressCont,
                    minLines: 1,
                    onTap: () async {
                      Address? res = await showModalBottomSheet(
                        scrollControlDisabledMaxHeightRatio: 0.9,
                        // isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: AddressComponent(
                              listOfAreaUnderPinCode: listOfAreaUnderPinCode,
                              selectedArea: selectedCity,
                            ),
                          );
                        },
                      );

                      if (res != null) {
                        personalDetailsStore.addressCont.text = res.toAddressJson();
                      }
                    },
                    readOnly: true,
                    decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Address"),
                  ),
                ),
                16.height,
              ],
            ),
          );
        },
      ),
    );
  }
}
