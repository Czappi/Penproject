import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Home.dart';
import 'package:penproject/src/Utils/AverageMath.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class HomeBloc extends Bloc<LoaderEvent, LoaderState> {
  HomeBloc() : super(LoaderInitial());

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
        var midnight = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        Map<String, dynamic> load = {};

        var evals = await db.readEvaluations();
        var todaylessons =
            await db.readLessons(midnight, midnight.add(Duration(hours: 24)));
        var absences = await db.readAbsences();

        if (evals != []) {
          var _averages = getAverages(evals);
          load.addAll({'averages': _averages});
        }
        if (todaylessons != null) {
          load.addAll({'lessons': todaylessons});
        }
        if (absences != null) {
          load.addAll({'absences': absences});
        }

        if (load.isNotEmpty) {
          yield Loaded(load);
        } else {
          yield Loaded(await refreshHome());
        }
      } catch (e) {
        print("LoaderBloc.{$event} ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshHome() async {
    await Get.context.bloc<DiaryBloc>().refreshDiary();
    await Get.context.bloc<TimetableBloc>().refreshTimetable();
    await Get.context.bloc<AbsencesBloc>().refreshAbsences();
    return {'reloaded': true};
  }
}
