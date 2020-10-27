import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PenErrorWidget extends StatelessWidget {
  const PenErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Feather.alert_triangle,
            size: 64.sp,
          ),
          Text(
            'oops'.tr,
            style: Get.textTheme.headline6.apply(fontSizeFactor: 1.5),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'erroroccurred'.tr,
            style: Get.textTheme.headline6.apply(fontSizeFactor: 1.2),
          ),
        ],
      ),
    );
  }
}
