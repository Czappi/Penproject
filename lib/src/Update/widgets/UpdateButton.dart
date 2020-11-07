import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penproject/src/Update/Bloc.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: FlatButton(
        onPressed: () {
          Get.context.bloc<DownloaderBloc>().add(StartDownload());
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.sp)),
        color: Get.theme.buttonColor,
        height: 60.h,
        child: Center(
          child: Text(
            'update'.tr,
            style: Get.textTheme.headline6
                .apply(color: Colors.white, fontSizeFactor: 0.8),
          ),
        ),
      ),
    );
  }
}
