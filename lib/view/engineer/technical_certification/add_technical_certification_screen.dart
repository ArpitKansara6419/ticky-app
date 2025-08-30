import 'dart:io';

import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/technical_certification/technical_certification_data.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/date_picker_input_widget.dart';
import 'package:ticky/utils/widgets/master_data_dropdown_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';

class AddTechnicalCertificationScreen extends StatefulWidget {
  final TechnicalCertificationData? data;

  const AddTechnicalCertificationScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddTechnicalCertificationScreen> createState() => _AddTechnicalCertificationScreenState();
}

class _AddTechnicalCertificationScreenState extends State<AddTechnicalCertificationScreen> {
  bool isUpdate = false;
  Future<MasterDataResponse>? technicalCertificationListFuture;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isUpdate = widget.data != null;

    if (isUpdate) {
      technicalCertificationStore.setCertificateName(MasterData(value: widget.data!.certificationType.validate()));
      technicalCertificationStore.certificateIdCont.text = widget.data!.certificationId.validate();
      if (widget.data!.issueDate != null) {
        technicalCertificationStore.issueDate = DateTime.parse(widget.data!.issueDate.validate());
        technicalCertificationStore.issueDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(technicalCertificationStore.issueDate!).toString();
      }
      if (widget.data!.expireDate != null) {
        technicalCertificationStore.expireDate = DateTime.parse(widget.data!.expireDate.validate());
        technicalCertificationStore.expireDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(technicalCertificationStore.expireDate!).toString();
      }
      if (widget.data!.certificateFile.validate().isNotEmpty) {
        technicalCertificationStore.setDocumentFiles(file: [File(Config.imageUrl + widget.data!.certificateFile.validate())]);
        technicalCertificationStore.fileUploadCont.text = "1" + " File(s) Selected";
      }
    }

    technicalCertificationListFuture = MasterDataController.getTechnicalCertificationListApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    technicalCertificationStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget((isUpdate ? "Update" : "Add") + " Technical Certification"),
      body: Observer(builder: (context) {
        return AppScaffoldWithLoader(
          isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.addTechnicalCertificateApiState].validate(),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: technicalCertificationStore.technicalCertificationFormState,
            child: SaveButtonWidget(
              buttonName: isUpdate ? "Update Certification" : "Save Certification",
              onSubmit: () {
                hideKeyboard(context);
                if (isUpdate) {
                  technicalCertificationStore.onUpdate(id: widget.data!.id.validate());
                } else {
                  technicalCertificationStore.onSubmit();
                }
              },
              children: [
                ScreenTitleWidget(
                  isUpdate ? "Update Your Certification Information" : "Add Your Technical Certification",
                ),
                ScreenSubTitleWidget(
                  isUpdate ? "Modify or add new certifications to keep your profile up-to-date." : "Provide details about your certifications to highlight your professional qualifications.",
                ),
                16.height,
                TitleFormComponent(
                  text: 'Select certification',
                  child: MasterDataDropdownWidget(
                    future: technicalCertificationListFuture,
                    initialData: technicalCertificationStore.certificateInitialData,
                    initialValue: technicalCertificationStore.certificateName,
                    onChanged: technicalCertificationStore.setCertificateName,
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: 'Certificate ID',
                  child: AppTextField(
                    textFieldType: TextFieldType.OTHER,
                    isValidationRequired: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                    validator: (e) {
                      if (e.validate().isEmpty) return errorThisFieldRequired;

                      return null;
                    },
                    controller: technicalCertificationStore.certificateIdCont,
                    decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Certificate Id"),
                  ),
                ),
                16.height,
                Observer(
                  builder: (context) {
                    return DatePickerInputWidget(
                      title: 'Issue Date',
                      selectedDate: technicalCertificationStore.issueDate,
                      showDateFormat: ShowDateFormat.ddMmmYyyy,
                      lastDate: DateTimeUtils.convertDateTimeToUTC(
                        dateTime: DateTime.now(),
                      ),
                      onDatePicked: (DateTime? value) {
                        if (value != null) {
                          technicalCertificationStore.issueDate = value;
                        }
                      },
                      controller: technicalCertificationStore.issueDateCont,
                    );
                  },
                ),
                16.height,
                Observer(
                  builder: (context) {
                    return DatePickerInputWidget(
                      title: 'Expiry Date',
                      isValidationRequired: true,
                      selectedDate: technicalCertificationStore.expireDate,
                      showDateFormat: ShowDateFormat.ddMmmYyyy,
                      firstDate: DateTimeUtils.convertDateTimeToUTC(
                        dateTime: DateTime.now(),
                      ),
                      lastDate: DateTime(3000),
                      onDatePicked: (DateTime? value) {
                        if (value != null) {
                          technicalCertificationStore.expireDate = value;
                        }
                      },
                      controller: technicalCertificationStore.expireDateCont,
                    );
                  },
                ),
                16.height,
                TitleFormComponent(
                  text: 'Upload certificate',
                  child: Observer(
                    builder: (context) {
                      return AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: technicalCertificationStore.fileUploadCont,
                        isValidationRequired: true,
                        readOnly: true,
                        suffix: FilePickerFunctions.FilePickerPopupMenu(
                          icon: Icons.upload,
                          onFileSelection: (file) async {
                            technicalCertificationStore.setDocumentFiles(
                              file: await file,
                            );
                            if (technicalCertificationStore.recentlyUpdatedFiles.length > 1) {
                              technicalCertificationStore.fileUploadCont.text = technicalCertificationStore.recentlyUpdatedFiles.length.toString() + " File(s) Selected";
                            }
                          },
                        ),
                        decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                      );
                    },
                  ),
                ),
                16.height,
                Observer(
                  builder: (context) {
                    return Wrap(
                      runSpacing: 16,
                      spacing: 8,
                      children: List.generate(
                        technicalCertificationStore.recentlyUpdatedFiles.length,
                        (index) {
                          var data = technicalCertificationStore.recentlyUpdatedFiles[index];
                          if (data.path.contains("http")) {
                            return AgCachedImage(
                              imageUrl: data.path,
                              width: context.width() / 4 - 16,
                              height: 100,
                              backgroundColorList: darkBrightColors,
                              boxFit: BoxFit.cover,
                              isCircle: false,
                            );
                          }
                          return Container(
                            child: Image.file(data, width: context.width() / 4 - 16, height: 100, fit: BoxFit.cover),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
