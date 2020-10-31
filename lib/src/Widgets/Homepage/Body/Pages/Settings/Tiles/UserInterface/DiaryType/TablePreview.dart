import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Settings/Tiles/UserInterface/DiaryType/PreviewPlaceholder.dart';

class TablePreview extends StatelessWidget {
  const TablePreview({Key key}) : super(key: key);

  static Widget placeholder = PreviewPlaceholder(
    height: 10.sp,
    width: 20.sp,
    padding: EdgeInsets.only(bottom: 6.sp, right: 8.sp),
  );

  @override
  Widget build(BuildContext context) {
    return Ink(
      //height: 200.sp,
      width: 190.sp,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.sp), color: Colors.grey[800]),
      child: Column(
        children: [
          Row(
            children: [
              placeholder,
              placeholder,
              placeholder,
            ],
          ),
          Row(
            children: [
              placeholder,
              placeholder,
              placeholder,
            ],
          ),
          Row(
            children: [
              placeholder,
              placeholder,
              placeholder,
            ],
          ),
          Row(
            children: [
              placeholder,
              placeholder,
              placeholder,
            ],
          ),
        ],
      ),
    );
  }
}
