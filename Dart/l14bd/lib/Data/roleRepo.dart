import 'package:l14bd/domain/role.dart';
import 'package:l14bd/Data/database.dart';

  void insertRole(Role role) {
    sqlite.execute(
        "INSERT OR REPLACE INTO roles (id,name) VALUES(?,?)",
        [role.id, role.name]);
  }

  List<Role> getAllRoles() {
    final result = sqlite.select('SELECT * FROM roles');
    return result.map((row) => Role.from(row)).toList();
  }

  Role? getRole(String id) {
    final result = sqlite.select('SELECT * FROM roles WHERE id=?', [id]);
    return result.isNotEmpty ? Role.from(result.first) : null;
  }

  void updateRole(Role role) {
    sqlite.execute("UPDATE roles SET name=? WHERE id=?", [role.name, role.id]);
  }

  void deleteRole(Role role) {
    sqlite.execute('DELETE FROM roles WHERE id=?', [role.id]);
  }