import 'dart:async';
import 'package:cps_mobile/src/data/models/city_table.dart';
import 'package:cps_mobile/src/data/models/user_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblCacheUser = 'cache_users';
  static const String _tblCacheCity = 'cache_cities';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/user.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: 'user123',
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblCacheUser (
        name TEXT,
        address TEXT,
        email TEXT,
        phoneNumber TEXT,
        city TEXT,
        id TEXT,
        userId INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCacheCity (
        name TEXT,
        id TEXT,
        cityId INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
  }

  Future<void> insertCacheTransactionUsers(
    List<UserTable> users,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final user in users) {
        final userJson = user.toJson();
        txn.insert(_tblCacheUser, userJson);
      }
    });
  }

  Future<void> insertCacheTransactionCities(
      List<CityTable> cities, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final city in cities) {
        final cityJson = city.toJson();
        txn.insert(_tblCacheCity, cityJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheUsers(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblCacheUser);

    return results;
  }

  Future<List<Map<String, dynamic>>> clearCacheUsersById(String userId) async {
    final db = await database;
    await db!.delete(
      _tblCacheUser,
      where: 'id = ?',
      whereArgs: [userId],
    );
    return getCacheUsers("");
  }

  Future<List<Map<String, dynamic>>> getCacheFilteredUsers(String city) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheUser,
      where: 'city = ?',
      whereArgs: [city],
    );
    return results;
  }

  Future<List<Map<String, dynamic>>> getCacheCities(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblCacheCity);
    return results;
  }

  Future<int> clearCacheUsers(String category) async {
    final db = await database;
    return db!.delete(_tblCacheUser);
  }

  Future<int> clearCacheCities() async {
    final db = await database;
    return db!.delete(_tblCacheCity);
  }
}
