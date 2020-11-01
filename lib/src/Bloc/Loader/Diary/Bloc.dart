import 'package:flutter/material.dart' show DataRow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Student.dart';
import 'package:penproject/src/Bloc/Timetable.dart';
import 'package:connectivity/connectivity.dart';
import 'package:penproject/src/Utils/AverageMath.dart';
import 'package:penproject/src/Utils/SettingsProvider.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable/Rows.dart';
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

        // Settings
        var isTable = Get.context.read<SettingsProvider>().isTable();

        // evaluations
        var evals = await db.readEvaluations();

        if (evals != null) {
          List<DataRow> _evalTableRows = <DataRow>[];
          List<Map<String, dynamic>> subjectaverages = <Map<String, dynamic>>[];
          if (isTable) {
            _evalTableRows =
                await evalTableRows(db, evals: evals, printSubject: true);
          } else {
            subjectaverages = await db.readSubjectAverages();
          }

          var _averages = getAverages(evals);

          yield Loaded({
            'averages': _averages,
            'isTable': isTable,
            'subjectAverages': subjectaverages,
            'evaltablerows': _evalTableRows
          });
        } else {
          yield Loaded(await refreshDiary());
        }
      } catch (e) {
        print("LoaderBloc.DiaryBloc ERROR: $e");
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
