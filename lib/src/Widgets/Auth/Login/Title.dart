import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreenLoginTitle extends StatelessWidget {
  final double fontSize;
  const AuthScreenLoginTitle({this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      'login'.tr,
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(fontSize: fontSize ?? 12),
    );
  }
}
