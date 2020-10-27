import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoutePageFoundation extends StatelessWidget {
  final Widget child;
  const RoutePageFoundation({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.sp),
              topRight: Radius.circular(18.sp)),
          color: Get.theme.backgroundColor),
      child: child ?? Container(),
    );
  }
}
