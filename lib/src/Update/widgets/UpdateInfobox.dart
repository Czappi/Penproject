import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';

class UpdateInfobox extends StatelessWidget {
  final String title, body;
  const UpdateInfobox({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
        color: Colors.blueAccent[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Get.textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: Text(body),
            ),
          ],
        ));
  }
}
