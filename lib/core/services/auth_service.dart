import 'package:hive_flutter/hive_flutter.dart';
import 'database_service.dart';
import 'sqlite_service.dart';

class AuthService {
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';

  static Future<bool> signUp(String email, String password) async {
    final id = await SqliteService.createUser(email, password);
    if (id > 0) {
      await saveCredentials(email, password);
      return true;
    }
    return false;
  }

  static Future<bool> login(String email, String password) async {
    final user = await SqliteService.getUser(email, password);
    if (user != null) {
      await saveCredentials(email, password);
      return true;
    }
    return false;
  }

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
