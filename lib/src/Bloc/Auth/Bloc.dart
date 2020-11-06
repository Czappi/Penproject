import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Utils/SchoolController.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import 'package:penproject/src/Bloc/Auth.dart';
import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Models/User.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final UserDatabase db = UserDatabase.db;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    ApiClient client = Get.context.read<ApiClient>();
    if (event is InitAuth) {
      try {
        List<User> users = await db.getUsers();

        if (users.isNotEmpty) {
          if (users.where((element) => element.loggedIn == true).length >= 1) {
            yield AuthAccount(users);
          } else {
            var lastUser = await db.getUserbyLastLoggedIn();

            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult != ConnectivityResult.none) {
              var loggedin = await client.login(lastUser);
              if (loggedin == true) {
                await db.login(
                    user: lastUser, name: client.name, userid: client.userId);
                yield AuthLoggedIn();
              } else {
                Get.snackbar('loginwrongTitle'.tr, 'loginwrongMsg'.tr);
                yield AuthLogin(
                    username: lastUser.username,
                    password: lastUser.password,
                    school: await SchoolController()
                        .getbyId(lastUser.instituteCode));
              }
            } else {
              client.fillLoginData(lastUser);
              yield AuthLoggedIn();
            }
          }
        } else {
          yield AuthLogin();
        }
      } catch (e) {
        yield AuthError();
        print("AuthBloc ERROR: $e");
      }
    } else if (event is LoginAuth) {
      try {
        if (event.user != null) {
          yield AuthLoading();
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult != ConnectivityResult.none) {
            var ready = await client.login(event.user);
            if (ready) {
              await db.login(
                  user: event.user, name: client.name, userid: client.userId);
              yield AuthLoggedIn();
            } else if (ready == false) {
              Get.snackbar('loginwrongTitle'.tr, 'loginwrongMsg'.tr);
              yield AuthLogin();
            } else {
              Get.snackbar('oops'.tr, 'erroroccurred'.tr);
              yield AuthLogin();
            }
          } else {
            Get.snackbar('connectionerror'.tr, 'nonetwork'.tr);
            yield AuthLogin();
          }
        } else {
          yield AuthError();
        }
      } catch (e) {
        yield AuthError();
        print("AuthBloc ERROR: $e");
      }
    }
  }
}
