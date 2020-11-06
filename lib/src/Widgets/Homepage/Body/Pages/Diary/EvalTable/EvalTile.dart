import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvalTile extends StatelessWidget {
  final String value, id;
  const EvalTile({@required this.value, this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 3.sp),
      child: Text(value),
    );
  }
}
