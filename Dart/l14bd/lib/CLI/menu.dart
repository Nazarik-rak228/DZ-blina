import 'dart:io';
import 'package:l14bd/domain/course.dart';
import 'package:l14bd/domain/role.dart';
import 'package:l14bd/domain/user.dart';
import 'package:l14bd/Data/database.dart';
import 'package:l14bd/domain/shedule.dart';
import 'package:l14bd/Data/user-repo.dart';
import 'package:l14bd/Data/roleRepo.dart';
import 'package:l14bd/Data/coursesRepo.dart';
import 'package:l14bd/Data/shesuleRepo.dart';
import 'package:l14bd/domain/valid.dart';


String genId() => DateTime.now().millisecondsSinceEpoch.toString();
void ShowMainMenu(){
  while(true){
    print('\n========== ГЛАВНОЕ МЕНЮ ==========');
    print('1. Пользователи');
    print('2. Роли');
    print('3. Курсы');
    print('4. Расписание');
    print('0. Выход');
    print("5. Вывести все");
    print('Выберите: ');

    
    var choice = stdin.readLineSync();
    
    
     switch (choice) {
      case '1':
        showUserMenu();
        break;
      case '2':
        showRoleMenu();
        break;
      case '3':
        showCourseMenu();
        break;
      case '4':
        showScheduleMenu();
        break;
        case '5':
        showAll();
        break;
      case '0':
        print('Пока!');
        disposeDb();
        exit(0);
      default:
        print('Неверный выбор');
    }
  }
}
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// дальше пойдет юзер
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void showUserMenu() {
  while (true) {
    print('========== ПОЛЬЗОВАТЕЛИ ==========');
    print('1. Показать всех');
    print('2. Создать');
    print('3. Редактировать');
    print('4. Удалить');
    print('0. Назад');
    print('Выберите: ');
    
    var choice = stdin.readLineSync();
    
    switch (choice) {
      case '1':
        showAllUsers();
        break;
      case '2':
        createUser();
        break;
      case '3':
        _updateUser();
        break;
      case '4':
        _deleteUser();
        break;
      case '0':
        return;
      default:
        print('Неверный выбор');
    }
  }
}
void showAllUsers(){
  print('[ПОЛЬЗОВАТЕЛИ]');
  var users = getAllUsers();
  if(users.isEmpty) {
    print('  Пусто');
  }
else 
{
for (var u in users){print('  ${u.id} | ${u.fullName}');} 
} 
}
void createUser(){
  try{
    print("Введите ФИО: ");
    var fullName = requareParametr(stdin.readLineSync(), 'ФИО');
    
    print("Введите email: ");
    var email = checkEmail(stdin.readLineSync(), 'Email');
    
    print("Введите логин: ");
    var login = requareParametr(stdin.readLineSync(), 'Логин');
    
    print("Введите пароль: ");
    var password = requareParametr(stdin.readLineSync(), 'Пароль');
    
    print("Введите ID роли: ");
    var roleId = requareParametr(stdin.readLineSync(), 'ID роли');

     if (getRole(roleId) == null) {
      return print(' Роль с ID $roleId не найдена!');
    }
    insertUser(User(
      id: genId(), fullName: fullName, email: email, login: login,
      password: password, roleId: roleId, createdAt: DateTime.now().toString()
    ));

  }catch(e){
    print(e);
  }
}
void _updateUser(){
  print('Редактирование пользователя');
  try {
    var id = requareParametr(stdin.readLineSync(), 'ID');
    var old = getUser(id);
    if (old == null) return print(' Не найден');

    print('Текущий: ${old.fullName}');
    print("Имя");
    var fullName = stdin.readLineSync();
        print("почнта");
    var email = stdin.readLineSync();
        print("пороль");
    var password = stdin.readLineSync();
        print("роль ");
    var roleId = stdin.readLineSync();

    fullName = fullName!.trim().isEmpty ? old.fullName : requareParametr(fullName, 'ФИО');
    email = email!.trim().isEmpty ? old.email : checkEmail(email, 'Email');
    password = password!.trim().isEmpty ? old.password : requareParametr(password, 'Пароль');
    
    if (roleId!.trim().isNotEmpty) {
      roleId = requareParametr(roleId, 'ID роли');
      if (getRole(roleId) == null) return print('  Роль не найдена');
    } else {
      roleId = old.roleId;
    }

    updateUser(User(id: old.id, fullName: fullName, email: email, login: old.login,
        password: password, roleId: roleId, createdAt: old.createdAt));
    print('Обновлено');
  } catch (e) {
    print(e);
  }
}
void _deleteUser(){
  print('Удаление пользователя');
  var id = requareParametr(stdin.readLineSync(), 'ID');

  var user = getUser(id);
  
  if (user == null) return print(' Не найден');
  
  print('Удалить ${user.fullName}? (y/n): ');
  var confirm = stdin.readLineSync();
  
  if (confirm == 'y' || confirm == 'Y') {
    deleteUser(user);
    print('Удалён');
  } else {
    print('Отменено');
  }
}
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// дальше пойдет роли
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void showRoleMenu() {
  while (true) {
    print('========== РОЛИ ==========');
    print('1. Показать все');
    print('2. Создать');
    print('3. Редактировать');
    print('4. Удалить');
    print('0. Назад');
    print('Выберите: ');
    
    var choice = stdin.readLineSync();
    
    switch (choice) {
      case '1': showAllRoles(); break;
      case '2': createRoleMenu(); break;
      case '3': updateRoleMenu(); break;
      case '4': _deleteRole(); break;
      case '0': return;
      default: print('Неверный выбор');
    }
  }
}

