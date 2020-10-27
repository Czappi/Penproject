import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreenSplash extends StatefulWidget {
  AuthScreenSplash({Key key}) : super(key: key);

  @override
  _AuthScreenSplashState createState() => _AuthScreenSplashState();
}

class _AuthScreenSplashState extends State<AuthScreenSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 0.9.wp,
                height: 0.9.hp,
                child: Image.asset(
                  "assets/penproject.png",
                  cacheHeight: (0.9.hp).round(),
                  cacheWidth: (0.9.hp).round(),
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            )
          ]),
    );
  }
}
