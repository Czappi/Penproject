import 'package:equatable/equatable.dart';

abstract class DownloaderState extends Equatable {
  const DownloaderState();

  @override
  List<Object> get props => [];
}

class DownloaderInitial extends DownloaderState {}

class Downloading extends DownloaderState {}

class Done extends DownloaderState {
  final String id;
  Done(this.id);
}

class DownloaderError extends DownloaderState {}
