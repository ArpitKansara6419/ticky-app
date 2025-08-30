// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TicketStore on TicketStoreBase, Store {
  late final _$declineFromStateAtom =
      Atom(name: 'TicketStoreBase.declineFromState', context: context);

  @override
  GlobalKey<FormState> get declineFromState {
    _$declineFromStateAtom.reportRead();
    return super.declineFromState;
  }

  @override
  set declineFromState(GlobalKey<FormState> value) {
    _$declineFromStateAtom.reportWrite(value, super.declineFromState, () {
      super.declineFromState = value;
    });
  }

  late final _$declineContAtom =
      Atom(name: 'TicketStoreBase.declineCont', context: context);

  @override
  TextEditingController get declineCont {
    _$declineContAtom.reportRead();
    return super.declineCont;
  }

  @override
  set declineCont(TextEditingController value) {
    _$declineContAtom.reportWrite(value, super.declineCont, () {
      super.declineCont = value;
    });
  }

  late final _$ticketCodeAtom =
      Atom(name: 'TicketStoreBase.ticketCode', context: context);

  @override
  String? get ticketCode {
    _$ticketCodeAtom.reportRead();
    return super.ticketCode;
  }

  @override
  set ticketCode(String? value) {
    _$ticketCodeAtom.reportWrite(value, super.ticketCode, () {
      super.ticketCode = value;
    });
  }

  late final _$ticketIDAtom =
      Atom(name: 'TicketStoreBase.ticketID', context: context);

  @override
  String? get ticketID {
    _$ticketIDAtom.reportRead();
    return super.ticketID;
  }

  @override
  set ticketID(String? value) {
    _$ticketIDAtom.reportWrite(value, super.ticketID, () {
      super.ticketID = value;
    });
  }

  late final _$updateTicketStatusAsyncAction =
      AsyncAction('TicketStoreBase.updateTicketStatus', context: context);

  @override
  Future<void> updateTicketStatus(
      {required int ticketId, required String? status}) {
    return _$updateTicketStatusAsyncAction.run(
        () => super.updateTicketStatus(ticketId: ticketId, status: status));
  }

  late final _$disposeAsyncAction =
      AsyncAction('TicketStoreBase.dispose', context: context);

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  late final _$TicketStoreBaseActionController =
      ActionController(name: 'TicketStoreBase', context: context);

  @override
  void assignTicketCodeAndID(
      {required String? ticketCodeTemp, required String? ticketIDTemp}) {
    final _$actionInfo = _$TicketStoreBaseActionController.startAction(
        name: 'TicketStoreBase.assignTicketCodeAndID');
    try {
      return super.assignTicketCodeAndID(
          ticketCodeTemp: ticketCodeTemp, ticketIDTemp: ticketIDTemp);
    } finally {
      _$TicketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentStatusIndex(int value) {
    final _$actionInfo = _$TicketStoreBaseActionController.startAction(
        name: 'TicketStoreBase.setCurrentStatusIndex');
    try {
      return super.setCurrentStatusIndex(value);
    } finally {
      _$TicketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
declineFromState: ${declineFromState},
declineCont: ${declineCont},
ticketCode: ${ticketCode},
ticketID: ${ticketID}
    ''';
  }
}
