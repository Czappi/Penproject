import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardElement extends StatelessWidget {
  final Widget child;

  /// Padding inside the box
  ///
  /// default:
  /// ```dart
  /// EdgeInsets.fromLTRB(10, 10, 10, 10)
  /// ```
  final EdgeInsetsGeometry padding;

  /// Color of the box
  ///
  /// default:
  /// ```dart
  /// Get.theme.cardColor
  /// ```
  final Color color;

  const CardElement({@required this.child, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    /*
    return Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: color ?? Get.theme.cardColor,
                child: Padding(
                    padding: padding ?? EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: child))));
        */
    return Padding(
      padding: EdgeInsets.all(8),
      child: Ink(
        width: double.infinity,
        padding: padding ?? EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: color ?? Get.theme.cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: child,
      ),
    );
  }
}
