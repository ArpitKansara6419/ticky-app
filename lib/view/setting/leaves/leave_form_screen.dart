import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ag_widgets/ag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:ticky/controller/holiday/holiday_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/holiday/holiday_response.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/range_date_picker_input_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/setting/leaves/widget/leave_pdf_component.dart';
import 'package:ticky/view/setting/leaves/widget/pdf_preview.dart';

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({Key? key}) : super(key: key);

  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  GlobalKey<SfSignaturePadState> employeeSignatureGlobalKey = GlobalKey();
  Uint8List? employeeSignUint8List;
  Uint8List? employerSignUint8List;
  HolidayResponse? holidayResponse;

  @override
  void initState() {
    super.initState();
    init();
    try {} on Exception catch (e) {
      log(e.toString());
    }
  }

  void init() async {
    //
    ByteData data = await rootBundle.load('assets/image-Photoroom.png');
    employerSignUint8List = data.buffer.asUint8List();

    holidayResponse = await HolidayController.getHolidayListApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget _buildLeaveDetailRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: 10),
          Expanded(child: Text(title, style: primaryTextStyle())),
          Text(value, style: primaryTextStyle()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    leaveStore.dispose();
    if (PdfComponents.paidPdfPath != null && PdfComponents.paidPdfPath!.isNotEmpty) {
      File(PdfComponents.paidPdfPath!).delete();
    }
    if (PdfComponents.paidSignedPdfPath != null && PdfComponents.paidSignedPdfPath!.isNotEmpty) {
      File(PdfComponents.paidSignedPdfPath!).delete();
    }
    if (PdfComponents.unpaidPdfPath != null && PdfComponents.unpaidPdfPath!.isNotEmpty) {
      File(PdfComponents.unpaidPdfPath!).delete();
    }
    PdfComponents.paidPdfPath = null;
    PdfComponents.paidSignedPdfPath = null;
    PdfComponents.unpaidPdfPath = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Apply Leave"),
      body: Observer(builder: (context) {
        return appLoaderStore.appLoadingState[AppLoaderStateName.holidayApiState].validate()
            ? Loader(color: primaryColor)
            : Form(
                key: leaveStore.leaveFormState,
                child: SaveButtonWidget(
                  onSubmit: leaveStore.onSubmit,
                  buttonName: "Apply Leave",
                  loader: appLoaderStore.appLoadingState[AppLoaderStateName.applyLeaveApiState].validate(),
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        Container(
                          width: context.width() / 2 - 20,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Color(0xFFdeeced), borderRadius: radius(), border: Border.all(color: Color(0xFF0f7f84))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Leave Balance", style: boldTextStyle(size: 12)),
                              8.height,
                              if (leaveStore.freezeLeave > 0)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${(leaveStore.leaveBalance - leaveStore.freezeLeave) < 0 ? 0 : (leaveStore.leaveBalance - leaveStore.freezeLeave).toStringAsFixed(2)}',
                                      style: boldTextStyle(
                                        color: Color(0xFF0f7f84),
                                        size: 20,
                                      ),
                                    ),
                                    4.width,
                                    Text(
                                      '(${leaveStore.leaveBalance.toStringAsFixed(2)})',
                                      style: boldTextStyle(color: Color(0xFF0f7f84), size: 16),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  leaveStore.leaveBalance.toString(),
                                  style: boldTextStyle(
                                    color: Color(0xFF0f7f84),
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: context.width() / 2 - 20,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Color(0xFFdeeced), borderRadius: radius(), border: Border.all(color: Color(0xFF0f7f84))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Updated Balance", style: boldTextStyle(size: 12)),
                              8.height,
                              Text("${leaveStore.afterLeaveBalance.toStringAsFixed(2)}", style: boldTextStyle(color: Color(0xFF0f7f84), size: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    RangeDatePickerInputWidget(
                      title: "Select Date",
                      onDatePicked: (value) {
                        leaveStore.updateLeaveBalance(value, holidayResponse!.holidayData.validate());
                      },
                      selectedDate: leaveStore.selectedDateTimeRange,
                      controller: leaveStore.dateCont,
                      firstDate: DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()),
                      lastDate: DateTime(DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()).year, 12, 31),
                      selectableDayPredicate: (day, selectedStartDay, selectedEndDay) {
                        // Don’t allow Saturday or Sunday
                        if (formatClockInDateTime(day, format: "EEEE").toLowerCase() == 'saturday' || formatClockInDateTime(day, format: "EEEE").toLowerCase() == 'sunday') {
                          return false;
                        }

                        // If holiday data is not available yet
                        if (holidayResponse == null || holidayResponse!.holidayData == null) {
                          return true; // or false depending on your requirement
                        }

                        // Check if the current day is in the holiday list
                        final formattedDay = DateFormat('yyyy-MM-dd').format(day);
                        final isHoliday = holidayResponse!.holidayData!.any((element) {
                          final holidayDate = element.date ?? '';
                          return formattedDay == holidayDate;
                        });

                        return !isHoliday;
                      },
                      refreshDirectory: () {
                        setState(() {
                          if (PdfComponents.paidPdfPath != null && PdfComponents.paidPdfPath!.isNotEmpty) {
                            File(PdfComponents.paidPdfPath!).delete();
                          }
                          if (PdfComponents.paidSignedPdfPath != null && PdfComponents.paidSignedPdfPath!.isNotEmpty) {
                            File(PdfComponents.paidSignedPdfPath!).delete();
                          }
                          if (PdfComponents.unpaidPdfPath != null && PdfComponents.unpaidPdfPath!.isNotEmpty) {
                            File(PdfComponents.unpaidPdfPath!).delete();
                          }
                          PdfComponents.paidPdfPath = null;
                          PdfComponents.paidSignedPdfPath = null;
                          PdfComponents.unpaidPdfPath = null;
                        });
                      },
                    ),
                    if (leaveStore.unpaidLeave > 0) ...[
                      16.height,
                      TitleFormComponent(
                        text: 'Reason',
                        child: AppTextField(
                          controller: leaveStore.notesCont,
                          textFieldType: TextFieldType.MULTILINE,
                          minLines: 3,
                          validator: (value) {
                            if (value.validate().isEmpty) return errorThisFieldRequired;
                            return null;
                          },
                          focus: leaveStore.notesFocusNode,
                          isValidationRequired: true,
                          decoration: inputDecoration(),
                          errorInvalidUsername: 'Write reason for unpaid leave',
                        ),
                      ),
                    ],
                    16.height,
                    if (leaveStore.startDate != null && leaveStore.endDate != null) ...[
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Leave Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Icon(Icons.calendar_today, color: primaryColor),
                                ],
                              ),
                              Divider(),
                              _buildLeaveDetailRow("Start Date", DateFormat.yMMMd().format(leaveStore.startDate!), Icons.calendar_month),
                              _buildLeaveDetailRow("End Date", DateFormat.yMMMd().format(leaveStore.endDate!), Icons.event),
                              _buildLeaveDetailRow("Total Leave Days", "${leaveStore.totalLeaveDays}", Icons.date_range),
                              if (leaveStore.excludedLeaveDates.isNotEmpty) ...[
                                _buildLeaveDetailRow("Excluded Days", "${leaveStore.excludedLeaveDates.length}", Icons.cancel_outlined),
                                4.height,
                                ...leaveStore.excludedLeaveDates.map((d) {
                                  final isWeekend = d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;
                                  final label = isWeekend ? 'Weekend' : 'Holiday';
                                  return Text(
                                    '${formatDate(d.toString(), outputFormat: ShowDateFormat.ddMmmYyyyEe)} – $label',
                                    style: secondaryTextStyle(size: 12),
                                  ).paddingLeft(30);
                                }).toList(),
                              ],
                              Divider(),
                              _buildLeaveDetailRow("Paid Leave", "${leaveStore.paidLeave}", Icons.check_circle),
                              if (leaveStore.unpaidLeave > 0) _buildLeaveDetailRow("Unpaid Leave", "${leaveStore.unpaidLeave}", Icons.warning),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  if (leaveStore.paidLeave > 0)
                                    PdfComponents.paidPdfPath != null && PdfComponents.paidPdfPath!.isNotEmpty
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: AppButton(
                                                  text: 'View Generated Paid PDF',
                                                  color: Colors.white,
                                                  textColor: primaryColor,
                                                  onTap: () {
                                                    hideKeyboard(context);
                                                    PdfPreviewView(file: File(PdfComponents.paidPdfPath!), fileTitle: 'Paid Leave Document').launch(context);
                                                  },
                                                ),
                                              ),
                                              20.width,
                                              AppSvgIcons.icRegenerate.agLoadImage(height: 22, width: 22).onTap(generatePaidDocument),
                                            ],
                                          )
                                        : AppButton(text: "Generate Paid Leave Documents", width: context.width(), onTap: generatePaidDocument),
                                  if (leaveStore.unpaidLeave > 0) ...[
                                    20.height,
                                    PdfComponents.unpaidPdfPath != null && PdfComponents.unpaidPdfPath!.isNotEmpty
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: AppButton(
                                                  text: 'View Generated Unpaid PDF',
                                                  color: Colors.white,
                                                  textColor: primaryColor,
                                                  onTap: () {
                                                    hideKeyboard(context);
                                                    PdfPreviewView(
                                                      file: File(
                                                        PdfComponents.unpaidPdfPath!,
                                                      ),
                                                      fileTitle: 'Unpaid Leave Document',
                                                    ).launch(context);
                                                  },
                                                ),
                                              ),
                                              20.width,
                                              AppSvgIcons.icRegenerate.agLoadImage(height: 22, width: 22).onTap(generateUnPaidDocument),
                                            ],
                                          )
                                        : AppButton(
                                            text: "Generate Unpaid Leave Documents",
                                            width: context.width(),
                                            onTap: generateUnPaidDocument,
                                          ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
      }),
    );
  }

  void generatePaidDocument() async {
    ///
    PdfNavigation pdfNavigation = PdfNavigation.None;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.75,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Signature Required", style: boldTextStyle()).center(),
              SizedBox(height: 15),
              Text(
                "Before submitting your leave request, please provide your digital signature to confirm",
                textAlign: TextAlign.center,
                style: primaryTextStyle(),
              ).paddingSymmetric(horizontal: 8),
              SizedBox(height: 10),
              Divider(height: 1, thickness: 0.5, color: Colors.grey.shade400),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SfSignaturePad(
                  key: employeeSignatureGlobalKey,
                  backgroundColor: Colors.white,
                  strokeColor: Color(0xFF000F55),
                  minimumStrokeWidth: 1.0,
                  maximumStrokeWidth: 4.0,
                ),
              ),
              SizedBox(height: 10),
              Divider(height: 1, thickness: 0.5, color: Colors.grey.shade400),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        employeeSignatureGlobalKey.currentState?.clear();
                        setState(() {
                          pdfNavigation = PdfNavigation.Clear;
                        });
                      },
                      icon: Icon(Icons.clear, color: Colors.white),
                      label: Text("Clear"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final RenderSignaturePad? renderSignaturePad = employeeSignatureGlobalKey.currentContext?.findRenderObject() as RenderSignaturePad?;

                        Uint8List? localUint8List;
                        ui.Image? uiImage;

                        if (renderSignaturePad != null) {
                          uiImage = await renderSignaturePad.toImage(pixelRatio: 3.0);
                          final ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
                          localUint8List = byteData?.buffer.asUint8List();
                        }

                        if (uiImage != null) {
                          employeeSignUint8List = localUint8List;
                          log('localUint8List => $localUint8List');
                          setState(() {
                            pdfNavigation = PdfNavigation.Save;
                          });
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text("Save"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    pdfNavigation = PdfNavigation.Cancel;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pdfNavigation == PdfNavigation.Save) {
      /// Start Date
      DateTime startDate = leaveStore.paidLeaveDates.isNotEmpty ? leaveStore.paidLeaveDates.first : DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      String startDateString = DateFormat(ShowDateFormat.ddMmmYyyy).format(startDate);

      /// End Date
      DateTime endDate = leaveStore.paidLeaveDates.isNotEmpty ? leaveStore.paidLeaveDates.last : DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      String endDateString = DateFormat(ShowDateFormat.ddMmmYyyy).format(endDate);

      /// Today
      int difference = DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()).difference(startDate).inDays;
      DateTime todayDate = difference > 0 ? startDate : DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      String todayDateString = DateFormat(ShowDateFormat.ddMmmYyyy).format(todayDate);

      await PdfComponents.paidLeavePDF(
        context: context,
        pdfType: PdfType.Signed,
        leaveDetails: LeaveDetails(
          todayDate: todayDateString,
          employeeName: userStore.lastName.validate() + ' ' + userStore.firstName.validate(),
          employerName: 'Aimbot Services',
          day: leaveStore.paidLeaveDates.length.toString(),
          startDate: startDateString,
          endDate: endDateString,
          reason: leaveStore.notesCont.text,
          employeeSignature: employeeSignUint8List,
          employerSignature: employerSignUint8List,
          position: userStore.jobTitle,
          addressOne: 'Aleja Jana Pawla II 43A/37B',
          addressTwo: 'WARSAW , Poland',
        ),
      );

      await PdfComponents.paidLeavePDF(
        context: context,
        pdfType: PdfType.Unsigned,
        leaveDetails: LeaveDetails(
          todayDate: todayDateString,
          employeeName: userStore.lastName.validate() + ' ' + userStore.firstName.validate(),
          employerName: 'Aimbot Services',
          day: leaveStore.paidLeaveDates.length.toString(),
          startDate: startDateString,
          endDate: endDateString,
          reason: leaveStore.notesCont.text,
          employeeSignature: employeeSignUint8List,
          employerSignature: employerSignUint8List,
          position: userStore.jobTitle,
          addressOne: 'Aleja Jana Pawla II 43A/37B',
          addressTwo: 'WARSAW , Poland',
        ),
      );

      //
      if (PdfComponents.paidPdfPath != null && PdfComponents.paidPdfPath!.isNotEmpty) {
        PdfPreviewView(file: File(PdfComponents.paidPdfPath!), fileTitle: 'Paid Leave Document').launch(context);
        leaveStore.paidFiles = File(PdfComponents.paidPdfPath!);
        if (PdfComponents.paidSignedPdfPath != null && PdfComponents.paidSignedPdfPath!.isNotEmpty) {
          leaveStore.paidSignedFiles = File(PdfComponents.paidSignedPdfPath!);
        }
        setState(() {});
      }
    }
  }

  void generateUnPaidDocument() async {
    hideKeyboard(context);
    if (leaveStore.leaveFormState.currentState != null) {
      leaveStore.leaveFormState.currentState!.validate();
    }

    if (leaveStore.notesCont.text.validate().isEmpty) {
      setState(() {});
      return;
    }

    PdfNavigation pdfNavigation = PdfNavigation.None;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.75,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text("Signature Required", style: boldTextStyle())),
              SizedBox(height: 15),
              Text(
                "Before submitting your leave request, please provide your digital signature to confirm",
                textAlign: TextAlign.center,
                style: primaryTextStyle(),
              ).paddingSymmetric(horizontal: 8),
              SizedBox(height: 10),
              Divider(height: 1, thickness: 0.5, color: Colors.grey.shade400),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SfSignaturePad(
                  key: employeeSignatureGlobalKey,
                  backgroundColor: Colors.white,
                  strokeColor: Color(0xFF000F55),
                  minimumStrokeWidth: 1.0,
                  maximumStrokeWidth: 4.0,
                ),
              ),
              SizedBox(height: 10),
              Divider(height: 1, thickness: 0.5, color: Colors.grey.shade400),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        employeeSignatureGlobalKey.currentState?.clear();
                        setState(() {
                          pdfNavigation = PdfNavigation.Clear;
                        });
                      },
                      icon: Icon(Icons.clear, color: Colors.white),
                      label: Text("Clear"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final RenderSignaturePad? renderSignaturePad = employeeSignatureGlobalKey.currentContext?.findRenderObject() as RenderSignaturePad?;

                        Uint8List? localUint8List;
                        ui.Image? uiImage;

                        if (renderSignaturePad != null) {
                          uiImage = await renderSignaturePad.toImage(pixelRatio: 3.0);
                          final ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
                          localUint8List = byteData?.buffer.asUint8List();
                        }

                        if (uiImage != null) {
                          employeeSignUint8List = localUint8List;
                          log('localUint8List => $localUint8List');
                          setState(() {
                            pdfNavigation = PdfNavigation.Save;
                          });
                          // onDrawEnd(uiImage, localUint8List);
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    pdfNavigation = PdfNavigation.Cancel;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pdfNavigation == PdfNavigation.Save) {
      /// Start Date
      DateTime startDate = leaveStore.unpaidLeaveDates.isNotEmpty ? leaveStore.unpaidLeaveDates.first : DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      String startDateString = DateFormat(ShowDateFormat.ddMmmYyyy).format(startDate);

      /// End Date
      DateTime endDate = leaveStore.unpaidLeaveDates.isNotEmpty ? leaveStore.unpaidLeaveDates.last : DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      String endDateString = DateFormat(ShowDateFormat.ddMmmYyyy).format(endDate);

      /// Today
      int difference = DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()).difference(startDate).inDays;
      DateTime todayDate = difference > 0 ? startDate : DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now());
      String todayDateString = DateFormat(ShowDateFormat.ddMmmYyyy).format(todayDate);

      await PdfComponents.unpaidLeavePDF(
        context: context,
        pdfType: PdfType.Unsigned,
        leaveDetails: LeaveDetails(
          todayDate: todayDateString,
          employeeName: userStore.firstName.validate() + ' ' + userStore.lastName.validate(),
          employerName: 'Aimbot Services',
          day: leaveStore.unpaidLeaveDates.length.toString(),
          startDate: startDateString,
          endDate: endDateString,
          reason: leaveStore.notesCont.text,
          employeeSignature: employeeSignUint8List,
          employerSignature: employerSignUint8List,
          position: userStore.jobType,
          addressOne: 'Aleja Jana Pawla II 43A/37B',
          addressTwo: 'WARSAW , Poland',
        ),
      );

      await PdfComponents.unpaidLeavePDF(
        context: context,
        pdfType: PdfType.Signed,
        leaveDetails: LeaveDetails(
          todayDate: todayDateString,
          employeeName: userStore.firstName.validate() + ' ' + userStore.lastName.validate(),
          employerName: 'Aimbot Services',
          day: leaveStore.unpaidLeaveDates.length.toString(),
          startDate: startDateString,
          endDate: endDateString,
          reason: leaveStore.notesCont.text,
          employeeSignature: employeeSignUint8List,
          employerSignature: employerSignUint8List,
          position: userStore.jobType,
          addressOne: 'Aleja Jana Pawla II 43A/37B',
          addressTwo: 'WARSAW , Poland',
        ),
      );
      //
      if (PdfComponents.unpaidPdfPath != null && PdfComponents.unpaidPdfPath!.isNotEmpty) {
        PdfPreviewView(file: File(PdfComponents.unpaidPdfPath!), fileTitle: 'Unpaid Leave Document').launch(context);

        leaveStore.unPaidFiles = File(PdfComponents.unpaidPdfPath!);

        if (PdfComponents.unpaidSignedPdfPath != null && PdfComponents.unpaidSignedPdfPath!.isNotEmpty) {
          leaveStore.unPaidSignedFiles = File(PdfComponents.unpaidSignedPdfPath!);
        }

        setState(() {});
      }
    }
  }
}
