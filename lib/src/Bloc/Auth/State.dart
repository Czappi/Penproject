import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/School.dart';
import 'package:penproject/src/Models/User.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLogin extends AuthState {
  final String username, password;
  final School school;
  AuthLogin({this.username, this.password, this.school});
}

class AuthAccount extends AuthState {
  final List<User> users;

  AuthAccount(this.users);
}

class AuthLoggedIn extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}
