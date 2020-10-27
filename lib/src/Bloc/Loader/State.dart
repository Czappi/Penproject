import 'package:equatable/equatable.dart';

abstract class LoaderState extends Equatable {
  const LoaderState();

  @override
  List<Object> get props => [];
}

class LoaderInitial extends LoaderState {}

class Loaded extends LoaderState {
  final Map<String, dynamic> data;

  Loaded(this.data);
}

class Loading extends LoaderState {}

class LoadError extends LoaderState {}

class NoNetwork extends LoaderState {}
