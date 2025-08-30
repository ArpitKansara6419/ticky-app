import 'dart:io';

import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/documents/document_data.dart';
import 'package:ticky/model/engineer/documents/id_document_model.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/date_picker_input_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class AddDocumentScreen extends StatefulWidget {
  final DocumentData? data;

  const AddDocumentScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  bool isUpdate = false;
  List<IdDocumentModel> getDocumentLists = getDocumentList();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isUpdate = widget.data != null;

    if (isUpdate) {
      documentStore.documentTypeValue = widget.data!.documentType.validate();
      documentStore.issueDate = DateTime.parse(widget.data!.issueDate.validate());
      documentStore.expireDate = DateTime.parse(widget.data!.expiryDate.validate());
      documentStore.issueDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(documentStore.issueDate!).toString();
      documentStore.expireDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(documentStore.expireDate!).toString();
      if (widget.data!.media.validate().isNotEmpty) {
        documentStore.setDocumentFiles(file: widget.data!.media!.map((e) => File(e.validate())).toList());
        documentStore.fileUploadCont.text = documentStore.documentFiles.length.toString() + " File(s) Selected";
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    documentStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget((isUpdate ? "Edit " : "Add") + " Documents Details"),
      body: Observer(
        builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.documentApiState].validate(),
            child: Form(
              key: documentStore.documentFormState,
              child: SaveButtonWidget(
                buttonName: isUpdate ? "Update Document" : "Upload Document",
                onSubmit: () {
                  if (isUpdate) {
                    documentStore.onUpdate(id: widget.data!.id.validate());
                  } else {
                    documentStore.onSubmit();
                  }
                },
                children: [
                  Text(isUpdate ? "Update Document Information" : 'Upload Your Document', style: boldTextStyle()),
                  Text(isUpdate ? "Modify the details or replace the document to ensure accuracy" : 'Provide the necessary documents to complete your profile or application.',
                      style: secondaryTextStyle()),
                  16.height,
                  TitleFormComponent(
                    text: 'Document Type*',
                    child: DropdownButtonFormField<String>(
                      value: documentStore.documentTypeValue,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icIndustryExperience, svgIconColor: Colors.black),
                      hint: Text('Choose', style: secondaryTextStyle(size: 10)),
                      isExpanded: true,
                      validator: (s) {
                        if (s.validate().trim().isEmpty) {
                          return errorThisFieldRequired.validate(value: errorThisFieldRequired);
                        }

                        return null;
                      },
                      items: List.generate(
                        getDocumentLists.length,
                        (index) {
                          IdDocumentModel data = getDocumentLists[index];
                          return DropdownMenuItem<String>(
                            value: data.value.validate(),
                            child: Text(data.name.validate(), style: primaryTextStyle()),
                          );
                        },
                      ),
                      onChanged: documentStore.setIdDocument,
                    ),
                  ),
                  16.height,
                  Observer(
                    builder: (context) {
                      return DatePickerInputWidget(
                        title: 'Issue Date*',
                        selectedDate: documentStore.issueDate,
                        showDateFormat: ShowDateFormat.ddMmmYyyy,
                        lastDate: DateTimeUtils.convertDateTimeToUTC(
                          dateTime: DateTime.now(),
                        ),
                        onDatePicked: (DateTime? value) {
                          if (value != null) {
                            documentStore.issueDate = value;
                          }
                        },
                        controller: documentStore.issueDateCont,
                      );
                    },
                  ),
                  16.height,
                  Observer(
                    builder: (context) {
                      return DatePickerInputWidget(
                        title: 'Expiry Date*',
                        selectedDate: documentStore.expireDate,
                        showDateFormat: ShowDateFormat.ddMmmYyyy,
                        firstDate: DateTimeUtils.convertDateTimeToUTC(
                          dateTime: DateTime.now(),
                        ),
                        lastDate: DateTime(3000),
                        onDatePicked: (DateTime? value) {
                          if (value != null) {
                            documentStore.expireDate = value;
                          }
                        },
                        controller: documentStore.expireDateCont,
                      );
                    },
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Upload Documents*',
                    child: Observer(
                      builder: (context) {
                        return AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: documentStore.fileUploadCont,
                          isValidationRequired: true,
                          readOnly: true,
                          suffix: FilePickerFunctions.FilePickerPopupMenu(
                            isAllowMultiple: true,
                            icon: Icons.upload,
                            onFileSelection: (List<File> file) async {
                              documentStore.setDocumentFiles(file: file);

                              if (documentStore.documentFiles.length > 0) {
                                documentStore.fileUploadCont.text = documentStore.documentFiles.length.toString() + " File(s) Selected";
                              }
                            },
                          ),
                          /*suffix: IconButton(
                            onPressed: () async {
                              documentStore.setDocumentFiles(file: await FilePickerFunctions.getMultipleFile());

                              if (documentStore.documentFiles.length > 0) {
                                documentStore.fileUploadCont.text = documentStore.documentFiles.length.toString() + " File(s) Selected";
                              }
                            },
                            icon: Icon(Icons.upload),
                          ),*/
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
                          documentStore.documentFiles.length,
                          (index) {
                            var data = documentStore.documentFiles[index];
                            if (data.path.contains("http")) {
                              return AgCachedImage(
                                imageUrl: data.path,
                                width: context.width() / 4 - 16,
                                height: 100,
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
        },
      ),
    );
  }
}
