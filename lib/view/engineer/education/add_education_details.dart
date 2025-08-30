import 'dart:io';

import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/education/education_data.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/date_picker_input_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class AddEducationDetails extends StatefulWidget {
  final EducationData? data;

  const AddEducationDetails({Key? key, this.data}) : super(key: key);

  @override
  State<AddEducationDetails> createState() => _AddEducationDetailsState();
}

class _AddEducationDetailsState extends State<AddEducationDetails> {
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isUpdate = widget.data != null;
    if (isUpdate) {
      log(widget.data?.toJson());
      educationStore.nameOfDegreeCont.text = widget.data!.degreeName.validate();
      educationStore.universityNameCont.text = widget.data!.universityName.validate();
      if (widget.data!.issueDate != null) {
        educationStore.issueDate = DateTime.parse(widget.data!.issueDate.validate());
        educationStore.issueDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(educationStore.issueDate!).toString();
      }
      if (widget.data!.mediaFiles.validate().isNotEmpty) {
        educationStore.setEducationFiles(file: widget.data!.mediaFiles!.map((e) => File(Config.imageUrl + e.validate())).toList());
        educationStore.fileUploadCont.text = educationStore.educationFiles.length.toString() + " File(s) Selected";
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    educationStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
        (isUpdate ? "Edit" : "Add") + " Education Details",
        textSize: 16,
      ),
      body: Observer(builder: (context) {
        return AppScaffoldWithLoader(
          isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.addEducationApiState].validate(),
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: educationStore.educationFormState,
            child: SaveButtonWidget(
              buttonName: isUpdate ? "Update Education" : "Save Education",
              onSubmit: () {
                hideKeyboard(context);
                if (isUpdate) {
                  educationStore.onUpdate(id: widget.data!.id.validate());
                } else {
                  educationStore.onSubmit();
                }
              },
              children: [
                Text(isUpdate ? "Update Your Education Information" : 'Add Your Education Information', style: boldTextStyle()),
                Text(isUpdate ? "Modify your education details to keep your profile up-to-date" : 'Provide details about your educational background to complete your profile.',
                    style: secondaryTextStyle()),
                16.height,
                TitleFormComponent(
                  text: 'Name of the Degree*',
                  child: AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: educationStore.nameOfDegreeCont,
                    focus: educationStore.nameOfDegreeFocusNode,
                    nextFocus: educationStore.universityNameFocusNode,
                    decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Degree Name"),
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: 'University Name*',
                  child: AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: educationStore.universityNameCont,
                    focus: educationStore.universityNameFocusNode,
                    decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter University Name"),
                  ),
                ),
                16.height,
                Observer(builder: (context) {
                  return DatePickerInputWidget(
                    title: 'Issue Date*',
                    selectedDate: educationStore.issueDate,
                    showDateFormat: ShowDateFormat.ddMmmYyyy,
                    lastDate: DateTimeUtils.convertDateTimeToUTC(
                      dateTime: DateTime.now(),
                    ),
                    onDatePicked: (DateTime? value) {
                      if (value != null) {
                        educationStore.issueDate = value;
                      }
                    },
                    controller: educationStore.issueDateCont,
                  );
                }),
                16.height,
                TitleFormComponent(
                  text: 'Upload Documents*',
                  child: Observer(
                    builder: (context) {
                      return AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: educationStore.fileUploadCont,
                        isValidationRequired: true,
                        readOnly: true,
                        suffix: FilePickerFunctions.FilePickerPopupMenu(
                          icon: Icons.upload,
                          onFileSelection: (file) async {
                            educationStore.setEducationFiles(file: await file);
                            if (educationStore.educationFiles.length > 0) {
                              educationStore.fileUploadCont.text = educationStore.educationFiles.length.toString() + " File(s) Selected";
                            }
                          },
                        ),
                        decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Select Document"),
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
                        educationStore.educationFiles.length,
                        (index) {
                          var data = educationStore.educationFiles[index];
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
