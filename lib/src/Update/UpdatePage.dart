import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:penproject/src/Update/Api.dart';
import 'package:penproject/src/Widgets/RoutePages/Foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({Key key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  static bool debug = kDebugMode;
  UpdateSystem updateSystem = UpdateSystem();
  bool _permissionReady = false, done = false;
  double loading = 0;
  String taskId;
  int _index = 0;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _permissionReady = false;

    _prepare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: RoutePageFoundation(
          child: Column(
            children: <Widget>[
              Stepper(
                type: StepperType.vertical,
                steps: <Step>[
                  Step(
                      title: Text("updatedownload".tr),
                      content: Container(
                        child: LinearProgressIndicator(
                          value: loading,
                          backgroundColor: Colors.grey,
                        ),
                      )),
                  Step(
                      title: Text("updateinstall".tr),
                      content: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: FlatButton(
                            color: Get.theme.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.sp),
                            ),
                            onPressed: () async {
                              await FlutterDownloader.open(taskId: taskId);
                            },
                            child: Container(
                              child: Center(
                                  child: Text(
                                "Telepítés",
                                style: Get.textTheme.bodyText2
                                    .apply(color: Colors.white),
                              )),
                              //height: 40.h,
                              //width: 300.w,
                            ),
                          ))),
                ],
                currentStep: _index,
                controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                  if (done == true && _index == 0) {
                    return FlatButton(
                      color: Get.theme.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.sp),
                      ),
                      onPressed: () {
                        setState(() {
                          _index = _index + 1;
                        });
                      },
                      child: Text(
                        "next".tr,
                        style:
                            Get.textTheme.bodyText2.apply(color: Colors.white),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ));
  }

  Future<Null> _prepare() async {
    _permissionReady = await _checkPermission();
    print(_permissionReady);

    if (_permissionReady)
      taskId = await updateSystem
          .downloadRelease(await updateSystem.latestRelease());
  }

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.isGranted;
    if (status) {
      return true;
    } else {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (debug) {
        print('UI Isolate Callback: $data');
      }
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {
        loading = progress / 100;
        taskId = id;
        done = (status == DownloadTaskStatus.complete) ? true : false;
      });
      if (status == DownloadTaskStatus.failed) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }
}
