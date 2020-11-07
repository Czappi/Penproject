import 'package:equatable/equatable.dart';

abstract class DownloaderEvent extends Equatable {
  const DownloaderEvent();

  @override
  List<Object> get props => [];
}

class StartDownload extends DownloaderEvent {}

class StartInstall extends DownloaderEvent {}

class CheckUpdate extends DownloaderEvent {}
