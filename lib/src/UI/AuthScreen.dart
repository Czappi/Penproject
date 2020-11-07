import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/Auth.dart';
import 'package:penproject/src/UI/Auth/Login.dart';

import 'package:penproject/src/UI/Auth/Splash.dart';
import 'package:penproject/src/UI/Homepage.dart';
import 'package:penproject/src/Widgets/AuthWrapper.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    statusbar();
    Get.context.bloc<AuthBloc>().add(InitAuth());
    super.initState();
  }

  void statusbar() {
    if (Get.isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(411.4, 891.4));
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _buildPage(context, state),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, AuthState state) {
    if (state is AuthInitial) {
      return AuthScreenSplash();
    } else if (state is AuthLogin) {
      return AuthScreenLogin(
        username: state.username ?? null,
        password: state.password ?? null,
        school: state.school ?? null,
      );
    } else if (state is AuthAccount) {
      // TODO: ha több profil van: bejelentkezés
      return Container(
        color: Colors.blue,
      );
    } else if (state is AuthLoggedIn) {
      return AuthWrapper(Homepage());
    } else if (state is AuthError) {
      Get.snackbar('oops'.tr, 'erroroccurred'.tr);
      return AuthScreenLogin();
    } else {
      return Container();
    }
  }
}
