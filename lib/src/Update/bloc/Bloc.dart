import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:penproject/src/Update/Api.dart';
import 'package:penproject/src/Update/widgets/UpdateBottomSheet.dart';
import 'package:penproject/src/Update/Bloc.dart';

class DownloaderBloc extends Bloc<DownloaderEvent, DownloaderState> {
  DownloaderBloc() : super(DownloaderInitial());

  UpdateSystem updateSystem = UpdateSystem();

  @override
  Stream<DownloaderState> mapEventToState(
    DownloaderEvent event,
  ) async* {
    if (event is CheckUpdate) {
      try {
        var release = await updateSystem.latestRelease();
        PackageInfo info = await PackageInfo.fromPlatform();

        if (release.tagName != info.packageName) {
          Get.bottomSheet(UpdateBottomSheet(
            title: release.name,
            body: release.body,
          ));
        }
      } catch (e) {
        print("DownloaderBloc.Downloader ERROR: $e");
        yield DownloaderError();
      }
    }
    if (event is StartDownload) {
      try {
        var release = await updateSystem.latestRelease();

        if (release != null) {
          Get.back();
          Get.toNamed("/UpdatePage");
        }
      } catch (e) {
        print("DownloaderBloc.Downloader ERROR: $e");
        yield DownloaderError();
      }
    }
  }
}
