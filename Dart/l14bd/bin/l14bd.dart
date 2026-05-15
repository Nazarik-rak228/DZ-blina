
// // ignore_for_file: unused_import

// import 'dart:vmservice_io';

// import 'package:sqlite3/sqlite3.dart';
// import 'package:path/path.dart' as p ;
// import 'dart:io';

// abstract class Id{
//     String get id;
// }
// class Client implements Id{
//     @override
//     final String id;
//     final String name;
//     final String phone;
//     // нужна константа, ведь используем файнал
//     const Client ({
//         required this.id, 
//         required this.name,
//         required this.phone
//         });
//         Map<String,dynamic> toMap()=> {
//             "id":id,
//             "name":name,
//             "phone":phone
//         };
//     factory Client.from(Map<String,dynamic> map){
//         return Client(id: map["id"] as String,
//         name: map["name"] as String,
//          phone: map["phone"] as String);
//     }
// }

// class Service implements Id{
//     @override
//     final String id;
//     final String title;
//     final String discription;
//     final int durationMinutes;
//     final double price;
//     // нужна константа, ведь используем файнал
//     const Service ({
//         required this.id, 
//         required this.title,
//         required this.discription,
//         required this.durationMinutes,
//         required this.price
//         });
//         Map<String,dynamic> toMap()=> {
//             "id":id,
//             "title":title,
//             "discription":discription,
//             "durationMinutes":durationMinutes,
//             "price":price
//         };
//     factory Service.from(Map<String,dynamic> map){
//         return Service(
//             id: map["id"] as String, 
//             title: map["title"] as String, 
//             discription: map["discription"] as String, 
//             durationMinutes: _asInt( map["durationMinutes"]),
//             price: _asDouble( map["price"]as double)
//             );
//     }
//     static int _asInt(Object? v){
//         if (v is int){
//             return v.toInt();
//         }
//         if(v is num){
//             return v.toInt();
//         }
//         throw FormatException("Ожидалось число", v);
//     }
//     static double _asDouble(Object? vs){
//         if (vs is double){
//             return vs.toDouble();
//         }

//         throw FormatException("Ожидалось число с плавающей точкой", vs);
//     }
// }
// class Appointment implements Id{
//   @override
//   final String id;
//   final DateTime time;
//   final String clientId;
//   final String serviceId;
  
//   const Appointment(
//     {
//       required this.id,
//       required this.time,
//       required this.clientId,
//       required this.serviceId
//     }
//   );
//   Map<String,dynamic> toMap()=> {
//             "id":id,
//             "time":time.toIso8601String(),
//             "clientId":clientId,
//             "serviceId":serviceId
//         };
//     factory Appointment.fromMap(Map<String,dynamic> map){
//         return Appointment(
//             id: map["id"] as String, 
//             time:DateTime.parse(map["time"] as String), 
//             clientId: map["clientId"] as String, 
//             serviceId:map["serviceId"] as String,

//             );
//     }


// }

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
  
  
  
//    void _createTables(){
//     sqlite.execute('''
//     CREATE TABLE IF NOT EXISTS Client(
//     id PRIMARY KEY,
//     name TEXT NOT NULL,
//     phone TEXT NOT NULL)

// ''');
// sqlite.execute('''
//     CREATE TABLE IF NOT EXISTS Service (
//     id PRIMARY KEY,
//     title TEXT NOT NULL,
//     discription TEXT NOT NULL,
//     durationMinutes INT NOT NULL,
//     price REAL NOT NULL
//     )

// ''');
// sqlite.execute('''
//     CREATE TABLE IF NOT EXISTS Appointment (
//     id PRIMARY KEY,
//     time TEXT NOT NULL,
//     clientId TEXT NOT NULL,
//     serviceId TEXT NOT NULL,
//     FOREIGN KEY (clientId) REFERENCES Client(id) ON DELETE CASCADE,
//     FOREIGN KEY (serviceId) REFERENCES Service (id) ON DELETE CASCADE
//     )

// ''');
//    }// nenf ,skb rkbtyns
//    void insertClient(Client client){
//     sqlite.execute(" INSERT OR REPLACE INTO Client (id,name,phone) VALUES(?,?,?)",[client.id,client.name,client.phone]);
//    }

