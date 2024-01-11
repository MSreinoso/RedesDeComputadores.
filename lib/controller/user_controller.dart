import 'package:game_app/connection/database_provider.dart';
import 'package:game_app/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<void> registerUser(
    String username,
    String email,
    String password,
    String name,
  ) async {
    final Database db = _databaseProvider.database;
    await db.insert(
      'Users',
      UserModel(
        username: username,
        email: email,
        password: password,
        name: name,
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> loginUser(String username, String password) async {
    final Database db = _databaseProvider.database;
    final List<Map<String, dynamic>> result = await db.query(
      'Users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<UserModel?> getLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id');

    if (userId != null) {
      // Si hay un ID de usuario almacenado, obtén el usuario correspondiente
      final Database db = _databaseProvider.database;
      final List<Map<String, dynamic>> result = await db.query(
        'Users',
        where: 'id = ?',
        whereArgs: [userId],
      );

      if (result.isNotEmpty) {
        return UserModel.fromMap(result.first);
      }
    }

    return null;
  }

  Future<void> storeLoggedInUser(UserModel user) async {
    // Almacena las credenciales del usuario logeado de forma segura
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', user.id!);
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }
}
