import 'package:hive_flutter/hive_flutter.dart';
import 'database_service.dart';

class AuthService {
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';

  static Future<void> saveCredentials(String email, String password) async {
    final box = DatabaseService.authBox;
    await box.put(_keyEmail, email);
    await box.put(_keyPassword, password);
  }

  static Map<String, String?> getCredentials() {
    final box = DatabaseService.authBox;
    return {
      'email': box.get(_keyEmail) as String?,
      'password': box.get(_keyPassword) as String?,
    };
  }
}
