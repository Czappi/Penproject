import 'package:flutter/material.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Lessons/Body.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Lessons/Title.dart';

class HomeLessons extends StatelessWidget {
  final List<Lesson> lessons;
  const HomeLessons({this.lessons});

  List<Lesson> _lessons() {
    var l = lessons
        .where((element) => element.end.toUtc().isAfter(DateTime.now().toUtc()))
        .toList()
        .take(3)
        .toList();
    l.removeAt(0);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
        child: Column(
      children: [
        HomeLessonsTitle(
          count: lessons.length ?? 0,
        ),
        HomeLessonsBody(
          lessons: _lessons(),
        ),
      ],
    ));
  }
}
