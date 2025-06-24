import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static final _cipher =
      HiveAesCipher(utf8.encode('my32lengthsupersecretnooneknows1'));

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('auth', encryptionCipher: _cipher);
    await Hive.openBox('donations', encryptionCipher: _cipher);
    await Hive.openBox('appData', encryptionCipher: _cipher);
  }

  static Box get authBox => Hive.box('auth');
  static Box get donationsBox => Hive.box('donations');
  static Box get appDataBox => Hive.box('appData');
}
