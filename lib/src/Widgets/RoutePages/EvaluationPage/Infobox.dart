import 'package:flutter/material.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/RoutePages/Infobox/InfoboxRow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EvaluationPageInfobox extends StatelessWidget {
  final Evaluation e;
  final Subject s;
  const EvaluationPageInfobox(this.e, this.s);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CardFoundation(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children(e, s),
          )),
    );
  }
}

List<Widget> children(Evaluation e, Subject s) {
  List<Widget> list = [];
  if (e.value != null) {
    list.add(InfoboxRow(
      title: "value".tr,
      text: "${e.value.valueName.replaceAll('(', ' (')} ${e.value.weight}%",
    ));
  }
  if (e.teacher != null) {
    list.add(InfoboxRow(
      title: "teacher".tr,
      text: e.teacher,
    ));
  }
  if (s != null) {
    if (s.id != null)
      list.add(InfoboxRow(
        title: "subject".tr,
        text: "${s.name}",
      ));
  }
  if (e.description != null) {
    list.add(InfoboxRow(
      title: "description".tr,
      text: "${e.description}",
    ));
  }
  if (e.mode != null) {
    list.add(InfoboxRow(
      title: "type".tr,
      text: "${e.mode.description}",
    ));
  }
  if (e.evaluationType != null) {
    list.add(InfoboxRow(
      title: "evalform".tr,
      text: "${e.evaluationType.description}",
    ));
  }
  if (e.writeDate != null) {
    list.add(InfoboxRow(
      title: "writedate".tr,
      text: dateformat(DateFormatType.date, date: e.writeDate),
    ));
  }

  return list;
}
