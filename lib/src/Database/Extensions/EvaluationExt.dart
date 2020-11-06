import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Utils/SchoolStart.dart';
import 'package:sqflite/sqflite.dart';
import 'Parse.dart';
import 'Values.dart';

extension EvaluationExt on DatabaseProvider {
  Future<bool> writeEvaluations(List<Evaluation> lessons) async {
    var db = await database;
    var batch = db.batch();
    try {
      lessons.forEach((e) {
        var values = getEvaluationValues(e);
        batch.insert("Evaluations", values,
            conflictAlgorithm: ConflictAlgorithm.replace);
      });
      await batch.commit(noResult: true);
      return true;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return false;
    }
  }

  Future<List<Evaluation>> readEvaluations() async {
    var db = await database;

    List<Evaluation> all = [];
    try {
      var schoolstart = getSchoolStartDate();
      var res = await db.query('Evaluations',
          where: "date BETWEEN datetime(?) and datetime(?,'+10 month') ",
          whereArgs: [
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        res.forEach((element) {
          all.add(getEvaluationData(element));
        });
      }
      return all;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return [];
    }
  }

  Future<List<Evaluation>> readEvaluationsbySubjectId(String id) async {
    var db = await database;

    List<Evaluation> all = [];
    try {
      var schoolstart = getSchoolStartDate();
      var res = await db.query('Evaluations',
          where:
              "subjectId = ? AND date BETWEEN datetime(?) and datetime(?,'+10 month') ",
          whereArgs: [
            id,
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        res.forEach((element) {
          all.add(getEvaluationData(element));
        });
      }
      return all;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return [];
    }
  }

  Future<Evaluation> readEvaluationsbyId(String id) async {
    var db = await database;

    try {
      var schoolstart = getSchoolStartDate();
      var res = await db.query('Evaluations',
          where:
              "id = ? AND date BETWEEN datetime(?) and datetime(?,'+10 month') ",
          whereArgs: [
            id,
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        return getEvaluationData(res.first);
      }
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return null;
    }
  }

  Future<double> readAllAverages() async {
    var db = await database;

    try {
      var schoolstart = getSchoolStartDate();
      var res = await db.rawQuery(
          "SELECT "
          "round(cast(sum(e.evalValue*e.evalValueWeight/100) / sum(e.evalValueWeight/100) as float), 2) as Average, "
          "FROM "
          "Evaluations e "
          "WHERE "
          "e.evalValue > 0 AND e.date BETWEEN datetime(?) and datetime(?,'+10 month') ;",
          [
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        return res.first['Average'];
      } else {
        print("DatabaseProvider ERROR : empty");
        return null;
      }
      //return all;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return null;
    }
  }

  /*
  var res = await db.rawQuery("SELECT "
          "round(sum(e.evalValue*e.evalValueWeight/100) / cast(sum(e.evalValueWeight/100) as float), 2) as Average, "
          "s.name as SubjectName "
          "FROM "
          "Evaluations e "
          "INNER JOIN Subjects s ON "
          "s.id = e.subjectId "
          "WHERE "
          "e.evalValue > 0 " */

  Future<List<Map<String, dynamic>>> readSubjectAverages() async {
    var db = await database;

    List<Map<String, dynamic>> all = [];
    try {
      //var res = await db.query('Evaluations');
      var schoolstart = getSchoolStartDate();
      var res = await db.rawQuery(
          "SELECT "
          "round(cast(sum(e.evalValue*(e.evalValueWeight/100)) as float) / sum((e.evalValueWeight/100)), 2) as Average, "
          "s.name as SubjectName, "
          "s.id as SubjectId "
          "FROM "
          "Evaluations e "
          "INNER JOIN Subjects s ON "
          "s.id = e.subjectId "
          "WHERE "
          "e.evalValue > 0 AND e.date BETWEEN datetime(?) and datetime(?,'+10 month') "
          "GROUP BY "
          "s.name;",
          [
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        res.forEach((element) {
          all.add({
            "subjectname": element['SubjectName'],
            "average": element['Average'],
            "id": element['SubjectId'],
          });
        });
      }
      return all;
    } catch (e) {
      print("DatabaseProvider ERROR : $e");
      return null;
    }
  }
}
