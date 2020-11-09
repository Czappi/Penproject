import 'package:penproject/src/Database/Database.dart';
import 'package:sqflite/sqflite.dart';
import 'Values.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'Parse.dart';

extension LessonExt on DatabaseProvider {
  Future<bool> writeLessons(List<Lesson> lessons) async {
    var db = await database;
    var batch = db.batch();
    try {
      if (lessons != null) {
        lessons.forEach((e) {
          //print(e.props);
          if (e != null) {
            var values = getLessonValues(e);
            batch.insert("Lessons", values,
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
        });
        await batch.commit(noResult: true);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("DatabaseProvider (writeLessons) ERROR : $e");
      return false;
    }
  }

  Future<List<Lesson>> readAllLessons() async {
    try {
      var db = await database;
      var res = await db.query("Lessons");
      List<Lesson> list = [];
      if (res.isNotEmpty) {
        res.forEach((element) async {
          list.add(getLessonData(element));
        });
      }

      return list;
    } catch (e) {
      print("DatabaseProvider (readAllLessons) ERROR : $e");
      return null;
    }
  }

  Future<List<Lesson>> readLessons(DateTime from, DateTime to) async {
    try {
      var db = await database;
      var res = await db.query("Lessons",
          where: "date(start) BETWEEN date(?) AND date(?)",
          whereArgs: [
            from.toUtc().toIso8601String(),
            to.toUtc().toIso8601String()
          ]);
      List<Lesson> list = [];
      if (res.isNotEmpty) {
        res.forEach((element) async {
          list.add(getLessonData(element));
        });
      }

      return list;
    } catch (e) {
      print("DatabaseProvider (readLessons) ERROR : $e");
      return null;
    }
  }

  Future<List<Lesson>> readTodayLessons() async {
    try {
      var db = await database;
      var res = await db.query(
        "Lessons",
        where: "date(start) =date('now')",
      );
      List<Lesson> list = [];
      if (res.isNotEmpty) {
        res.forEach((element) async {
          list.add(getLessonData(element));
        });
      }

      return list;
    } catch (e) {
      print("DatabaseProvider (readLessons) ERROR : $e");
      return null;
    }
  }

  Future<Lesson> readLessonbyUid(String uid) async {
    try {
      var db = await database;
      var res = await db.query("Lessons", where: "uid = ?", whereArgs: [uid]);
      if (res.isNotEmpty)
        return getLessonData(res.first);
      else
        return null;
    } catch (e) {
      print("DatabaseProvider (readLessons) ERROR : $e");
      return null;
    }
  }

  Future<void> deleteLessons() async {
    try {
      var db = await database;

      await db.delete("Lessons");
    } catch (e) {
      print("DatabaseProvider (deleteLessons) ERROR : $e");
    }
  }

  Future<void> deleteOldLessons() async {
    try {
      var db = await database;

      await db.delete("Lessons", where: "date(start) <= date('now','-14 day')");
      //print(result);
    } catch (e) {
      print("DatabaseProvider (deleteOldLessons) ERROR : $e");
    }
  }
}
