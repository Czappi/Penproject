import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<DataColumn> evalTableColumns(bool printSubject) {
  List<DataColumn> columns = [];

  if (printSubject) {
    columns.add(DataColumn(
      label: Text('subject'.tr),
    ));
  }
  columns.addAll([
    DataColumn(
      label: Text('SEPTEMBER'.tr),
    ),
    DataColumn(
      label: Text('OCTOBER'.tr),
    ),
    DataColumn(
      label: Text('NOVEMBER'.tr),
    ),
    DataColumn(
      label: Text('DECEMBER'.tr),
    ),
    DataColumn(
      label: Text('JANUARY'.tr),
    ),
    DataColumn(
      label: Text('FEBRUARY'.tr),
    ),
    DataColumn(
      label: Text('MARCH'.tr),
    ),
    DataColumn(
      label: Text('APRIL'.tr),
    ),
    DataColumn(
      label: Text('MAY'.tr),
    ),
    DataColumn(
      label: Text('JUNE'.tr),
    ),
  ]);
}
