import 'package:mnemosyne/models/password.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _bdName = "passwords.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _bdName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE passwords(id INTEGER PRIMARY KEY, name TEXT NOT NULL, password TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addPass(password pass) async {
    final db = await _getDb();
    return await db.insert("passwords", pass.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deletePass(password pass) async {
    final db = await _getDb();
    return await db.delete("passwords", where: 'id = ?', whereArgs: [pass.id]);
  }

  static Future<List<password>?> allPassword() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query("passwords");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => password.fromJson(maps[index]));
  }
}
