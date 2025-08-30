import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isDarkModeOn = false;

  @observable
  bool pinCodeLoader = false;

  @action
  Future<void> setDarkModeStatus(bool value) async {
    isDarkModeOn = value;
  }

  @action
  Future<void> setPinCodeLoaderStatus(bool value) async {
    pinCodeLoader = value;
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
  }
}
