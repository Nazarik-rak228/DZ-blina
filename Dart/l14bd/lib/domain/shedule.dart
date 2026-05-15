import 'package:l14bd/domain/id.dart';
class Schedule implements Id {
  @override
  final String id;
  final String courseId;
  final String teacherId;
  final String lessonDate;
  final String lessonTime;

  const Schedule({
    required this.id,
    required this.courseId,
    required this.teacherId,
    required this.lessonDate,
    required this.lessonTime,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "course_id": courseId,
        "teacher_id": teacherId,
        "lesson_date": lessonDate,
        "lesson_time": lessonTime,
      };

  factory Schedule.from(Map<String, dynamic> map) {
    return Schedule(
      id: map["id"] as String,
      courseId: map["course_id"] as String,
      teacherId: map["teacher_id"] as String,
      lessonDate: map["lesson_date"] as String,
      lessonTime: map["lesson_time"] as String,
    );
  }
}
