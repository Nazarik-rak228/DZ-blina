import 'package:l14bd/domain/id.dart';
class User implements Id {
  @override
  final String id;
  final String fullName;
  final String email;
  final String login;
  final String password;
  final String roleId;
  final String createdAt;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.login,
    required this.password,
    required this.roleId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "login": login,
        "password": password,
        "role_id": roleId,
        "created_at": createdAt,
      };

  factory User.from(Map<String, dynamic> map) {
    return User(
      id: map["id"] as String,
      fullName: map["full_name"] as String,
      email: map["email"] as String,
      login: map["login"] as String,
      password: map["password"] as String,
      roleId: map["role_id"] as String,
      createdAt: map["created_at"] as String,
    );
  }
}