import 'package:equatable/equatable.dart';

abstract class RoutePageState extends Equatable {
  const RoutePageState();

  @override
  List<Object> get props => [];
}

class RoutePageInitial extends RoutePageState {}

class Loaded extends RoutePageState {
  final Map<String, dynamic> data;

  Loaded(this.data);
}

class Loading extends RoutePageState {}

class LoadError extends RoutePageState {}

class NoNetwork extends RoutePageState {}
