import 'package:flutter/material.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Timetable/LessonTile/Body.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Timetable/LessonTile/Header.dart';

class TimetableLessonTile extends StatelessWidget {
  final Lesson lesson;
  const TimetableLessonTile(this.lesson);

  @override
  Widget build(BuildContext context) {
    var type;
    if (lesson.status.name == "Elmaradt") {
      type = LessonType.missed;
    } else if (lesson.substituteTeacher != "") {
      type = LessonType.substitution;
    } else {
      type = LessonType.basic;
    }
    return Column(
      children: [
        TimetableLessonTileHeader(start: lesson.start, end: lesson.end),
        TimetableLessonTileBody(
          title: lesson.name,
          description: lesson.description,
          room: lesson.room,
          teacher: type != LessonType.substitution
              ? lesson.teacher
              : lesson.substituteTeacher,
          type: type,
        )
      ],
    );
  }
}
