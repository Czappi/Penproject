import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Models/School.dart';
import 'package:penproject/src/Utils/SchoolController.dart';
import 'package:penproject/src/Widgets/Auth/Login/Form.dart';
import 'package:penproject/src/Widgets/Auth/Login/Title.dart';
import 'package:penproject/src/Widgets/LogoIcon.dart';
import 'package:get/get.dart';

class AuthScreenLogin extends StatelessWidget {
  final String username, password;
  final School school;
  const AuthScreenLogin({this.username, this.password, this.school});

  @override
  Widget build(BuildContext context) {
    Get.put(SchoolController());
    return Scaffold(
        //appBar: AppBar(brightness: Brightness.light,),
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          LogoIcon(
            height: 100.h,
            width: 100.w,
          ),
          Container(
            margin: EdgeInsets.all(45.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45.h,
                ),
                AuthScreenLoginTitle(
                  fontSize: 28.sp,
                ),
                SizedBox(
                  height: 50.h,
                ),
                AuthScreenLoginForm(
                  username: username ?? null,
                  password: password ?? null,
                  school: school ?? null,
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
