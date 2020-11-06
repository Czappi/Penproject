import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/UI/RoutePages/EvaluationPage.dart';
import 'package:penproject/src/Utils/ErrorSnackbar.dart';

class EvalTile extends StatelessWidget {
  final String value, id;
  const EvalTile({@required this.value, this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (id != null)
          Get.bottomSheet(EvaluationPage());
        else
          errorSnackbar();
      },
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Text(value),
      ),
    );
  }
}
