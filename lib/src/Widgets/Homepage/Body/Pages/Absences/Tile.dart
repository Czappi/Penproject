import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Utils/format.dart';

enum AbsencesTileType { absence, miss, delay }

class AbsencesTile extends StatelessWidget {
  final String typename;
  final DateTime date;
  const AbsencesTile({this.typename, this.date});

  // alert-circle késés
  // x-circle hiányzás
  // minus-circle hiány

  @override
  Widget build(BuildContext context) {
    String text;
    IconData icon;
    switch (typename) {
      case "hianyzas":
        text = "absence".tr;
        icon = Feather.x_circle;
        break;
      case "keses":
        text = "delay".tr;
        icon = Feather.alert_circle;
        break;
      case "HaziFeladatHiany":
        text = "miss".tr;
        icon = Feather.minus_circle;
        break;
      case "Felszereleshiany":
        text = "miss".tr;
        icon = Feather.minus_circle;
        break;

      default:
        text = "absence".tr;
        icon = Feather.x_circle;
    }
    return Container(
      //height: 50.h,
      child: Row(
        children: [
          Ink(
            padding: EdgeInsets.all(15.sp),
            child: Icon(
              icon,
              size: 40.sp,
              color: Get.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          Expanded(
            child: Ink(
              padding: EdgeInsets.fromLTRB(0, 20.sp, 0, 15.sp),
              child: Text(text, style: Get.textTheme.headline5),
            ),
          ),
          Ink(
            padding: EdgeInsets.fromLTRB(0, 20.sp, 10.sp, 15.sp),
            child: Text(
              dateformat(DateFormatType.date, date: date),
              style: Get.textTheme.headline5,
            ),
          )
        ],
      ),
    );
  }
}
