import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Student.dart';
import 'package:penproject/src/Bloc/Timetable.dart';
import 'package:connectivity/connectivity.dart';
import 'package:penproject/src/Utils/AverageMath.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class DiaryBloc extends Bloc<LoaderEvent, LoaderState> {
  DiaryBloc() : super(LoaderInitial());

  final UserDatabase db = UserDatabase.db;
  ApiClient client = Get.context.read<ApiClient>();

  @override
  Stream<LoaderState> mapEventToState(
    LoaderEvent event,
  ) async* {
    if (event is Load) {
      try {
        yield Loading();
        DatabaseProvider db = DatabaseProvider(client.clientId);

        var evals = await db.readEvaluations();

        var subjectaverages = await db.readSubjectAverages();

        if (evals != null) {
          var _averages = getAverages(evals);

          yield Loaded(
              {'averages': _averages, 'subjectAverages': subjectaverages});
        } else {
          yield Loaded(await refreshDiary());
        }
      } catch (e) {
        print("LoaderBloc.{$event} ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshDiary() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    if (connectivityResult != ConnectivityResult.none) {
      var res = await client.getEvaluations();
      await db.writeEvaluations(res);
    }
    return {'reloaded': true};
  }
}
