import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:penproject/src/Update/Api.dart';
import 'package:penproject/src/Update/widgets/UpdateBottomSheet.dart';
import 'package:penproject/src/Update/Bloc.dart';
import 'package:connectivity/connectivity.dart';

class DownloaderBloc extends Bloc<DownloaderEvent, DownloaderState> {
  DownloaderBloc() : super(DownloaderInitial());

  UpdateSystem updateSystem = UpdateSystem();

  @override
  Stream<DownloaderState> mapEventToState(
    DownloaderEvent event,
  ) async* {
    if (event is CheckUpdate) {
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          var release = await updateSystem.latestRelease();
          PackageInfo info = await PackageInfo.fromPlatform();
          print("${release.tagName} - ${info.version}");
          if (release.tagName != info.version) {
            Get.bottomSheet(UpdateBottomSheet(
              title: release.name,
              body: release.body,
            ));
          }
        }
      } catch (e) {
        print("DownloaderBloc.CheckUpdate ERROR: $e");
        yield DownloaderError();
      }
    }
    if (event is StartDownload) {
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          var release = await updateSystem.latestRelease();

          if (release != null) {
            Get.back();
            Get.toNamed("/UpdatePage");
          }
        }
      } catch (e) {
        print("DownloaderBloc.StartDownload ERROR: $e");
        yield DownloaderError();
      }
    }
  }
}
