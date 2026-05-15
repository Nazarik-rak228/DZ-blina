import 'package:l14bd/domain/user.dart';
import 'package:l14bd/Data/database.dart';

  // узеры

  void insertUser(User user) {
    sqlite.execute(
        "INSERT OR REPLACE INTO users (id,full_name,email,login,password,role_id,created_at) VALUES(?,?,?,?,?,?,?)",
        [
          user.id,
          user.fullName,
          user.email,
          user.login,
          user.password,
          user.roleId,
          user.createdAt
        ]);
  }

  List<User> getAllUsers() {
    final result = sqlite.select('SELECT * FROM users');
    return result.map((row) => User.from(row)).toList();
  }

  User? getUser(String id) {
    final result = sqlite.select('SELECT * FROM users WHERE id=?', [id]);
    return result.isNotEmpty ? User.from(result.first) : null;
  }

  void updateUser(User user) {
    sqlite.execute(
        "UPDATE users SET full_name=?, email=?, login=?, password=?, role_id=?, created_at=? WHERE id=?",
        [
          user.fullName,
          user.email,
          user.login,
          user.password,
          user.roleId,
          user.createdAt,
          user.id
        ]);
  }

  void deleteUser(User user) {
    sqlite.execute('DELETE FROM users WHERE id=?', [user.id]);
  }