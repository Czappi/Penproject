import 'package:flutter/material.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Lessons/Body.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Lessons/Title.dart';

class HomeLessons extends StatelessWidget {
  final List<Lesson> lessons;
  const HomeLessons({this.lessons});

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
        child: Column(
      children: [
        HomeLessonsTitle(
          count: lessons.length ?? 0,
        ),
        HomeLessonsBody(
          lessons: lessons
              .where((element) => element.end.isAfter(DateTime.now()))
              .toList()
              .take(2)
              .toList(),
        ),
      ],
    ));
  }
}
