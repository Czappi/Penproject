import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileIcon extends StatelessWidget {
  final double size;

  ProfileIcon({this.size});

  @override
  Widget build(BuildContext context) {
    return /*Container(
        height: height ?? 44.w,
        width: width ?? 44.w,
        child: */
        IconButton(
      iconSize: size ?? 36.h,
      color: Colors.grey[700],
      icon: Icon(Icons.account_circle),
      onPressed: () {},

      //)
    );
  }
}
