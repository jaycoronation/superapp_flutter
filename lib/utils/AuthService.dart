import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isAuthenticated = false;

    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    print("isBiometricSupported === $isBiometricSupported");
    print("canCheckBiometrics === $canCheckBiometrics");

    if (isBiometricSupported && canCheckBiometrics)
    {
      try {
        isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Verify fingerprint, pin or password to authenticate',
            options: const AuthenticationOptions(
                biometricOnly: false,
                useErrorDialogs: true,
                stickyAuth: true,
            ),
          authMessages: []
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    else
      {
        print("Not Supported");
      }
    return isAuthenticated;
  }
}