void showAllRoles(){
   print('[РОЛИ]');
  var roles = getAllRoles();
  if(roles.isEmpty){print('  Пусто');} 
  else{for (var r in roles){print('  ${r.id} | ${r.name}');} } 
}

void createRoleMenu(){
  try{
    print("Введи роль");
    var name = requareParametr(stdin.readLineSync(), 'Название роли');
    insertRole(Role(id: genId(), name: name));
    print('Роль создана');
  }catch(e){
    print(e);
  }
}

void updateRoleMenu(){
  print('Редактирование роли');
  try {
    var id = requareParametr(stdin.readLineSync(), 'ID');
    var old = getRole(id);
    if (old == null) return print(' Не найдена');

    print('Текущая: ${old.name}');
    print("Новое название: ");
    var name = stdin.readLineSync();
    
    name = name!.trim().isEmpty ? old.name : requareParametr(name, 'Название');

    updateRole(Role(id: old.id, name: name));
    print('Обновлена');
  } catch (e) {
    print(e);
  }
}

void _deleteRole(){
  print('Удаление роли');
  var id = stdin.readLineSync();
  var role = getRole(id!);
  
  if (role == null) return print(' Не найдена');
  
  print('Удалить "${role.name}"? (y/n): ');
  var confirm = stdin.readLineSync();
  
  if (confirm == 'y' || confirm == 'Y') {
    deleteRole(role);
    print('Удалена');
  } else {
    print('Отменено');
  }
}



// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// курсы
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void showCourseMenu() {
  while (true) {
    print('========== КУРСЫ ==========');
    print('1. Показать все');
    print('2. Создать');
    print('3. Редактировать');
    print('4. Удалить');
    print('0. Назад');
    print('Выберите: ');
    
    var choice = stdin.readLineSync();
    
    switch (choice) {
      case '1': showAllCourses(); break;
      case '2': createCourseMenu(); break;
      case '3': updateCourseMenu(); break;
      case '4': _deleteCourse(); break;
      case '0': return;
      default: print('Неверный выбор');
    }
  }
}

