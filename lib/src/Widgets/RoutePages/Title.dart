import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoutePageTitle extends StatelessWidget {
  final String title;
  const RoutePageTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.sp, bottom: 20.sp),
      child: Text(
        title,
        style: Get.textTheme.headline6.apply(fontSizeFactor: 1.3),
      ),
    );
  }
}
