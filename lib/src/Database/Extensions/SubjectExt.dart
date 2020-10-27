import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:sqflite/sqflite.dart';
import 'Parse.dart';
import 'Values.dart';

extension SubjectExt on DatabaseProvider {
  Future<bool> writeSubjects(List<Subject> subjects) async {
    try {
      var db = await database;
      var batch = db.batch();

      subjects.forEach((e) {
        if (e != null) {
          var values = getSubjectValues(e);
          batch.insert("Subjects", values,
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      });
      batch.commit(noResult: true);
      return true;
    } catch (e) {
      print("DatabaseProvider (writeSubjects) ERROR : $e");
      return false;
    }
  }

  Future<Subject> getSubjectbyId(String id) async {
    try {
      var db = await database;
      var res = await db.query("Subjects", where: "id = ? ", whereArgs: [id]);
      return getSubjectData(res.isNotEmpty ? res.first : null);
    } catch (e) {
      print("DatabaseProvider (getSubjectbyId) ERROR : $e");
      return null;
    }
  }
}
