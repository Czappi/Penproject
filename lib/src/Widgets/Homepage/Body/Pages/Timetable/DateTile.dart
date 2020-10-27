import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimetableDateTile extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final GestureTapCallback onTap;
  const TimetableDateTile({this.date, this.selected, this.onTap});

  String getDayShortname(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'mondayShort'.tr;
        break;
      case 2:
        return 'tuesdayShort'.tr;
        break;
      case 3:
        return 'wednesdayShort'.tr;
        break;
      case 4:
        return 'thursdayShort'.tr;
        break;
      case 5:
        return 'fridayShort'.tr;
        break;
      case 6:
        return 'saturdayShort'.tr;
        break;

      default:
        return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(15.sp)),
            onTap: onTap ?? () {},
            child: Ink(
              decoration: BoxDecoration(
                color: selected
                    ? Get.theme.buttonColor
                    : Get.theme.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              ),
              width: 50.w,
              height: 80.h,
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getDayShortname(date),
                        style: Get.textTheme.bodyText2.apply(
                            color: Colors.grey[400], fontSizeFactor: 0.9),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        date.day.toString(),
                        style: Get.textTheme.headline5.apply(
                            color: selected ? Colors.white : Colors.black87,
                            fontSizeFactor: 1.2),
                      ),
                    ],
                  )),
            )));
  }
}
