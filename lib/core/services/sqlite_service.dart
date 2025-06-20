import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static Database? _db;
  static const _dbName = 'noor_funds.db';
  static const _dbVersion = 1;

  static Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE donations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        donor_name TEXT,
        amount REAL,
        date TEXT,
        notes TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
  }

  static Database get _database => _db!;

  static Future<int> createUser(String email, String password) async {
    return await _database.insert('users', {
      'email': email,
      'password': password,
    });
  }

  static Future<Map<String, dynamic>?> getUser(
      String email, String password) async {
    final result = await _database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  static Future<int> addDonation(Map<String, dynamic> donation) async {
    return await _database.insert('donations', donation);
  }

  static Future<List<Map<String, dynamic>>> getUserDonations(int userId) async {
    return await _database.query('donations', where: 'user_id = ?', whereArgs: [userId]);
  }
}
