import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardFoundation extends StatelessWidget {
  final Widget child;

  /// Padding inside the box
  ///
  /// default:
  /// ```dart
  /// EdgeInsets.all(8.sp)
  /// ```
  final EdgeInsetsGeometry padding, margin;

  /// Color of the box
  ///
  /// default:
  /// ```dart
  /// Get.theme.cardColor
  /// ```
  final Color color;

  const CardFoundation(
      {@required this.child, this.padding, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    /*
    return Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: color ?? Get.theme.cardColor,
                child: Padding(
                    padding: padding ?? EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: child))));
        */
    return Padding(
        padding: margin ?? EdgeInsets.all(8.sp),
        child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18.sp),
              ),
              color: color ?? Get.theme.cardColor, //Color(0xff232d37)
            ),
            padding: padding ?? EdgeInsets.all(8.sp),
            child: child));
  }
}
