import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoboxRow extends StatelessWidget {
  final String title, text;
  const InfoboxRow({@required this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.sp),
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "$title: ", style: Get.textTheme.headline6),
        TextSpan(text: "$text"),
      ])),
    );
  }
}
