import 'package:l14bd/domain/id.dart';

class Role implements Id {
  @override
  final String id;

  final String name;

  const Role({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  factory Role.from(Map<String, dynamic> map) {
    return Role(
      id: map["id"] as String,
      name: map["name"] as String,
    );
  }
}