void showAllCourses(){
 
  print('КУРСЫ]');
  var courses = getAllCourses();
  if(courses.isEmpty){print('  Пусто');} 
  else{for (var c in courses){print('  ${c.id} | ${c.title}');} } 
}

void createCourseMenu(){
  try{
    print("Введите название курса: ");
    var title = requareParametr(stdin.readLineSync(), 'Название курса');
    
    print("Введите описание: ");
    var description = requareParametr(stdin.readLineSync(), 'Описание');
    
    print("Введите ID преподавателя: ");
    var teacherId = requareParametr(stdin.readLineSync(), 'ID преподавателя');

    
    if (getUser(teacherId) == null) {
      return print(' Преподаватель с ID $teacherId не найден!');
    }

    insertCourse(Course(id: genId(), title: title, description: description, teacherId: teacherId));
    print('Курс создан');
  }catch(e){
    print(e);
  }
}

void updateCourseMenu(){
  print('Редактирование курса');
  try {
    var id = requareParametr(stdin.readLineSync(), 'ID');
    var old = getCourse(id);
    if (old == null) return print(' Не найден');

    print('Текущий: ${old.title}');
    
    print("Новое название: ");
    var title = stdin.readLineSync();
    print("Новое описание: ");
    var description = stdin.readLineSync();
    print("Новый ID преподавателя: ");
    var teacherId = stdin.readLineSync();

    title = title!.trim().isEmpty ? old.title : requareParametr(title, 'Название');
    description = description!.trim().isEmpty ? old.description : requareParametr(description, 'Описание');
    
    if (teacherId!.trim().isNotEmpty) {
      teacherId = requareParametr(teacherId, 'ID преподавателя');
      if (getUser(teacherId) == null) return print(' Преподаватель не найден');
    } else {
      teacherId = old.teacherId;
    }

    updateCourse(Course(id: old.id, title: title, description: description, teacherId: teacherId));
    print('Обновлён');
  } catch (e) {
    print(e);
  }
}

void _deleteCourse(){
  print('Удаление курса');
  var id = stdin.readLineSync();
  var course = getCourse(id!);
  
  if (course == null) return print(' Не найден');
  
  print('Удалить "${course.title}"? (y/n): ');
  var confirm = stdin.readLineSync();
  
  if (confirm == 'y' || confirm == 'Y') {
    deleteCourse(course);
    print('Удалён');
  } else {
    print('Отменено');
  }
}


// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// курсы
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void showScheduleMenu() {
  while (true) {
    print('========== РАСПИСАНИЕ ==========');
    print('1. Показать всё');
    print('2. Создать');
    print('3. Редактировать');
    print('4. Удалить');
    print('0. Назад');
    print('Выберите: ');
    
    var choice = stdin.readLineSync();
    
    switch (choice) {
      case '1': showAllSchedules(); break;
      case '2': createScheduleMenu(); break;
      case '3': updateScheduleMenu(); break;
      case '4': _deleteSchedule(); break;
      case '0': return;
      default: print('Неверный выбор');
    }
  }
}

void showAllSchedules(){
  
  print('[РАСПИСАНИЕ]');
  var schedules = getAllSchedules();
  if(schedules.isEmpty){print('  Пусто');} 
  else{for (var s in schedules) {print('  ${s.id} | ${s.lessonDate} ${s.lessonTime}');}}
}

void createScheduleMenu(){
  try{
    print("Введите ID курса: ");
    var courseId = requareParametr(stdin.readLineSync(), 'ID курса');
    
    print("Введите ID преподавателя: ");
    var teacherId = requareParametr(stdin.readLineSync(), 'ID преподавателя');
    
    print("Введите дату (формат: ГГГГ-ММ-ДД): ");
    var lessonDate = requareParametr(stdin.readLineSync(), 'Дата');
    
    print("Введите время : ");
    var lessonTime = requareParametr(stdin.readLineSync(), 'Время');


    checkDate(lessonDate, 'Дата');
    if (getCourse(courseId) == null) {
      return print(' Курс с ID $courseId не найден!');
    }
    if (getUser(teacherId) == null) {
      return print(' Преподаватель с ID $teacherId не найден!');
    }

    insertSchedule(Schedule(
      id: genId(), 
      courseId: courseId, 
      teacherId: teacherId, 
      lessonDate: lessonDate, 
      lessonTime: lessonTime
    ));
    print('Запись создана');
  }catch(e){
    print(e);
  }
}

