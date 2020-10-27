import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Utils/format.dart';

enum LessonType { basic, substitution, missed }

class HomeLessonTileBody extends StatelessWidget {
  final String teacher, room, title;
  final LessonType type;
  const HomeLessonTileBody({this.title, this.teacher, this.room, this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            capitalize(title),
            style: textStyle(type),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Icon(Feather.user, color: Color(0xff7C7C89)),
              SizedBox(
                width: 10.w,
              ),
              Text(
                teacher.toString(),
                style: Get.textTheme.headline5
                    .apply(color: Color(0xff6D6D7C), fontSizeFactor: 1),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(Feather.map_pin, color: Color(0xff7C7C89)),
              SizedBox(
                width: 10.w,
              ),
              Text(
                room.toString(),
                style: Get.textTheme.headline5
                    .apply(color: Color(0xff6D6D7C), fontSizeFactor: 1),
              )
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle textStyle(LessonType type) {
  switch (type) {
    case LessonType.missed:
      return Get.textTheme.headline6
          .apply(color: Colors.redAccent, fontSizeFactor: 1.0);
      break;
    case LessonType.substitution:
      return Get.textTheme.headline6
          .apply(color: Colors.amber[600], fontSizeFactor: 1.0);
      break;
    default:
      return Get.textTheme.headline6
          .apply(color: Color(0xff4C4C60), fontSizeFactor: 1.0);
  }
}
