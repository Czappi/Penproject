import 'package:flutter_screenutil/flutter_screenutil.dart';

extension UtilityExtension on num {
  num get ew => (this * 2.624).w;

  num get eh => (this * 2.155).h;

  num get efs => ScreenUtil().setSp(this * 2.9);

  num get ewp => ScreenUtil.defaultSize.width * this;

  num get ehp => ScreenUtil.defaultSize.height * this;
}
