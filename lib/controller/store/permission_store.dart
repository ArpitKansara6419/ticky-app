import 'package:mobx/mobx.dart';

part 'permission_store.g.dart';

class PermissionStore = PermissionStoreBase with _$PermissionStore;

abstract class PermissionStoreBase with Store {
  @observable
  bool loader = false;

  @action
  void loaderValue(bool value) {
    loader = value;
  }
}
