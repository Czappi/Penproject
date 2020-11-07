import 'package:github/github.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ext_storage/ext_storage.dart';

class UpdateSystem {
  var github = GitHub();

  Future<Release> latestRelease() async {
    var release = await github.repositories
        .getLatestRelease(RepositorySlug("Czappi", "Penproject-updates"));
    return release;
  }

  Future<String> downloadDir() async {
    return await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }

  Future<String> downloadRelease(Release release) async {
    var asset = release.assets.firstWhere((element) =>
        element.contentType == "application/vnd.android.package-archive");

    var downloadLink = asset.browserDownloadUrl;
    var name = asset.name;
    print(name);
    var taskId = await FlutterDownloader.enqueue(
        url: downloadLink,
        fileName: name,
        savedDir: await downloadDir(),
        showNotification: true,
        openFileFromNotification: true);

    return taskId;
  }
}
