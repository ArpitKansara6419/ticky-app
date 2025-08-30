// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_start_work_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TicketStartWorkStore on TicketStartWorkStoreBase, Store {
  late final _$timeContAtom = Atom(name: 'TicketStartWorkStoreBase.timeCont', context: context);

  @override
  TextEditingController get timeCont {
    _$timeContAtom.reportRead();
    return super.timeCont;
  }

  @override
  set timeCont(TextEditingController value) {
    _$timeContAtom.reportWrite(value, super.timeCont, () {
      super.timeCont = value;
    });
  }

  late final _$startTimeAtom = Atom(name: 'TicketStartWorkStoreBase.startTime', context: context);

  @override
  TimeOfDay? get startTime {
    _$startTimeAtom.reportRead();
    return super.startTime;
  }

  @override
  set startTime(TimeOfDay? value) {
    _$startTimeAtom.reportWrite(value, super.startTime, () {
      super.startTime = value;
    });
  }

  late final _$currentTimeContAtom = Atom(name: 'TicketStartWorkStoreBase.currentTimeCont', context: context);

  @override
  TextEditingController get currentTimeCont {
    _$currentTimeContAtom.reportRead();
    return super.currentTimeCont;
  }

  @override
  set currentTimeCont(TextEditingController value) {
    _$currentTimeContAtom.reportWrite(value, super.currentTimeCont, () {
      super.currentTimeCont = value;
    });
  }

  late final _$currentLocationAtom = Atom(name: 'TicketStartWorkStoreBase.currentLocation', context: context);

  @override
  String? get currentLocation {
    _$currentLocationAtom.reportRead();
    return super.currentLocation;
  }

  @override
  set currentLocation(String? value) {
    _$currentLocationAtom.reportWrite(value, super.currentLocation, () {
      super.currentLocation = value;
    });
  }

  late final _$notesFromStateAtom = Atom(name: 'TicketStartWorkStoreBase.notesFromState', context: context);

  @override
  GlobalKey<FormState> get notesFromState {
    _$notesFromStateAtom.reportRead();
    return super.notesFromState;
  }

  @override
  set notesFromState(GlobalKey<FormState> value) {
    _$notesFromStateAtom.reportWrite(value, super.notesFromState, () {
      super.notesFromState = value;
    });
  }

  late final _$expenseFromStateAtom = Atom(name: 'TicketStartWorkStoreBase.expenseFromState', context: context);

  @override
  GlobalKey<FormState> get expenseFromState {
    _$expenseFromStateAtom.reportRead();
    return super.expenseFromState;
  }

  @override
  set expenseFromState(GlobalKey<FormState> value) {
    _$expenseFromStateAtom.reportWrite(value, super.expenseFromState, () {
      super.expenseFromState = value;
    });
  }

  late final _$notesContAtom = Atom(name: 'TicketStartWorkStoreBase.notesCont', context: context);

  @override
  TextEditingController get notesCont {
    _$notesContAtom.reportRead();
    return super.notesCont;
  }

  @override
  set notesCont(TextEditingController value) {
    _$notesContAtom.reportWrite(value, super.notesCont, () {
      super.notesCont = value;
    });
  }

  late final _$attachmentFilesAtom = Atom(name: 'TicketStartWorkStoreBase.attachmentFiles', context: context);

  @override
  List<File> get attachmentFiles {
    _$attachmentFilesAtom.reportRead();
    return super.attachmentFiles;
  }

  @override
  set attachmentFiles(List<File> value) {
    _$attachmentFilesAtom.reportWrite(value, super.attachmentFiles, () {
      super.attachmentFiles = value;
    });
  }

  late final _$expenseNameContAtom = Atom(name: 'TicketStartWorkStoreBase.expenseNameCont', context: context);

  @override
  TextEditingController get expenseNameCont {
    _$expenseNameContAtom.reportRead();
    return super.expenseNameCont;
  }

  @override
  set expenseNameCont(TextEditingController value) {
    _$expenseNameContAtom.reportWrite(value, super.expenseNameCont, () {
      super.expenseNameCont = value;
    });
  }

  late final _$expenseCostContAtom = Atom(name: 'TicketStartWorkStoreBase.expenseCostCont', context: context);

  @override
  TextEditingController get expenseCostCont {
    _$expenseCostContAtom.reportRead();
    return super.expenseCostCont;
  }

  @override
  set expenseCostCont(TextEditingController value) {
    _$expenseCostContAtom.reportWrite(value, super.expenseCostCont, () {
      super.expenseCostCont = value;
    });
  }

  late final _$uploadedFileAtom = Atom(name: 'TicketStartWorkStoreBase.uploadedFile', context: context);

  @override
  List<File> get uploadedFile {
    _$uploadedFileAtom.reportRead();
    return super.uploadedFile;
  }

  @override
  set uploadedFile(List<File> value) {
    _$uploadedFileAtom.reportWrite(value, super.uploadedFile, () {
      super.uploadedFile = value;
    });
  }

  late final _$ticketWorkResponseAtom = Atom(name: 'TicketStartWorkStoreBase.ticketWorkResponse', context: context);

  @override
  TicketWorkResponse? get ticketWorkResponse {
    _$ticketWorkResponseAtom.reportRead();
    return super.ticketWorkResponse;
  }

  @override
  set ticketWorkResponse(TicketWorkResponse? value) {
    _$ticketWorkResponseAtom.reportWrite(value, super.ticketWorkResponse, () {
      super.ticketWorkResponse = value;
    });
  }

  late final _$ticketFutureAtom = Atom(name: 'TicketStartWorkStoreBase.ticketFuture', context: context);

  @override
  Future<TicketWorkResponse>? get ticketFuture {
    _$ticketFutureAtom.reportRead();
    return super.ticketFuture;
  }

  @override
  set ticketFuture(Future<TicketWorkResponse>? value) {
    _$ticketFutureAtom.reportWrite(value, super.ticketFuture, () {
      super.ticketFuture = value;
    });
  }

  late final _$setAttachmentFilesAsyncAction = AsyncAction('TicketStartWorkStoreBase.setAttachmentFiles', context: context);

  @override
  Future<void> setAttachmentFiles({required List<File> file}) {
    return _$setAttachmentFilesAsyncAction.run(() => super.setAttachmentFiles(file: file));
  }

  late final _$handleTicketFutureAsyncAction = AsyncAction('TicketStartWorkStoreBase.handleTicketFuture', context: context);

  @override
  Future<void> handleTicketFuture({required int ticketId, double? startLatitude, double? startLongitude}) {
    return _$handleTicketFutureAsyncAction.run(() => super.handleTicketFuture(ticketId: ticketId));
  }

  late final _$refreshTicketDetailsAsyncAction = AsyncAction('TicketStartWorkStoreBase.refreshTicketDetails', context: context);

  @override
  Future<void> refreshTicketDetails({required int ticketId, double? startLatitude, double? startLongitude}) {
    return _$refreshTicketDetailsAsyncAction.run(() => super.refreshTicketDetails(ticketId: ticketId, startLatitude: startLatitude, startLongitude: startLongitude));
  }

  late final _$ticketStartWorkAsyncAction = AsyncAction('TicketStartWorkStoreBase.ticketStartWork', context: context);

  @override
  Future<void> ticketStartWork({required TicketWorks data}) {
    return _$ticketStartWorkAsyncAction.run(() => super.ticketStartWork(data: data));
  }

  late final _$addBreakAsyncAction = AsyncAction('TicketStartWorkStoreBase.addBreak', context: context);

  @override
  Future<void> addBreak({required TicketWorks data}) {
    return _$addBreakAsyncAction.run(() => super.addBreak(data: data));
  }

  late final _$addNotesAsyncAction = AsyncAction('TicketStartWorkStoreBase.addNotes', context: context);

  @override
  Future<void> addNotes({required TicketWorks data, bool isUpdate = false, int? id}) {
    return _$addNotesAsyncAction.run(() => super.addNotes(data: data, isUpdate: isUpdate, id: id));
  }

  late final _$deleteNotesAsyncAction = AsyncAction('TicketStartWorkStoreBase.deleteNotes', context: context);

  @override
  Future<void> deleteNotes({required int id, required int ticketId}) {
    return _$deleteNotesAsyncAction.run(() => super.deleteNotes(id: id, ticketId: ticketId));
  }

  late final _$addFoodExpensesAsyncAction = AsyncAction('TicketStartWorkStoreBase.addFoodExpenses', context: context);

  @override
  Future<void> addFoodExpenses({required TicketWorks data, int? id}) {
    return _$addFoodExpensesAsyncAction.run(() => super.addFoodExpenses(data: data, id: id));
  }

  late final _$deleteFoodExpensesAsyncAction = AsyncAction('TicketStartWorkStoreBase.deleteFoodExpenses', context: context);

  @override
  Future<void> deleteFoodExpenses({required int id, required int ticketId}) {
    return _$deleteFoodExpensesAsyncAction.run(() => super.deleteFoodExpenses(id: id, ticketId: ticketId));
  }

  late final _$addDocumentAsyncAction = AsyncAction('TicketStartWorkStoreBase.addDocument', context: context);

  @override
  Future<void> addDocument({required TicketWorks data}) {
    return _$addDocumentAsyncAction.run(() => super.addDocument(data: data));
  }

  late final _$endTicketBreakAsyncAction = AsyncAction('TicketStartWorkStoreBase.endTicketBreak', context: context);

  @override
  Future<void> endTicketBreak({required int ticketBreakId, required TicketWorks data}) {
    return _$endTicketBreakAsyncAction.run(() => super.endTicketBreak(ticketBreakId: ticketBreakId, data: data));
  }

  late final _$endTicketAsyncAction = AsyncAction('TicketStartWorkStoreBase.endTicket', context: context);

  @override
  Future<void> endTicket({required String status, required TicketWorks data}) {
    return _$endTicketAsyncAction.run(() => super.endTicket(status: status, data: data));
  }

  late final _$disposeAsyncAction = AsyncAction('TicketStartWorkStoreBase.dispose', context: context);

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  @override
  String toString() {
    return '''
timeCont: ${timeCont},
startTime: ${startTime},
currentTimeCont: ${currentTimeCont},
currentLocation: ${currentLocation},
notesFromState: ${notesFromState},
expenseFromState: ${expenseFromState},
notesCont: ${notesCont},
attachmentFiles: ${attachmentFiles},
expenseNameCont: ${expenseNameCont},
expenseCostCont: ${expenseCostCont},
uploadedFile: ${uploadedFile},
ticketWorkResponse: ${ticketWorkResponse},
ticketFuture: ${ticketFuture}
    ''';
  }
}