//    List<Client> getAllClients(){
//     final result = sqlite.select('SELECT * FROM Client');
//     return result.map((row)=> Client.from(row)).toList();
//    }
//    Client? getClient(String id){
//     final result = sqlite.select('SELECT * FROM Client WHERE id=?', [id]);
//     return result.isNotEmpty ? Client.from(result.first) : null;
//    }
//    void updateClient(Client client){
//     sqlite.execute("UPDATE Client SET name=?, phone=? WHERE id=?", [client.name,client.phone,client.id]);
//    }
//    void deleteClient(Client client){
//     sqlite.execute('DELETE FROM Client WHERE id=?',[client.id]);
//    }// далье сервис
//    void insertService(Service client){
//     sqlite.execute("INSERT OR REPLACE INTO Service (id,title,discription,durationMinutes,price) VALUES(?,?,?,?,?)",
//   [client.id, client.title, client.discription, client.durationMinutes, client.price]);
//    }

//    List<Service> getAllService(){
//     final result = sqlite.select('SELECT * FROM Service');
//     return result.map((row)=> Service.from(row)).toList();
//    }
//    Service? getService(String id){
//     final result = sqlite.select('SELECT * FROM Service WHERE id=?', [id]);
//     return result.isNotEmpty ? Service.from(result.first) : null;
//    }
//    void updateService(Service client){
//     sqlite.execute("UPDATE Service SET title=?, discription=?, durationMinutes =?,price=?  WHERE id=?", [client.title,client.discription,client.durationMinutes,client.price, client.id]);
//    }
//    void deleteService(Service client){
//     sqlite.execute('DELETE FROM Service WHERE id=?',[client.id]);
//    }
//    // afddasasddasdassda

//    void insertAppointment(Appointment app){
//     sqlite.execute(" INSERT OR REPLACE INTO Appointment (id,time,clientId,serviceId) VALUES(?,?,?)", [app.id,app.time,app.clientId,app.serviceId]);
//    }
//    List<Appointment> getAllAppointment(Client client){
//     final result = sqlite.select('SELECT * FROM Appointment WHERE clientId=? ',[client.id]);
//     return result.map((row)=> Appointment.fromMap(row)).toList();
//    }
//    Appointment? getAppointment(String id){
//     final result = sqlite.select('SELECT * FROM Appointment WHERE id=?', [id]);
//     return result.isNotEmpty ? Appointment.fromMap(result.first) : null;
//    }
//    void updateAppointment(Appointment client){
//     sqlite.execute("UPDATE Appointment SET time=?, clientId=?, serviceId =? WHERE id=?", [client.time,client.clientId,client.serviceId,client.id]);
//    }
//    void deleteAppointment(Appointment client){
//     sqlite.execute('DELETE FROM Appointment WHERE id=?',[client.id]);
//    }
//    // закрытие соединения 
//   void dispose() {          
//   _sqlite.dispose();     
// }
// }
// void main(){
//     final db = SalonDataBase.inApp();
//     final client= Client(id: "1", name: "sas", phone: "12");
//     db.insertClient(client);
    
// }
// // я забыл как включать скл лайт

// import 'package:sqlite3/sqlite3.dart';
// import 'package:path/path.dart' as p;
// import 'dart:io';
// import 'package:l14bd/Data/database.dart';
// import 'package:l14bd/Data/repositories.dart';





// void main() {
//   final db = CoursesDatabase.inApp();

//   final role = Role(id: "1", name: "admin");
//   db.insertRole(role);


//   final user = User(
//     id: "1",
//     fullName: "Sas",
//     email: "Sas@mail.com",
//     login: "Sas",
//     password: "Sas12345",
//     roleId: "1",
//     createdAt: DateTime.now().toIso8601String(),
//   );
//   // что за автокомент сверху?

//   db.insertUser(user);


//   final users = db.getAllUsers();
//   for (final u in users) {
//     print('${u.fullName} (${u.login})');
//   }

//   db.dispose();
import "package:l14bd/CLI/menu.dart";

void main() {
  ShowMainMenu();
}