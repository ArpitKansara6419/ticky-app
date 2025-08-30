// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$isDarkModeOnAtom =
      Atom(name: 'AppStoreBase.isDarkModeOn', context: context);

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  late final _$pinCodeLoaderAtom =
      Atom(name: 'AppStoreBase.pinCodeLoader', context: context);

  @override
  bool get pinCodeLoader {
    _$pinCodeLoaderAtom.reportRead();
    return super.pinCodeLoader;
  }

  @override
  set pinCodeLoader(bool value) {
    _$pinCodeLoaderAtom.reportWrite(value, super.pinCodeLoader, () {
      super.pinCodeLoader = value;
    });
  }

  late final _$setDarkModeStatusAsyncAction =
      AsyncAction('AppStoreBase.setDarkModeStatus', context: context);

  @override
  Future<void> setDarkModeStatus(bool value) {
    return _$setDarkModeStatusAsyncAction
        .run(() => super.setDarkModeStatus(value));
  }

  late final _$setPinCodeLoaderStatusAsyncAction =
      AsyncAction('AppStoreBase.setPinCodeLoaderStatus', context: context);

  @override
  Future<void> setPinCodeLoaderStatus(bool value) {
    return _$setPinCodeLoaderStatusAsyncAction
        .run(() => super.setPinCodeLoaderStatus(value));
  }

  late final _$disposeAsyncAction =
      AsyncAction('AppStoreBase.dispose', context: context);

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
pinCodeLoader: ${pinCodeLoader}
    ''';
  }
}
