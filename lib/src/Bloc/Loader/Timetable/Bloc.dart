import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Timetable.dart';
import 'package:connectivity/connectivity.dart';
import 'package:penproject/src/Models/Day.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Models/Week.dart';
import 'package:penproject/src/Utils/TimetableBuilder.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class TimetableBloc extends Bloc<LoaderEvent, LoaderState> {
  TimetableBloc() : super(LoaderInitial());

  final UserDatabase db = UserDatabase.db;
  ApiClient client = Get.context.read<ApiClient>();

  @override
  Stream<LoaderState> mapEventToState(
    LoaderEvent event,
  ) async* {
    if (event is Load) {
      try {
        yield Loading();

        var data = await loadTimetable();

        if (data != null) {
          yield Loaded(data);
        } else {
          yield Loaded(await refreshTimetable());
        }
      } catch (e) {
        print("LoaderBloc (Timetable) ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshTimetable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    TimetableBuilder timetableBuilder = TimetableBuilder();
    var weekdates = timetableBuilder.getWeek(timetableBuilder.getCurrentWeek());

    if (connectivityResult != ConnectivityResult.none) {
      //await db.deleteLessons();
      var lessons = await client.getLessons(
          weekdates['currentstart'], weekdates['currentend']);
      lessons.addAll(await client.getLessons(
          weekdates['nextstart'], weekdates['nextend']));

      if (lessons.isNotEmpty) {
        await db.writeLessons(lessons);
        await db.writeSubjects(lessons.map((e) => e.subject).toList());
      }
    }
    return {'reloaded': true};
  }

  Future<Map<String, dynamic>> loadTimetable() async {
    try {
      DatabaseProvider db = DatabaseProvider(client.clientId);

      TimetableBuilder timetableBuilder = TimetableBuilder();
      var weekdates =
          timetableBuilder.getWeek(timetableBuilder.getCurrentWeek());
      //await db.deleteLessons();
      var lessons = await db.readLessons(
          weekdates['currentstart'], weekdates['currentend']);

      if (lessons.isNotEmpty) {
        Week week = getWeek(lessons.toList(), weekdates['currentstart'],
            weekdates['currentend']);

        return {'week': week};
      } else {
        return {
          'week': Week(
              start: weekdates['currentstart'],
              end: weekdates['currentend'],
              days: [])
        };
      }
    } catch (e) {
      print("LoaderBloc.loadTimetable ERROR: $e");
      return {};
    }
  }

  Week getWeek(List<Lesson> lessons, DateTime start, DateTime end) {
    List<Day> days = [];
    lessons.toList().sort((a, b) => a.start.compareTo(b.start));

    lessons.forEach((lesson) {
      var lessonstart = lesson.start ?? lesson.date;
      print(lesson.date.toString());

      if (!days.any((d) => d.lessons.any((l) {
            var lstart = l.start != null ? l.start : l.date;
            return lstart.toLocal().weekday == lessonstart.toLocal().weekday;
          }))) {
        days.add(Day(date: lessonstart.toLocal(), lessons: []));
      }
      days.last.lessons.add(lesson);
    });

    days.sort((a, b) => a.date.compareTo(b.date));

    Week week = Week(start: start, end: end, days: days);

    return week;
  }
}

/*
Future<Map<String, dynamic>> () async {
    
    return ;
  } */

/*
try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          
        } else {
          yield NoNetwork();
        }
      } catch (e) {
        print("LoaderBloc.{event} ERROR: $e");
        yield LoadError();
      }
    } */
