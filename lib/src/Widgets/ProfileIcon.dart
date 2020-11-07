import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:provider/provider.dart';

class ProfileIcon extends StatelessWidget {
  final double size;

  ProfileIcon({this.size});

  @override
  Widget build(BuildContext context) {
    var id = Get.context.read<ApiClient>().encryptedName;
    return IconButton(
      iconSize: size ?? 36.h,
      color: Colors.grey[700],
      icon: Icon(Icons.account_circle),
      onPressed: () {
        Get.toNamed("/ProfilePage/$id");
      },
    );
  }
}
