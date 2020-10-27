import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/User.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitAuth extends AuthEvent {}

class LoginAuth extends AuthEvent {
  final User user;

  LoginAuth(this.user);
}
