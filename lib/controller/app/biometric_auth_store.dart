import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:ticky/utils/widgets/biometrics/biometric_auth_util.dart';

part 'biometric_auth_store.g.dart';

class BiometricAuthStore = _BiometricAuthStore with _$BiometricAuthStore;

abstract class _BiometricAuthStore with Store {
  final BiometricAuthUtil _biometricAuthUtil = BiometricAuthUtil();
  final LocalAuthentication auth = LocalAuthentication();

  @observable
  bool isLocked = true;
  @observable
  bool isMonthlyLocked = true;
  @observable
  bool isPayoutLocked = true;

  @action
  Future<void> authenticate() async {
    bool isBiometricSupported = await _biometricAuthUtil.isBiometricSupported();

    if (isBiometricSupported) {
      // Perform authentication
      bool isAuthenticated = await _biometricAuthUtil.authenticate();

      if (isAuthenticated) {
        isLocked = false; // Unlock the tab
      } else {
        isLocked = true; // Unlock t  // Handle authentication failure
        throw Exception("Biometric authentication failed!");
      }
    } else {
      isLocked = true;
      throw Exception('Biometric authentication is not supported on this device.');
    }
  }

  @action
  Future<void> authenticateMonthlyLocked() async {
    bool isBiometricSupported = await _biometricAuthUtil.isBiometricSupported();

    if (isBiometricSupported) {
      // Perform authentication
      bool isAuthenticated = await _biometricAuthUtil.authenticate();

      if (isAuthenticated) {
        isMonthlyLocked = false; // Unlock the tab
      } else {
        isMonthlyLocked = true; // Unlock t  // Handle authentication failure
        throw Exception("Biometric authentication failed!");
      }
    } else {
      isMonthlyLocked = true;
      throw Exception('Biometric authentication is not supported on this device.');
    }
  }

  @action
  Future<void> authenticatePayoutLocked() async {
    bool isBiometricSupported = await _biometricAuthUtil.isBiometricSupported();

    if (isBiometricSupported) {
      // Perform authentication
      bool isAuthenticated = await _biometricAuthUtil.authenticate();

      if (isAuthenticated) {
        isPayoutLocked = false; // Unlock the tab
      } else {
        isPayoutLocked = true; // Unlock t  // Handle authentication failure
        throw Exception("Biometric authentication failed!");
      }
    } else {
      isPayoutLocked = true;
      throw Exception('Biometric authentication is not supported on this device.');
    }
  }

  @action
  void dispose() {
    isLocked = false;
    isMonthlyLocked = false;
    isPayoutLocked = false;
  }
}
