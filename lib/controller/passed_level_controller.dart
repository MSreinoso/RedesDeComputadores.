import 'package:game_app/connection/database_provider.dart';
import 'package:game_app/model/passed_level_model.dart';
import 'package:sqflite/sqflite.dart';

class PassedLevelController {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<void> createPassedLevelsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS passed_levels (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        level INTEGER,
        starsEarned INTEGER
      )
    ''');
  }

  Future<void> storePassedLevel(int userId, int level, int starsEarned) async {
    final Database db = await _databaseProvider.database;
    await createPassedLevelsTable(db);
    await db.insert('passed_levels', {
      'userId': userId,
      'level': level,
      'starsEarned': starsEarned,
    });
  }

  Future<List<PassedLevelModel>> getPassedLevels(int userId) async {
    final Database db = await _databaseProvider.database;
    await createPassedLevelsTable(db);
    final List<Map<String, dynamic>> results = await db.query(
      'passed_levels',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return results.map((result) => PassedLevelModel.fromMap(result)).toList();
  }
}
