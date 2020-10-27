import 'package:equatable/equatable.dart';

abstract class RoutePageEvent extends Equatable {
  const RoutePageEvent();

  @override
  List<Object> get props => [];
}

class Load extends RoutePageEvent {
  final String id;

  Load(this.id);
}
