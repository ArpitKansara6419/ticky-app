// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BiometricAuthStore on _BiometricAuthStore, Store {
  late final _$isLockedAtom =
      Atom(name: '_BiometricAuthStore.isLocked', context: context);

  @override
  bool get isLocked {
    _$isLockedAtom.reportRead();
    return super.isLocked;
  }

  @override
  set isLocked(bool value) {
    _$isLockedAtom.reportWrite(value, super.isLocked, () {
      super.isLocked = value;
    });
  }

  late final _$isMonthlyLockedAtom =
      Atom(name: '_BiometricAuthStore.isMonthlyLocked', context: context);

  @override
  bool get isMonthlyLocked {
    _$isMonthlyLockedAtom.reportRead();
    return super.isMonthlyLocked;
  }

  @override
  set isMonthlyLocked(bool value) {
    _$isMonthlyLockedAtom.reportWrite(value, super.isMonthlyLocked, () {
      super.isMonthlyLocked = value;
    });
  }

  late final _$isPayoutLockedAtom =
      Atom(name: '_BiometricAuthStore.isPayoutLocked', context: context);

  @override
  bool get isPayoutLocked {
    _$isPayoutLockedAtom.reportRead();
    return super.isPayoutLocked;
  }

  @override
  set isPayoutLocked(bool value) {
    _$isPayoutLockedAtom.reportWrite(value, super.isPayoutLocked, () {
      super.isPayoutLocked = value;
    });
  }

  late final _$authenticateAsyncAction =
      AsyncAction('_BiometricAuthStore.authenticate', context: context);

  @override
  Future<void> authenticate() {
    return _$authenticateAsyncAction.run(() => super.authenticate());
  }

  late final _$authenticateMonthlyLockedAsyncAction = AsyncAction(
      '_BiometricAuthStore.authenticateMonthlyLocked',
      context: context);

  @override
  Future<void> authenticateMonthlyLocked() {
    return _$authenticateMonthlyLockedAsyncAction
        .run(() => super.authenticateMonthlyLocked());
  }

  late final _$authenticatePayoutLockedAsyncAction = AsyncAction(
      '_BiometricAuthStore.authenticatePayoutLocked',
      context: context);

  @override
  Future<void> authenticatePayoutLocked() {
    return _$authenticatePayoutLockedAsyncAction
        .run(() => super.authenticatePayoutLocked());
  }

  late final _$_BiometricAuthStoreActionController =
      ActionController(name: '_BiometricAuthStore', context: context);

  @override
  void dispose() {
    final _$actionInfo = _$_BiometricAuthStoreActionController.startAction(
        name: '_BiometricAuthStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_BiometricAuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLocked: ${isLocked},
isMonthlyLocked: ${isMonthlyLocked},
isPayoutLocked: ${isPayoutLocked}
    ''';
  }
}
