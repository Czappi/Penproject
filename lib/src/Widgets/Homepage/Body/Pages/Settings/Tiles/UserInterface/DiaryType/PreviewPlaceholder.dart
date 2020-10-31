import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviewPlaceholder extends StatelessWidget {
  final double height, width;
  final EdgeInsetsGeometry padding;
  const PreviewPlaceholder({this.height, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? EdgeInsets.all(10.sp),
        child: Ink(
          height: height ?? 10.sp,
          width: width ?? 10.sp,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.sp), color: Colors.grey),
        ));
  }
}
