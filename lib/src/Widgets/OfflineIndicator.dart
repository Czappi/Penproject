import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        height: 50.h,
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text('offlinemode'.tr,
              style: Get.textTheme.headline5
                  .apply(color: Colors.black54, fontSizeFactor: 0.8)),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
