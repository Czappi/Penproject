import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/ProfilePage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:penproject/src/Utils/generateUIDs.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class ProfilePageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  ProfilePageBloc() : super(RoutePageInitial());

  final UserDatabase db = UserDatabase.db;
  ApiClient client = Get.context.read<ApiClient>();

  @override
  Stream<RoutePageState> mapEventToState(
    RoutePageEvent event,
  ) async* {
    if (event is Load) {
      try {
        yield Loading();

        if (event.id != null) {
          DatabaseProvider db = DatabaseProvider(client.clientId);

          var student = await db.getStudentbyName(decryptName(event.id));

          if (student != null) {
            yield Loaded({
              'student': student,
            });
          } else {
            yield Loaded(await refreshProfilePage());
          }
        } else {
          yield LoadError();
        }
      } catch (e) {
        print("RoutePageBloc.ProfilePage ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshProfilePage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    if (connectivityResult != ConnectivityResult.none) {
      var res = await client.getStudent();
      await db.writeStudent(res);
    }
    return {'reloaded': true};
  }
}
