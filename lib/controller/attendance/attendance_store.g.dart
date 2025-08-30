// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AttendanceStore on AttendanceStoreBase, Store {
  late final _$futureAtom =
      Atom(name: 'AttendanceStoreBase.future', context: context);

  @override
  ObservableFuture<AttendanceResponse>? get future {
    _$futureAtom.reportRead();
    return super.future;
  }

  @override
  set future(ObservableFuture<AttendanceResponse>? value) {
    _$futureAtom.reportWrite(value, super.future, () {
      super.future = value;
    });
  }

  late final _$fetchAttendanceAsyncAction =
      AsyncAction('AttendanceStoreBase.fetchAttendance', context: context);

  @override
  Future<void> fetchAttendance(DateTime date) {
    return _$fetchAttendanceAsyncAction.run(() => super.fetchAttendance(date));
  }

  @override
  String toString() {
    return '''
future: ${future}
    ''';
  }
}
