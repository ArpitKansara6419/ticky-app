// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$emailContAtom =
      Atom(name: 'AuthStoreBase.emailCont', context: context);

  @override
  TextEditingController get emailCont {
    _$emailContAtom.reportRead();
    return super.emailCont;
  }

  @override
  set emailCont(TextEditingController value) {
    _$emailContAtom.reportWrite(value, super.emailCont, () {
      super.emailCont = value;
    });
  }

  late final _$passContAtom =
      Atom(name: 'AuthStoreBase.passCont', context: context);

  @override
  TextEditingController get passCont {
    _$passContAtom.reportRead();
    return super.passCont;
  }

  @override
  set passCont(TextEditingController value) {
    _$passContAtom.reportWrite(value, super.passCont, () {
      super.passCont = value;
    });
  }

  late final _$isRememberAtom =
      Atom(name: 'AuthStoreBase.isRemember', context: context);

  @override
  bool get isRemember {
    _$isRememberAtom.reportRead();
    return super.isRemember;
  }

  @override
  set isRemember(bool value) {
    _$isRememberAtom.reportWrite(value, super.isRemember, () {
      super.isRemember = value;
    });
  }

  late final _$fcmTokenAtom =
      Atom(name: 'AuthStoreBase.fcmToken', context: context);

  @override
  String? get fcmToken {
    _$fcmTokenAtom.reportRead();
    return super.fcmToken;
  }

  @override
  set fcmToken(String? value) {
    _$fcmTokenAtom.reportWrite(value, super.fcmToken, () {
      super.fcmToken = value;
    });
  }

  late final _$inValidCredentialsAtom =
      Atom(name: 'AuthStoreBase.inValidCredentials', context: context);

  @override
  String? get inValidCredentials {
    _$inValidCredentialsAtom.reportRead();
    return super.inValidCredentials;
  }

  @override
  set inValidCredentials(String? value) {
    _$inValidCredentialsAtom.reportWrite(value, super.inValidCredentials, () {
      super.inValidCredentials = value;
    });
  }

  late final _$profileCompletionDataAtom =
      Atom(name: 'AuthStoreBase.profileCompletionData', context: context);

  @override
  ProfileCompletionResponse? get profileCompletionData {
    _$profileCompletionDataAtom.reportRead();
    return super.profileCompletionData;
  }

  @override
  set profileCompletionData(ProfileCompletionResponse? value) {
    _$profileCompletionDataAtom.reportWrite(value, super.profileCompletionData,
        () {
      super.profileCompletionData = value;
    });
  }

  late final _$emailFocusNodeAtom =
      Atom(name: 'AuthStoreBase.emailFocusNode', context: context);

  @override
  FocusNode get emailFocusNode {
    _$emailFocusNodeAtom.reportRead();
    return super.emailFocusNode;
  }

  @override
  set emailFocusNode(FocusNode value) {
    _$emailFocusNodeAtom.reportWrite(value, super.emailFocusNode, () {
      super.emailFocusNode = value;
    });
  }

  late final _$passwordFocusNodeAtom =
      Atom(name: 'AuthStoreBase.passwordFocusNode', context: context);

  @override
  FocusNode get passwordFocusNode {
    _$passwordFocusNodeAtom.reportRead();
    return super.passwordFocusNode;
  }

  @override
  set passwordFocusNode(FocusNode value) {
    _$passwordFocusNodeAtom.reportWrite(value, super.passwordFocusNode, () {
      super.passwordFocusNode = value;
    });
  }

  late final _$signInFormStateAtom =
      Atom(name: 'AuthStoreBase.signInFormState', context: context);

  @override
  GlobalKey<FormState> get signInFormState {
    _$signInFormStateAtom.reportRead();
    return super.signInFormState;
  }

  @override
  set signInFormState(GlobalKey<FormState> value) {
    _$signInFormStateAtom.reportWrite(value, super.signInFormState, () {
      super.signInFormState = value;
    });
  }

  late final _$setRememberValueAsyncAction =
      AsyncAction('AuthStoreBase.setRememberValue', context: context);

  @override
  Future<void> setRememberValue(bool val, {bool isInitializing = false}) {
    return _$setRememberValueAsyncAction
        .run(() => super.setRememberValue(val, isInitializing: isInitializing));
  }

  late final _$setInValidCredentialsValueAsyncAction =
      AsyncAction('AuthStoreBase.setInValidCredentialsValue', context: context);

  @override
  Future<void> setInValidCredentialsValue(String? val) {
    return _$setInValidCredentialsValueAsyncAction
        .run(() => super.setInValidCredentialsValue(val));
  }

  late final _$setProfileCompletionDataAsyncAction =
      AsyncAction('AuthStoreBase.setProfileCompletionData', context: context);

  @override
  Future<void> setProfileCompletionData(Map<String, dynamic> val,
      {bool isInitializing = false}) {
    return _$setProfileCompletionDataAsyncAction.run(() =>
        super.setProfileCompletionData(val, isInitializing: isInitializing));
  }

  late final _$onSignSubmitAsyncAction =
      AsyncAction('AuthStoreBase.onSignSubmit', context: context);

  @override
  Future<void> onSignSubmit(
      {required String? token, required BuildContext context}) {
    return _$onSignSubmitAsyncAction
        .run(() => super.onSignSubmit(token: token, context: context));
  }

  late final _$disposeAsyncAction =
      AsyncAction('AuthStoreBase.dispose', context: context);

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  @override
  String toString() {
    return '''
emailCont: ${emailCont},
passCont: ${passCont},
isRemember: ${isRemember},
fcmToken: ${fcmToken},
inValidCredentials: ${inValidCredentials},
profileCompletionData: ${profileCompletionData},
emailFocusNode: ${emailFocusNode},
passwordFocusNode: ${passwordFocusNode},
signInFormState: ${signInFormState}
    ''';
  }
}
