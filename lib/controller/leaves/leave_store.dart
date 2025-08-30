import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/leaves/leaves_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/holiday/holiday_data.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';

part 'leave_store.g.dart';

class LeaveStore = _LeaveStore with _$LeaveStore;

abstract class _LeaveStore with Store {
  @observable
  GlobalKey<FormState> leaveFormState = GlobalKey();

  @observable
  double leaveBalance = 3.32;

  @observable
  double freezeLeave = 0;

  @observable
  num afterLeaveBalance = 0;

  TextEditingController dateCont = TextEditingController();
  TextEditingController notesCont = TextEditingController();

  @observable
  DateTimeRange? selectedDateTimeRange;

  @observable
  DateTime? startDate;

  @observable
  DateTime? endDate;

  @observable
  num totalLeaveDays = 0;

  @observable
  num paidLeave = 0;

  @observable
  num unpaidLeave = 0;

  @observable
  List<DateTime> paidLeaveDates = [];

  @observable
  List<DateTime> unpaidLeaveDates = [];

  @observable
  List<DateTime> excludedLeaveDates = [];

  @observable
  File? paidFiles;

  @observable
  File? unPaidFiles;

  @observable
  File? paidSignedFiles;

  @observable
  File? unPaidSignedFiles;

  @observable
  FocusNode notesFocusNode = FocusNode();

  @action
  void updateLeaveBalance(DateTimeRange? date, List<HolidayData> holidays) {
    if (date != null) {
      paidLeaveDates.clear();
      unpaidLeaveDates.clear();
      excludedLeaveDates.clear();

      selectedDateTimeRange = date;
      startDate = date.start;
      endDate = date.end;
      totalLeaveDays = 0;

      List<DateTime> allLeaveDates = [];

      // Convert holiday strings to DateTime list
      List<DateTime> holidayDates = holidays.where((h) => h.date != null).map((h) => DateTime.parse(h.date!)).toList();

      DateTime tempDate = startDate!;

      while (tempDate.isBefore(endDate!.add(Duration(days: 1)))) {
        final isWeekend = tempDate.weekday == DateTime.saturday || tempDate.weekday == DateTime.sunday;

        final isHoliday = holidayDates.any((holiday) => holiday.year == tempDate.year && holiday.month == tempDate.month && holiday.day == tempDate.day);

        if (!isWeekend && !isHoliday) {
          allLeaveDates.add(tempDate);
        } else {
          excludedLeaveDates.add(tempDate);
        }

        tempDate = tempDate.add(Duration(days: 1));
      }

      totalLeaveDays = allLeaveDates.length;

      // Leave balance check logic
      final availableBalance = leaveBalance - leaveStore.freezeLeave;

      if (availableBalance > 0) {
        if (totalLeaveDays <= availableBalance.toInt()) {
          paidLeave = totalLeaveDays;
          unpaidLeave = 0;
          paidLeaveDates.addAll(allLeaveDates);
        } else {
          paidLeave = availableBalance.toInt();
          unpaidLeave = totalLeaveDays - paidLeave;
          paidLeaveDates.addAll(allLeaveDates.take(paidLeave.toInt()));
          unpaidLeaveDates.addAll(allLeaveDates.skip(paidLeave.toInt()));
        }
      } else {
        paidLeave = 0;
        unpaidLeave = totalLeaveDays;
        unpaidLeaveDates.addAll(allLeaveDates);
      }

      afterLeaveBalance = availableBalance - paidLeave;

      // Store excluded dates so you can show them in the UI
      this.excludedLeaveDates = excludedLeaveDates;
    }
  }

  @action
  Future<void> onSubmit() async {
    if (leaveFormState.currentState!.validate()) {
      leaveFormState.currentState!.save();

      hideKeyboard(getContext);
      if (paidLeaveDates.isNotEmpty && paidFiles == null && unpaidLeaveDates.isNotEmpty && unPaidFiles == null) {
        toast('Both Paid and Unpaid Leave documents are required.');
        return;
      } else if (paidLeaveDates.isNotEmpty && paidFiles == null) {
        toast('Paid Leave document is required.');
        return;
      } else if (unpaidLeaveDates.isNotEmpty && unPaidFiles == null) {
        toast('Unpaid Leave document is required.');
        return;
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.applyLeaveApiState, value: true);

      if (paidLeaveDates.isNotEmpty) {
        String paidFromDate = formatDate(DateTimeUtils.convertDateTimeToUTC(dateTime: paidLeaveDates.first).toString(), outputFormat: ShowDateFormat.apiCallingDate);
        String paidToDate = formatDate(DateTimeUtils.convertDateTimeToUTC(dateTime: paidLeaveDates.last).toString(), outputFormat: ShowDateFormat.apiCallingDate);

        Map<String, dynamic> requestPaidLeave = {
          "engineer_id": userStore.userId.validate(),
          "paid_from_date": paidFromDate,
          "paid_to_date": paidToDate,
          "paid_leave_days": paidLeaveDates.length,
          "leave_approve_status": 0,
          "status": 1,
        };

        await LeavesController.applyLeaveApiMultipart(
          request: requestPaidLeave,
          paidDocument: paidFiles,
          paidSignedDocument: paidSignedFiles,
          isPop: unpaidLeaveDates.isEmpty,
        ).then((res) {
          toast(res.message.validate());
        }).catchError((e) {
          appLoaderStore.setLoaderValue(appState: AppLoaderStateName.applyLeaveApiState, value: false);
          toast(e.toString(), print: true);
        });
      }

      if (unpaidLeaveDates.isNotEmpty) {
        ///
        String unpaidFromDate = formatDate(DateTimeUtils.convertDateTimeToUTC(dateTime: unpaidLeaveDates.first).toString(), outputFormat: ShowDateFormat.apiCallingDate);
        String unpaidToDate = formatDate(DateTimeUtils.convertDateTimeToUTC(dateTime: unpaidLeaveDates.last).toString(), outputFormat: ShowDateFormat.apiCallingDate);

        Map<String, dynamic> requestUnpaidLeave = {
          "engineer_id": userStore.userId.validate(),
          "unpaid_from_date": unpaidFromDate,
          "unpaid_to_date": unpaidToDate,
          "unpaid_leave_days": unpaidLeaveDates.length,
          "unpaid_reason": notesCont.text.validate(),
          "leave_approve_status": 0,
          "status": 1,
        };

        await LeavesController.applyLeaveApiMultipart(
          request: requestUnpaidLeave,
          unpaidDocument: unPaidFiles,
          unpaidSignedDocument: unPaidSignedFiles,
        ).then((res) {
          toast(res.message.validate());
        }).catchError((e) {
          appLoaderStore.setLoaderValue(appState: AppLoaderStateName.applyLeaveApiState, value: false);
          toast(e.toString(), print: true);
        });
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.applyLeaveApiState, value: false);
    }
  }

  void dispose() {
    dateCont.clear();
    notesCont.clear();
    selectedDateTimeRange = null;
    startDate = null;
    endDate = null;
    totalLeaveDays = 0;
    afterLeaveBalance = 0;
    paidLeave = 0;
    unpaidLeave = 0;
    paidLeaveDates.clear();
    unpaidLeaveDates.clear();
    paidFiles = null;
    unPaidFiles = null;
    excludedLeaveDates.clear();
  }
}
