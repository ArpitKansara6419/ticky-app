import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/controller/tickets/ticket_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/ticket_work_response.dart';

part 'ticket_start_work_store.g.dart';

class TicketStartWorkStore = TicketStartWorkStoreBase with _$TicketStartWorkStore;

abstract class TicketStartWorkStoreBase with Store {
  @observable
  TextEditingController timeCont = TextEditingController();

  @observable
  TimeOfDay? startTime;

  @observable
  TextEditingController currentTimeCont = TextEditingController();

  @observable
  String? currentLocation;

  @observable
  GlobalKey<FormState> notesFromState = GlobalKey();

  @observable
  GlobalKey<FormState> expenseFromState = GlobalKey();

  @observable
  TextEditingController notesCont = TextEditingController();

  @observable
  List<File> attachmentFiles = ObservableList();

  @observable
  TextEditingController expenseNameCont = TextEditingController();

  @observable
  TextEditingController expenseCostCont = TextEditingController();

  @observable
  List<File> uploadedFile = ObservableList();

  @observable
  TicketWorkResponse? ticketWorkResponse;

  @action
  Future<void> setAttachmentFiles({required List<File> file}) async {
    attachmentFiles = file;
  }

  @observable
  Future<TicketWorkResponse>? ticketFuture;

  @action
  Future<void> handleTicketFuture({
    required int ticketId,
  }) async {
    ticketFuture = TicketController.ticketDetail(ticketId: ticketId.validate());
    ticketWorkResponse = await ticketFuture;
  }

  @action
  Future<void> refreshTicketDetails({
    required int ticketId,
    double? startLatitude,
    double? startLongitude,
  }) async {
    await handleTicketFuture(ticketId: ticketId);
  }

  @action
  Future<void> ticketStartWork({required TicketWorks data}) async {
    Map<String, dynamic> req = data.toStartWorkSaveJson();

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.startWorkApiState, value: true);
    await TicketController.startWorkApi(req: req).then((value) {
      toast(value.message.validate());
    }).catchError((e) {
      toast(e.toString());
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.startWorkApiState, value: false);
  }

  @action
  Future<void> addBreak({required TicketWorks data}) async {
    Map<String, dynamic> req = data.toStartBreakJson();

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: true);

    await TicketController.addTicketBreakApi(req: req).then((value) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);

      toast(value.message.validate());
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);
      toast(e.toString());
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);
  }

  @action
  Future<void> addNotes({
    required TicketWorks data,
    bool isUpdate = false,
    int? id,
  }) async {
    Map<String, dynamic> req = data.toNotesJson(
      id: id,
    );

// return;
    await TicketController.saveNotesApiMultipart(req: req).then((value) {
      toast(value.message.validate());
      notesCont.clear();
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @action
  Future<void> deleteNotes({
    required int id,
    required int ticketId,
  }) async {
// return;
    await TicketController.deleteNotesApiMultipart(id: id).then((value) {
      toast(value.message.validate());
      handleTicketFuture(ticketId: ticketId);
      // notesCont.clear();
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @action
  Future<void> addFoodExpenses({
    required TicketWorks data,
    int? id,
  }) async {
    Map<String, dynamic> req = data.toFoodExpenseJson(
      expenseName: expenseNameCont.text.trim(),
      expenseCost: expenseCostCont.text.trim(),
      id: id,
    );

    await TicketController.saveFoodExpenseMultipart(req: req, files: ticketStartWorkStore.uploadedFile).then((value) {
      toast(value.message.validate());
      // notesCont.clear();
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @action
  Future<void> deleteFoodExpenses({
    required int id,
    required int ticketId,
  }) async {
    await TicketController.deleteFoodExpense(id: id).then((value) {
      toast(value.message.validate());
      handleTicketFuture(ticketId: ticketId);
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @action
  Future<void> addDocument({required TicketWorks data}) async {
    Map<String, dynamic> req = data.toNotesJson();

    await TicketController.saveNotesApiMultipart(req: req, files: attachmentFiles).then((value) {
      toast(value.message.validate());
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @action
  Future<void> endTicketBreak({required int ticketBreakId, required TicketWorks data}) async {
    Map<String, dynamic> req = data.toEndBreakJson(ticketBreakId: ticketBreakId);

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: true);

    await TicketController.endTicketBreakApi(req: req).then((value) {
      toast(value.message.validate());
    }).catchError((e) {
      toast(e.toString());
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);
  }

  @action
  Future<void> endTicket({required String status, required TicketWorks data}) async {
    Map<String, dynamic> req = data.toEndWorkSaveJson(status: status);

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: true);

    await TicketController.endWorkApi(req: req).then((value) {
      toast(value.message.validate());
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);

      toast(e.toString());
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.breakApiState, value: false);
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
  }
}
