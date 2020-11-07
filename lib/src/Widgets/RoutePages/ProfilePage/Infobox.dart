import 'package:flutter/material.dart';
import 'package:penproject/src/Models/Student.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/RoutePages/Infobox/InfoboxRow.dart';
import 'package:get/get.dart';

class ProfilePageInfobox extends StatelessWidget {
  final Student s;
  const ProfilePageInfobox(this.s);

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
      //padding: EdgeInsets.all(5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children(s),
      ),
    );
  }
}

List<Widget> children(Student s) {
  List<Widget> list = [];
  if (s.birth != null) {
    list.add(InfoboxRow(
      title: "birth".tr,
      text: dateformat(DateFormatType.yyyymmdd, date: s.birth),
    ));
  }
  if (s.address != null) {
    list.add(InfoboxRow(
      title: "address".tr,
      text: "${s.address}",
    ));
  }
  if (s.parents != []) {
    list.add(InfoboxRow(title: "parents".tr, text: s.parents.join(", ")));
  }

  return list;
}
