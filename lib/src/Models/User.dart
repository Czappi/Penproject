import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.username,
      this.password,
      this.instituteCode,
      this.id,
      this.loggedIn,
      this.lastLogin,
      this.image});

  final String id;
  final String username;
  final String password;
  final String instituteCode;
  final bool loggedIn;
  final DateTime lastLogin;

  final String image;

  @override
  List<Object> get props =>
      [username, password, instituteCode, id, loggedIn, lastLogin, image];

  @override
  bool get stringify => false;
}
