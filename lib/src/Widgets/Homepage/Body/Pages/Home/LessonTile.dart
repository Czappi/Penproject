import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Tile/Body.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Tile/Divider.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Tile/Time.dart';

class HomeLessonTile extends StatelessWidget {
  final Lesson lesson;
  const HomeLessonTile({this.lesson});

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
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(18.sp),
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(18.sp)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: SizedBox(
                    height: 110,
                    child: Row(
                      children: [
                        HomeLessonTileTime(
                          start: lesson.start,
                        ),
                        HomeLessonTileDivider(),
                        HomeLessonTileBody(
                          title: lesson.name,
                          room: lesson.room,
                          teacher: type != LessonType.substitution
                              ? lesson.teacher
                              : lesson.substituteTeacher,
                          type: type,
                        )
                      ],
                    ),
                  )),
            ),
          )),
    );
  }
}
