import 'package:flutter/material.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/LessonTile.dart';
import 'package:get/get.dart';

class HomeLessonsBody extends StatelessWidget {
  final List<Lesson> lessons;
  const HomeLessonsBody({this.lessons});

  @override
  Widget build(BuildContext context) {
    if (lessons.isNotEmpty) {
      return Column(
        children: widgetBuilder(lessons),
      );
    } else {
      return SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(
          child: Text('nomorelessons'.tr),
        ),
      );
    }
  }
}

List<Widget> widgetBuilder(List<Lesson> l) {
  List<Widget> list = [];
  for (var item in l) {
    list.add(HomeLessonTile(
      lesson: item,
    ));
  }
  return list;
}
