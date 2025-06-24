import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static Database? _db;
  static const _dbName = 'noor_funds.db';
  static const _dbVersion = 2;

  static Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
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
        currency TEXT,
        date TEXT,
        category TEXT,
        notes TEXT,
        image_path TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE donations ADD COLUMN currency TEXT");
      await db.execute("ALTER TABLE donations ADD COLUMN category TEXT");
      await db.execute("ALTER TABLE donations ADD COLUMN image_path TEXT");
    }
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

  static Future<int> deleteDonation(int id) async {
    return await _database.delete('donations', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getUserDonations(int userId) async {
    return await _database.query('donations', where: 'user_id = ?', whereArgs: [userId]);
  }
}
