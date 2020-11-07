import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateText extends StatelessWidget {
  const UpdateText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.sp),
      child: Text(
        'newupdate'.tr,
        style: Get.textTheme.headline6,
      ),
    );
  }
}
