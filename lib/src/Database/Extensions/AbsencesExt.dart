import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Models/Absence.dart';
import 'package:penproject/src/Utils/SchoolStart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supercharged/supercharged.dart';
import 'Values.dart';

extension AbsencesExt on DatabaseProvider {
  Future<bool> writeAbsences(List<Absence> l) async {
    var db = await database;
    var batch = db.batch();
    try {
      l.forEach((e) {
        var values = getAbsenceValues(e);
        batch.insert("Absences", values,
            conflictAlgorithm: ConflictAlgorithm.replace);
      });
      await batch.commit(noResult: true);
      return true;
    } catch (e) {
      print("DatabaseProvider (writeAbsences) ERROR : $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> readAbsences() async {
    try {
      var db = await database;
      var schoolstart = getSchoolStartDate();
      List<Map<String, dynamic>> all = [];
      var res = await db.rawQuery(
          "select SUM(a.typeName = 'hianyzas') as 'absencecount', "
          "SUM(a.typeName = 'HaziFeladatHiany' OR a.typeName = 'Felszereleshiany') as 'misscount', "
          "SUM(a.typeName = 'keses') as 'delaycount', "
          "strftime('%m-%Y', date) as 'month-year' "
          "from Absences as a "
          "where a.date BETWEEN datetime(?) and datetime(?,'+10 month') "
          "group by strftime('%m-%Y', a.date); ",
          [
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        res.forEach((element) {
          String year = element['month-year'].toString().allAfter('-');
          String month = element['month-year'].toString().allBefore('-');
          all.add({
            'count': element['absencecount'] +
                element['misscount'] +
                element['delaycount'],
            'absencecount': element['absencecount'],
            'misscount': element['misscount'],
            'delaycount': element['delaycount'],
            'date': DateTime(int.tryParse(year), int.tryParse(month))
          });
        });
      }
      return all;
    } catch (e) {
      print("DatabaseProvider (readAbsences) ERROR : $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> readAbsencesforTiles() async {
    try {
      var db = await database;
      var schoolstart = getSchoolStartDate();
      List<Map<String, dynamic>> all = [];
      var res = await db.rawQuery(
          "select a.date as date, a.typeName as typename "
          "from Absences as a "
          "where a.date BETWEEN datetime(?) and datetime(?,'+10 month');",
          [
            schoolstart.toUtc().toIso8601String(),
            schoolstart.toUtc().toIso8601String()
          ]);
      if (res.isNotEmpty) {
        res.forEach((element) {
          all.add({
            "date": DateTime.parse(element['date']),
            'typename': element['typename']
          });
        });
      }
      return all;
    } catch (e) {
      print("DatabaseProvider (readAbsencesforTiles) ERROR : $e");
      return null;
    }
  }
}
