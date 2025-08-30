import 'dart:async';

import 'package:local_auth/local_auth.dart';

class BiometricAuthUtil {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if biometrics are supported on the device
  Future<bool> isBiometricSupported() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  /// Authenticate the user using biometrics
  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access Payouts',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false; // Return false if authentication fails or is canceled
    }
  }
}
