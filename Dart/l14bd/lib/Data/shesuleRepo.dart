import 'package:l14bd/domain/shedule.dart';
import 'package:l14bd/Data/database.dart';

  // роли 

  // раньше не знал как переводится название игры про наркокортель)
  void insertSchedule(Schedule schedule) {
    sqlite.execute(
        "INSERT OR REPLACE INTO schedule (id,course_id,teacher_id,lesson_date,lesson_time) VALUES(?,?,?,?,?)",
        [
          schedule.id,
          schedule.courseId,
          schedule.teacherId,
          schedule.lessonDate,
          schedule.lessonTime
        ]);
  }

  List<Schedule> getAllSchedules() {
    final result = sqlite.select('SELECT * FROM schedule');
    return result.map((row) => Schedule.from(row)).toList();
  }

  Schedule? getSchedule(String id) {
    final result = sqlite.select('SELECT * FROM schedule WHERE id=?', [id]);
    return result.isNotEmpty ? Schedule.from(result.first) : null;
  }

  void updateSchedule(Schedule schedule) {
    sqlite.execute(
        "UPDATE schedule SET course_id=?, teacher_id=?, lesson_date=?, lesson_time=? WHERE id=?",
        [
          schedule.courseId,
          schedule.teacherId,
          schedule.lessonDate,
          schedule.lessonTime,
          schedule.id
        ]);
  }

  void deleteSchedule(Schedule schedule) {
    sqlite.execute('DELETE FROM schedule WHERE id=?', [schedule.id]);
  }
