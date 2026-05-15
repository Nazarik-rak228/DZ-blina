
import 'package:l14bd/domain/id.dart';

class Course implements Id {
  @override
  final String id;
  final String title;
  final String description;
  final String teacherId;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "teacher_id": teacherId,
      };

  factory Course.from(Map<String, dynamic> map) {
    return Course(
      id: map["id"] as String,
      title: map["title"] as String,
      description: map["description"] as String,
      teacherId: map["teacher_id"] as String,
    );
  }
}