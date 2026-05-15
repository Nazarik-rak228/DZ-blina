import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class CoursesDatabase {
  final Database _sqlite;
  Database get sqlite => _sqlite;

  CoursesDatabase(String filePath) : _sqlite = sqlite3.open(filePath) {
    _createTables();
  }

  factory CoursesDatabase.inApp() {
    final dbPath = p.join(Directory.current.path, "courses.db");
    return CoursesDatabase(dbPath);
  }

// class SalonDataBase{
//   final Database  _sqlite;
//   Database get sqlite=> _sqlite;

//   SalonDataBase(String filePath): _sqlite=sqlite3.open(filePath){
//    _createTables();
//   }
 
//    factory SalonDataBase.inApp() {
//     final p8 = p.join(Directory.current.path, "p8.db");
//     return SalonDataBase(p8);   
//     }
  
  void _createTables() {


    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS roles (
        id PRIMARY KEY,
        name TEXT UNIQUE NOT NULL
      )
    ''');
sqlite.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id PRIMARY KEY,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        login TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role_id TEXT NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (role_id) REFERENCES roles(id)
      )
    ''');
sqlite.execute('''
      CREATE TABLE IF NOT EXISTS courses (
        id  PRIMARY KEY ,
        title TEXT NOT NULL,
        description TEXT,
        teacher_id TEXT NOT NULL,
        FOREIGN KEY (teacher_id) REFERENCES users(id)
      )
    ''');

sqlite.execute('''
      CREATE TABLE IF NOT EXISTS schedule (
        id  PRIMARY KEY ,
        course_id TEXT NOT NULL,
        teacher_id TEXT NOT NULL,
        lesson_date TEXT NOT NULL,
        lesson_time TEXT NOT NULL,
        FOREIGN KEY (course_id) REFERENCES courses(id),
        FOREIGN KEY (teacher_id) REFERENCES users(id)
      )
    ''');
  }
    void dispose() {
    _sqlite.dispose();
  }

}

  CoursesDatabase? _instance;
  Database get sqlite => (_instance ??= CoursesDatabase.inApp()).sqlite;
  void disposeDb() => _instance?.dispose();