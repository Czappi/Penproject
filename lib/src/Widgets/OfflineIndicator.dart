import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

class OfflineIndicator extends StatelessWidget {
  final ConnectivityResult connectivityResult;
  const OfflineIndicator(this.connectivityResult);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      switchInCurve: Curves.linear,
      switchOutCurve: Curves.linear,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: buildChild(),
    );
  }

  Widget buildChild() {
    if (connectivityResult == ConnectivityResult.none) {
      return Container(
        width: double.infinity,
        height: 30,
        color: Colors.grey[600],
        child: Center(
          child: Text('offlinemode'.tr,
              style: Get.textTheme.headline5.apply(color: Colors.grey[200])),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
