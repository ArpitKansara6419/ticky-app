// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PermissionStore on PermissionStoreBase, Store {
  late final _$loaderAtom =
      Atom(name: 'PermissionStoreBase.loader', context: context);

  @override
  bool get loader {
    _$loaderAtom.reportRead();
    return super.loader;
  }

  @override
  set loader(bool value) {
    _$loaderAtom.reportWrite(value, super.loader, () {
      super.loader = value;
    });
  }

  late final _$PermissionStoreBaseActionController =
      ActionController(name: 'PermissionStoreBase', context: context);

  @override
  void loaderValue(bool value) {
    final _$actionInfo = _$PermissionStoreBaseActionController.startAction(
        name: 'PermissionStoreBase.loaderValue');
    try {
      return super.loaderValue(value);
    } finally {
      _$PermissionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loader: ${loader}
    ''';
  }
}
