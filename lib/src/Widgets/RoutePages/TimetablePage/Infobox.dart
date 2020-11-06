import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/RoutePages/Infobox/CustomInfoboxRow.dart';
import 'package:penproject/src/Widgets/RoutePages/Infobox/InfoboxRow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimetablePageInfobox extends StatelessWidget {
  final Lesson l;
  final Subject s;
  const TimetablePageInfobox(this.l, this.s);

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
      //padding: EdgeInsets.all(5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children(l, s),
      ),
    );
  }
}

List<Widget> children(Lesson l, Subject s) {
  List<Widget> list = [];
  if (l.start != null && l.end != null) {
    list.add(CustomInfoboxRow(
        child: Row(
      children: [
        Icon(Feather.clock,
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.75)
                : Color(0xff7C7C89)),
        SizedBox(
          width: 10.w,
        ),
        Text(
          dateformat(DateFormatType.basic, date: l.start) +
              " - " +
              dateformat(DateFormatType.basic, date: l.end),
          style: Get.textTheme.headline5.apply(
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.75)
                  : Color(0xff6D6D7C),
              fontSizeFactor: 1),
        )
      ],
    )));
  }
  if (l.teacher != null || l.substituteTeacher != null) {
    list.add(CustomInfoboxRow(
        child: Row(
      children: [
        Icon(Feather.user,
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.75)
                : Color(0xff7C7C89)),
        SizedBox(
          width: 10.w,
        ),
        Text(
          (l.substituteTeacher != "")
              ? l.substituteTeacher.toString()
              : l.teacher.toString(),
          style: Get.textTheme.headline5.apply(
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.75)
                  : Color(0xff6D6D7C),
              fontSizeFactor: 1),
        )
      ],
    )));
  }
  if (l.room != "") {
    list.add(CustomInfoboxRow(
        child: Row(
      children: [
        Icon(Feather.map_pin,
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.75)
                : Color(0xff7C7C89)),
        SizedBox(
          width: 10.w,
        ),
        Text(
          l.room.toString(),
          style: Get.textTheme.headline5.apply(
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.75)
                  : Color(0xff6D6D7C),
              fontSizeFactor: 1),
        )
      ],
    )));
  }
  if (list.isNotEmpty) {
    list.add(Divider(
      color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[400],
    ));
  }
  if (s.name != "") {
    list.add(InfoboxRow(
      title: "subject".tr,
      text: "${s.name}",
    ));
  }
  if (l.groupName != "") {
    if (s.id != null)
      list.add(InfoboxRow(
        title: "group".tr,
        text: "${l.groupName}",
      ));
  }
  if (l.description != "") {
    list.add(InfoboxRow(
      title: "description".tr,
      text: "${l.description}",
    ));
  }
  if (l.lessonYearIndex != null) {
    list.add(InfoboxRow(
      title: "lessonyearindex".tr,
      text: "${l.lessonYearIndex}",
    ));
  }

  return list;
}
