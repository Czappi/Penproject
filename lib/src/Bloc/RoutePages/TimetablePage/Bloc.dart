import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/TimetablePage.dart';
import 'package:penproject/src/Utils/AverageMath.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable/Rows.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class TimetablePageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  TimetablePageBloc() : super(RoutePageInitial());

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

          var evals = await db.readEvaluationsbySubjectId(event.id);

          var subject = await db.getSubjectbyId(event.id);

          var lesson = await db.readAllLessons();

          if (evals != null && subject != null) {
            var _evalTableRows =
                await evalTableRows(db, evals: evals, printSubject: false);
            var averages = getAverages(evals);

            yield Loaded({
              'averages': averages,
              'evaltablerows': _evalTableRows,
              'lesson': lesson,
              'subject': subject,
            });
          } else {
            yield Loaded(await refreshTimetablePage());
          }
        } else {
          yield LoadError();
        }
      } catch (e) {
        print("RoutePageBloc.TimetablePage ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshTimetablePage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    if (connectivityResult != ConnectivityResult.none) {
      var res = await client.getEvaluations();
      await db.writeEvaluations(res);
    }
    return {'reloaded': true};
  }
}
