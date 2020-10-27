import 'package:equatable/equatable.dart';

abstract class LoaderEvent extends Equatable {
  const LoaderEvent();

  @override
  List<Object> get props => [];
}

class Load extends LoaderEvent {}
