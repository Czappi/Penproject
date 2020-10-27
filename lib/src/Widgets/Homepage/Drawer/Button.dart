import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageDrawerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool selected, disabled;
  final GestureTapCallback onTap;

  const HomepageDrawerButton(
      {@required this.icon,
      @required this.text,
      @required this.selected,
      this.disabled,
      this.onTap});
  /*
   
   */
  @override
  Widget build(BuildContext context) {
    var color = (disabled == true)
        ? Colors.grey
        : (selected)
            ? Colors.white
            : (Get.isDarkMode)
                ? Colors.grey[200]
                : Colors.black;

    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: disabled != true ? onTap ?? () {} : null,
              child: Ink(
                padding: EdgeInsets.fromLTRB(20, 18, 18, 18),
                decoration: BoxDecoration(
                    color: selected
                        ? Get.theme.buttonColor
                        : Get.theme.backgroundColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: color,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        text,
                        style: Get.textTheme.headline5.apply(
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
