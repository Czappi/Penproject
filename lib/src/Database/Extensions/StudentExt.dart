import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Models/Student.dart';
import 'package:sqflite/sqflite.dart';
import 'Parse.dart';
import 'Values.dart';

extension StudentExt on DatabaseProvider {
  Future<bool> writeStudent(Student student) async {
    try {
      var db = await database;
      db.insert("Student", getStudentValues(student),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return true;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return false;
    }
  }

  Future<Student> getStudentbyId(String id) async {
    try {
      var db = await database;
      var res = await db.query("Student", where: "id = ?", whereArgs: [id]);
      return getStudentData(res.isNotEmpty ? res.first : null);
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return null;
    }
  }

  Future<Student> getStudentbyName(String name) async {
    try {
      var db = await database;
      var res = await db.query("Student", where: "name = ?", whereArgs: [name]);
      return getStudentData(res.isNotEmpty ? res.first : null);
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return null;
    }
  }

  Future<List<Student>> getStudents() async {
    try {
      var db = await database;
      var res = await db.query("Student");
      List<Student> list = [];
      if (res.isNotEmpty) {
        res.forEach((element) {
          list.add(getStudentData(element));
        });
      }
      return res.isNotEmpty ? list : null;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return null;
    }
  }
}
