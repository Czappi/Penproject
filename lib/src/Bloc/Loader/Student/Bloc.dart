import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Student.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class StudentBloc extends Bloc<LoaderEvent, LoaderState> {
  StudentBloc() : super(LoaderInitial());

  final UserDatabase db = UserDatabase.db;
  ApiClient client = Get.context.read<ApiClient>();

  @override
  Stream<LoaderState> mapEventToState(
    LoaderEvent event,
  ) async* {
    if (event is Load) {
      try {
        yield Loading();

        var data = await loadStudent();

        if (data != null) {
          yield Loaded(data);
        } else {
          yield Loaded(await refreshStudent());
        }
      } catch (e) {
        print("LoaderBloc.StudentBloc ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> loadStudent() async {
    DatabaseProvider db = DatabaseProvider(client.clientId);
    var student = await db.getStudentbyName(client.name);
    return {'student': student};
  }

  Future<Map<String, dynamic>> refreshStudent() async {
    DatabaseProvider db = DatabaseProvider(client.clientId);
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      var student = await client.getStudent();
      db.writeStudent(student);
    }

    return {'reloaded': true};
  }
}
