import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Utils/format.dart';

enum LessonType { basic, substitution, missed }

class TimetableLessonTileBody extends StatelessWidget {
  final String title, teacher, room, description;
  final LessonType type;
  const TimetableLessonTileBody(
      {this.type, this.title, this.teacher, this.room, this.description});
  /*Container(
      width: ,
      padding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
      margin: EdgeInsets.fromLTRB(30.sp, 10.sp, 10.sp, 40.sp),
      
      child:  */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 10.sp, 40.sp),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.all(Radius.circular(15.sp)),
          child: Ink(
            padding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
            //width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                border: Border.all(color: Colors.grey[300])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(title),
                  style: Get.textTheme.headline6
                      .apply(color: Color(0xff4C4C60), fontSizeFactor: 1.0),
                ),
                type != LessonType.basic
                    ? type == LessonType.missed
                        ? Text(
                            "missedlesson".tr,
                            style: Get.textTheme.bodyText2.apply(
                                color: Colors.redAccent, fontSizeFactor: 0.85),
                          )
                        : Text(
                            "substitution".tr,
                            style: Get.textTheme.bodyText2.apply(
                                color: Colors.amber[600], fontSizeFactor: 0.85),
                          )
                    : description != ""
                        ? Text(
                            description.toString(),
                            style: Get.textTheme.bodyText2.apply(
                                color: Color(0xff6D6D7C), fontSizeFactor: 0.85),
                          )
                        : Container(),
                SizedBox(
                  height: 15.h,
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
          ),
        ),
      ),
    );
  }
}