void updateScheduleMenu(){
  print('Редактирование расписания');
  try {
    var id = requareParametr(stdin.readLineSync(), 'ID');
    var old = getSchedule(id);
    if (old == null) return print(' Не найдено');

    print('Текущая: ${old.lessonDate} ${old.lessonTime}');
    
    print("Новый ID курса: ");
    var courseId = stdin.readLineSync();
    print("Новый ID преподавателя: ");
    var teacherId = stdin.readLineSync();
    print("Новая дата: ");
    var lessonDate = stdin.readLineSync();
    print("Новое время: ");
    var lessonTime = stdin.readLineSync();

    if (courseId!.trim().isNotEmpty) {
      courseId = requareParametr(courseId, 'ID курса');
      if (getCourse(courseId) == null) return print(' Курс не найден');
    } else { courseId = old.courseId; }
    
    if (teacherId!.trim().isNotEmpty) {
      teacherId = requareParametr(teacherId, 'ID преподавателя');
      if (getUser(teacherId) == null) return print(' Преподаватель не найден');
    } else { teacherId = old.teacherId; }
    
    if (lessonDate!.trim().isNotEmpty) {
      checkDate(lessonDate, 'Дата');
      lessonDate = lessonDate.trim();
    } else { lessonDate = old.lessonDate; }
    
    lessonTime = lessonTime!.trim().isEmpty ? old.lessonTime : requareParametr(lessonTime, 'Время');

    updateSchedule(Schedule(
      id: old.id, 
      courseId: courseId, 
      teacherId: teacherId, 
      lessonDate: lessonDate, 
      lessonTime: lessonTime
    ));
    print('Обновлено');
  } catch (e) {
    print(e);
  }
}

void _deleteSchedule(){
  print('Удаление записи');
  var id = stdin.readLineSync();
  var schedule = getSchedule(id!);
  
  if (schedule == null) return print(' Не найдено');
  
  print('Удалить запись от ${schedule.lessonDate}? (y/n): ');
  var confirm = stdin.readLineSync();
  
  if (confirm == 'y' || confirm == 'Y') {
    deleteSchedule(schedule);
    print('Удалено');
  } else {
    print('Отменено');
  }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ПОКАЗАТЬ ВСЁ ИЗ БД (пункт 5 в главном меню)
// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void showAll(){
  print('========== ВСЕ ДАННЫЕ ИЗ БД ==========');
  
  print('[ПОЛЬЗОВАТЕЛИ]');
  var users = getAllUsers();
  if(users.isEmpty) {
    print('  Пусто');
  }
else 
{
for (var u in users){print('  ${u.id} | ${u.fullName}');} 
} 
  print('[РОЛИ]');
  var roles = getAllRoles();
  if(roles.isEmpty){print('  Пусто');} 
  else{for (var r in roles){print('  ${r.id} | ${r.name}');} } 
  
  print('КУРСЫ]');
  var courses = getAllCourses();
  if(courses.isEmpty){print('  Пусто');} 
  else{for (var c in courses){print('  ${c.id} | ${c.title}');} } 
  
  print('[РАСПИСАНИЕ]');
  var schedules = getAllSchedules();
  if(schedules.isEmpty){print('  Пусто');} 
  else{for (var s in schedules) {print('  ${s.id} | ${s.lessonDate} ${s.lessonTime}');}}
  
  print('======================================');
}

















