import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('auth');
    await Hive.openBox('donations');
  }

  static Box get authBox => Hive.box('auth');
  static Box get donationsBox => Hive.box('donations');
}
