import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  final double width;
  final double height;
  const LogoIcon({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      child: Image.asset(
        "assets/penproject.png",
        cacheHeight: height.toInt() ?? 100,
        cacheWidth: width.toInt() ?? 100,
      ),
    );
  }
}
