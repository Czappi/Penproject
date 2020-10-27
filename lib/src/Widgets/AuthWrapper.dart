import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/UI/AuthScreen.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    var client = Get.context.read<ApiClient>();
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == ConnectivityResult.mobile ||
              snapshot.data == ConnectivityResult.wifi) {
            if (client.accessToken != null) {
              return child;
            } else {
              return AuthScreen();
            }
          } else {
            if (client.userId == null) {
              return AuthScreen();
            } else {
              return child;
            }
          }
        } else {
          return Container();
        }
      },
    );
  }
}
