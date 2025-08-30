import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/custom_check_box_widget.dart';
import 'package:ticky/utils/widgets/date_picker_input_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';
import 'package:ticky/view/engineer/right_to_work/widgets/common_data_check_box_widget.dart';

class RightToWorkScreen extends StatefulWidget {
  const RightToWorkScreen({Key? key}) : super(key: key);

  @override
  State<RightToWorkScreen> createState() => _RightToWorkScreenState();
}

class _RightToWorkScreenState extends State<RightToWorkScreen> {
  Future<MasterDataResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = MasterDataController.getRightToWorkListApi();
    rightToWorkStore.init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    rightToWorkStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Right to Work"),
      body: Observer(
        builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.rightToWorkApiState].validate(),
            child: Form(
              key: rightToWorkStore.rightToWorkState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SaveButtonWidget(
                onSubmit: rightToWorkStore.onSubmit,
                children: [
                  ScreenTitleWidget("Manage Your Right to Work Details"),
                  ScreenSubTitleWidget("Add, update, or remove your right to work information to keep your profile accurate and compliant"),
                  20.height,
                  FutureBuilder<MasterDataResponse>(
                    initialData: rightToWorkStore.rightToWorkInitialData,
                    future: future,
                    builder: (context, snap) {
                      return TitleFormComponent(
                        text: 'Visa Type',
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: radius()),
                          child: snap.hasData
                              ? CommonDataCheckBoxWidget<MasterData>(
                                  dataList: snap.data!.masterDataList.validate(),
                                  checkBoxBuilder: (isChecked) => CustomCheckBoxWidget(isChecked: isChecked),
                                  isSelected: (data) => rightToWorkStore.rightToWorkSelectedData?.value.validate() == data.value.validate(),
                                  onItemTap: (data) => _handleVisaTypeChange(context, data),
                                  labelExtractor: (data) => data.label.validate(),
                                )
                              : snapWidgetHelper(snap, loadingWidget: aimLoader(context, size: 24)),
                        ),
                      );
                    },
                  ),
                  Observer(
                    builder: (context) {
                      if (rightToWorkStore.rightToWorkSelectedData?.value.validate() == "student") {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleFormComponent(
                              text: 'University Certificate*',
                              child: AppTextField(
                                textFieldType: TextFieldType.NAME,
                                controller: rightToWorkStore.universityCertificateCont,
                                isValidationRequired: true,
                                readOnly: true,
                                // onTap: _handleUniversityClick,
                                suffix: FilePickerFunctions.FilePickerPopupMenu(
                                  onFileSelection: (file) {
                                    _handleUniversityClick(file: file);
                                  },
                                  child: rightToWorkStore.universityCertificateCont.text.isNotEmpty ? Text('ReUpload', style: secondaryTextStyle()) : null,
                                  icon: rightToWorkStore.universityCertificateCont.text.isNotEmpty ? null : Icons.upload,
                                ),
                                decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Upload Document"),
                              ),
                            ).paddingTop(16),
                            if (rightToWorkStore.visaCont.text.isNotEmpty) ...{
                              6.height,
                              ListDocumentWidget(documents: [rightToWorkStore.universityCertificateFile.first.path]),
                            },
                          ],
                        );
                      } else if (rightToWorkStore.rightToWorkSelectedData?.value.validate() == "others") {
                        return TitleFormComponent(
                          text: 'Other Document Name',
                          child: AppTextField(
                            textFieldType: TextFieldType.NAME,
                            controller: rightToWorkStore.otherDocumentCont,
                            minLines: 1,
                            decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                          ),
                        ).paddingTop(16);
                      } else {
                        return Offstage();
                      }
                    },
                  ),
                  16.height,
                  Observer(
                    builder: (context) {
                      return TitleFormComponent(
                        text:
                            '${rightToWorkStore.rightToWorkSelectedData == null ? "" : rightToWorkStore.rightToWorkSelectedData?.label.validate().capitalizeEachWord().replaceAll("_", " ")} Visa / Resident Card*',
                        child: AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: rightToWorkStore.visaCont,
                          isValidationRequired: true,
                          readOnly: true,
                          // onTap: _handleVisaClick,
                          suffix: FilePickerFunctions.FilePickerPopupMenu(
                            onFileSelection: (file) {
                              _handleVisaClick(file: file);
                            },
                            child: rightToWorkStore.visaCont.text.isNotEmpty ? Text('ReUpload', style: secondaryTextStyle()) : null,
                            icon: rightToWorkStore.visaCont.text.isNotEmpty ? null : Icons.upload,
                          ),
                          // IconButton(
                          //   onPressed: _handleVisaClick,
                          //   icon: rightToWorkStore.visaCont.text.isNotEmpty ? Text('ReUpload', style: secondaryTextStyle()) : Icon(Icons.upload),
                          // ),
                          decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Upload Document"),
                        ),
                      );
                    },
                  ),
                  if (rightToWorkStore.visaCont.text.isNotEmpty) ...{
                    6.height,
                    ListDocumentWidget(documents: [rightToWorkStore.visaFile.first.path]),
                  },
                  16.height,
                  Observer(
                    builder: (context) {
                      if (rightToWorkStore.rightToWorkSelectedData?.value.validate() != "others") {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Observer(
                              builder: (context) {
                                return DatePickerInputWidget(
                                  title: 'Issue Date*',
                                  selectedDate: rightToWorkStore.issueDate,
                                  showDateFormat: ShowDateFormat.ddMmmYyyy,
                                  lastDate: DateTimeUtils.convertDateTimeToUTC(
                                    dateTime: DateTime.now(),
                                  ),
                                  onDatePicked: (DateTime? value) {
                                    if (value != null) {
                                      rightToWorkStore.issueDate = value;
                                    }
                                  },
                                  controller: rightToWorkStore.issueDateCont,
                                );
                              },
                            ),
                            16.height,
                            Observer(
                              builder: (context) {
                                return DatePickerInputWidget(
                                  title: 'Expiry Date*',
                                  selectedDate: rightToWorkStore.expireDate,
                                  showDateFormat: ShowDateFormat.ddMmmYyyy,
                                  firstDate: DateTimeUtils.convertDateTimeToUTC(
                                    dateTime: DateTime.now(),
                                  ),
                                  lastDate: DateTime(3000),
                                  onDatePicked: (DateTime? value) {
                                    if (value != null) {
                                      rightToWorkStore.expireDate = value;
                                    }
                                  },
                                  controller: rightToWorkStore.expireDateCont,
                                );
                              },
                            ),
                            if (rightToWorkStore.expireDate.toString().validate().isNotEmpty) ...{
                              8.height,
                              Text(
                                '${daysLeftForExpiry(rightToWorkStore.expireDate.toString().validate())}',
                                style: secondaryTextStyle(color: context.theme.colorScheme.error, size: 12),
                              ),
                            }
                          ],
                        );
                      } else
                        return Offstage();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleVisaTypeChange(BuildContext context, MasterData data) {
    if (rightToWorkStore.isDataAlreadyAvailable) {
      _showVisaChangeConfirmationDialog(context, data);
    } else {
      _updateVisaType(data);
    }
  }

  void _showVisaChangeConfirmationDialog(BuildContext context, MasterData data) {
    showConfirmDialog(
      context,
      "Confirm Visa Type Change\n\n"
      "You are about to change your visa type. All previously entered details will be cleared.\n\n"
      "Do you want to proceed?",
      onAccept: () {
        _clearPreviousData();
        _updateVisaType(data);
      },
    );
  }

  void _clearPreviousData() {
    rightToWorkStore.isDataAlreadyAvailable = false;

    rightToWorkStore.universityCertificateFile.clear();
    rightToWorkStore.universityCertificateCont.clear();

    rightToWorkStore.visaFile.clear();
    rightToWorkStore.visaCont.clear();

    rightToWorkStore.issueDate = null;
    rightToWorkStore.issueDateCont.clear();
    rightToWorkStore.expireDate = null;
    rightToWorkStore.expireDateCont.clear();
  }

  void _updateVisaType(MasterData data) {
    rightToWorkStore.setRightToWorkSelectedData(data);
    setState(() {});
  }

  _handleUniversityClick({
    required List<File> file,
  }) async {
    if (rightToWorkStore.universityCertificateCont.text.isNotEmpty) {
      showConfirmDialogCustom(
        context,
        primaryColor: context.primaryColor,
        title: "Confirm Document Reupload",
        positiveText: "Reuplaod",
        subTitle: "You are about to replace the existing document. The current file will be permanently deleted and replaced with the new one. Do you wish to proceed?",
        onAccept: (p0) {
          rightToWorkStore.universityCertificateFile.clear();
          rightToWorkStore.universityCertificateCont.clear();
        },
      );

      return;
    }
    rightToWorkStore.setUniversityCertificateFiles(await file);

    if (rightToWorkStore.universityCertificateFile.length > 0) {
      rightToWorkStore.universityCertificateCont.text = "1" + " File Selected";
    }
  }

  _handleVisaClick({
    required List<File> file,
  }) async {
    if (rightToWorkStore.visaCont.text.isNotEmpty) {
      showConfirmDialogCustom(
        context,
        primaryColor: context.primaryColor,
        title: "Confirm Document Reupload",
        positiveText: "Reuplaod",
        subTitle: "You are about to replace the existing document. The current file will be permanently deleted and replaced with the new one. Do you wish to proceed?",
        onAccept: (p0) {
          rightToWorkStore.visaFile.clear();
          rightToWorkStore.visaCont.clear();
        },
      );

      return;
    }

    if (rightToWorkStore.rightToWorkSelectedData == null) {
      toast("Please Select the Visa Type First");
      return;
    }

    rightToWorkStore.setVisaFiles(await file);

    if (rightToWorkStore.visaFile.length > 0) {
      rightToWorkStore.visaCont.text = "1" + " File Selected";
    }
  }
}
