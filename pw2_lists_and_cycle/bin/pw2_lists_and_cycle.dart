void main() {
  // Список студентов (7 человек, больше минимума)
  List<String> students = [
    'Иванов И.И.',
    'Петров П.П.',
    'Сидорова А.А.',
    'Козлов А.С.',
    'Смирнова М.В.',
    'Васильев Д.М.',
    'Николаева Е.П.',
  ];

  // Список предметов (5 предметов, больше минимума)
  List<String> subjects = [
    'Математика',
    'Русский язык',
    'Физика',
    'Химия',
    'Информатика',
  ];

  // Оценки: 2D-список [студент][предмет], оценки от 2 до 5
  List<List<int>> grades = [
    [5, 4, 5, 4, 5],     // Иванов
    [3, 3, 2, 4, 3],     // Петров
    [4, 5, 4, 5, 4],     // Сидорова
    [5, 5, 5, 5, 5],     // Козлов
    [2, 3, 4, 3, 2],     // Смирнова
    [4, 4, 3, 4, 5],     // Васильев
    [5, 4, 5, 5, 4],     // Николаева
  ];

  // 1. Полный список студентов с нумерацией
  print('=== СПИСОК СТУДЕНТОВ ===');
  for (int i = 0; i < students.length; i++) {
    print('${i + 1}. ${students[i]}');
  }
  print('');

  // Полный список предметов
  print('=== СПИСОК ПРЕДМЕТОВ ===');
  for (int j = 0; j < subjects.length; j++) {
    print('${j + 1}. ${subjects[j]}');
  }
  print('');

  // 2. Оценки каждого студента (построчно)
  print('=== ОЦЕНКИ СТУДЕНТОВ ===');
  for (int i = 0; i < students.length; i++) {
    print('${students[i]}:');
    for (int j = 0; j < subjects.length; j++) {
      print('   ${subjects[j]}: ${grades[i][j]}');
    }
    print('');
  }

  // 3. Средний балл по каждому предмету
  print('=== СРЕДНИЙ БАЛЛ ПО ПРЕДМЕТАМ ===');
  for (int j = 0; j < subjects.length; j++) {
    double sum = 0;
    for (int i = 0; i < students.length; i++) {
      sum += grades[i][j];
    }
    double avg = sum / students.length;
    print('${subjects[j]}: ${avg.toStringAsFixed(2)}');
  }
  print('');

  // 4. Средний балл каждого студента
  print('=== СРЕДНИЙ БАЛЛ СТУДЕНТОВ ===');
  List<double> studentAvgs = [];
  for (int i = 0; i < students.length; i++) {
    double sum = 0;
    for (int j = 0; j < subjects.length; j++) {
      sum += grades[i][j];
    }
    double avg = sum / subjects.length;
    studentAvgs.add(avg);
    print('${students[i]}: ${avg.toStringAsFixed(2)}');
  }
  print('');

  // 5. Лучший студент
  double maxAvg = studentAvgs[0];
  String bestStudent = students[0];
  for (int i = 1; i < students.length; i++) {
    if (studentAvgs[i] > maxAvg) {
      maxAvg = studentAvgs[i];
      bestStudent = students[i];
    }
  }
  print('Лучший студент: $bestStudent (средний балл ${maxAvg.toStringAsFixed(2)})');

  // 6. Предмет с наименьшим средним баллом
  List<double> subjectAvgs = [];
  for (int j = 0; j < subjects.length; j++) {
    double sum = 0;
    for (int i = 0; i < students.length; i++) {
      sum += grades[i][j];
    }
    subjectAvgs.add(sum / students.length);
  }
  double minAvg = subjectAvgs[0];
  String worstSubject = subjects[0];
  for (int j = 1; j < subjects.length; j++) {
    if (subjectAvgs[j] < minAvg) {
      minAvg = subjectAvgs[j];
      worstSubject = subjects[j];
    }
  }
  print('Предмет с наименьшим средним баллом: $worstSubject (${minAvg.toStringAsFixed(2)})');

  // 7. Общий средний балл по всей группе
  double totalSum = 0;
  int totalCount = students.length * subjects.length;
  for (int i = 0; i < students.length; i++) {
    for (int j = 0; j < subjects.length; j++) {
      totalSum += grades[i][j];
    }
  }
  double overallAvg = totalSum / totalCount;
  print('Общий средний балл по группе: ${overallAvg.toStringAsFixed(2)}');

  // 8. Перечень всех предметов без повторов и их количество
  Set<String> uniqueSubjects = subjects.toSet();
  print('\n=== УНИКАЛЬНЫЕ ПРЕДМЕТЫ (${uniqueSubjects.length}) ===');
  for (var subj in uniqueSubjects) {
    print('- $subj');
  }

  // 9. Студенты без ни одной оценки 2
  print('\n=== СТУДЕНТЫ БЕЗ ОЦЕНКИ 2 ===');
  for (int i = 0; i < students.length; i++) {
    bool hasTwo = false;
    for (int j = 0; j < subjects.length; j++) {
      if (grades[i][j] == 2) {
        hasTwo = true;
        break;
      }
    }
    if (!hasTwo) {
      print('- ${students[i]}');
    }
  }

  // 10. Студенты, у которых все оценки не ниже 4
  print('\n=== СТУДЕНТЫ С ОЦЕНКАМИ НЕ НИЖЕ 4 ===');
  for (int i = 0; i < students.length; i++) {
    bool allGood = true;
    for (int j = 0; j < subjects.length; j++) {
      if (grades[i][j] < 4) {
        allGood = false;
        break;
      }
    }
    if (allGood) {
      print('- ${students[i]}');
    }
  }

  print('\n=== ЖУРНАЛ УСПЕВАЕМОСТИ ЗАВЕРШЁН ===');
}