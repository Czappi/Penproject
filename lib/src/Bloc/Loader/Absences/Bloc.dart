import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:connectivity/connectivity.dart';
import 'package:penproject/src/Bloc/Absences.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class AbsencesBloc extends Bloc<LoaderEvent, LoaderState> {
  AbsencesBloc() : super(LoaderInitial());

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

        var absences = await db.readAbsences();
        var tiledata = await db.readAbsencesforTiles();

        if (absences != null) {
          yield Loaded({
            'absences': absences,
            'absences_tiles': tiledata,
          });
        } else {
          yield Loaded(await refreshAbsences());
        }
      } catch (e) {
        print("LoaderBloc.{$event} ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshAbsences() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    if (connectivityResult != ConnectivityResult.none) {
      var res = await client.getAbsences();
      print("length: ${res.length}");
      await db.writeAbsences(res);
    }
    return {'reloaded': true};
  }
}
