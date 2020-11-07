import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Widgets/RestartWidget.dart';
import 'package:provider/provider.dart';
import 'package:penproject/src/Bloc/Auth.dart';

class ProfilePageLogoutButton extends StatelessWidget {
  const ProfilePageLogoutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: FlatButton(
        onPressed: () async {
          var id = Get.context.read<ApiClient>().userId;
          await Get.context.bloc<AuthBloc>().db.signout(id);
          RestartWidget.restartApp(Get.context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.sp)),
        color: Get.theme.buttonColor,
        height: 60.h,
        child: Center(
          child: Text(
            'logout'.tr,
            style: Get.textTheme.headline6
                .apply(color: Colors.white, fontSizeFactor: 0.8),
          ),
        ),
      ),
    );
  }
}
