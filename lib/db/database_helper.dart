import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/player.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'app.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE players (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            score_daily TEXT,
            score_yearly TEXT,
            best_performance TEXT,
            wickets INTEGER,
            batting_style TEXT,
            bowling_style TEXT,
            team TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Insert a user into the database
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  // Retrieve a user by email and password
  Future<User?> getUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Insert a player into the database
  Future<int> insertPlayer(Player player) async {
    final db = await database;
    return await db.insert('players', player.toJson());
  }

  // Retrieve all players from the database
  Future<List<Player>> getPlayers() async {
    final db = await database;
    final result = await db.query('players');
    return result.map((data) => Player.fromJson(data)).toList();
  }
}
