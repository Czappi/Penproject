import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Update/widgets/UpdateButton.dart';
import 'package:penproject/src/Update/widgets/UpdateInfobox.dart';
import 'package:penproject/src/Update/widgets/UpdateText.dart';

class UpdateBottomSheet extends StatelessWidget {
  final String title, body;
  const UpdateBottomSheet({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.sp),
          color: Get.theme.cardColor,
        ),
        child: Column(
          children: [
            UpdateText(),
            SizedBox(
              height: 30.h,
            ),
            UpdateInfobox(
              title: title,
              body: body,
            ),
            SizedBox(
              height: 30.h,
            ),
            UpdateButton(),
            SizedBox(
              height: 30.h,
            ),
          ],
        ));
  }
}
