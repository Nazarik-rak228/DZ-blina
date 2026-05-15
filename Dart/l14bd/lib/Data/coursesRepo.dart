import 'package:l14bd/domain/course.dart';
import 'package:l14bd/Data/database.dart';
  // курсы, будем прогревать гоев)

  void insertCourse(Course course) {
    sqlite.execute(
        "INSERT OR REPLACE INTO courses (id,title,description,teacher_id) VALUES(?,?,?,?)",
        [course.id, course.title, course.description, course.teacherId]);
  }

  List<Course> getAllCourses() {
    final result = sqlite.select('SELECT * FROM courses');
    return result.map((row) => Course.from(row)).toList();
  }

  Course? getCourse(String id) {
    final result = sqlite.select('SELECT * FROM courses WHERE id=?', [id]);
    return result.isNotEmpty ? Course.from(result.first) : null;
  }

  void updateCourse(Course course) {
    sqlite.execute(
        "UPDATE courses SET title=?, description=?, teacher_id=? WHERE id=?",
        [course.title, course.description, course.teacherId, course.id]);
  }

  void deleteCourse(Course course) {
    sqlite.execute('DELETE FROM courses WHERE id=?', [course.id]);
  }