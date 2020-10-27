import 'package:penproject/src/Models/Evaluation.dart';

Map<int, double> getAverages(List<Evaluation> evals) {
  List<Evaluation> evaluations = evals
      .where((evaluation) => evaluation.type.name == "evkozi_jegy_ertekeles")
      .toList();

  Map<int, double> avg = {};

  for (var i = 1; i <= 10; i++) {
    int date;
    switch (i) {
      case 1:
        date = 9;
        break;
      case 2:
        date = 10;
        break;
      case 3:
        date = 11;
        break;
      case 4:
        date = 12;
        break;
      case 5:
        date = 1;
        break;
      case 6:
        date = 2;
        break;
      case 7:
        date = 3;
        break;
      case 8:
        date = 4;
        break;
      case 9:
        date = 5;
        break;
      case 10:
        date = 6;
        break;

      default:
        date = 7;
    }
    var e = evaluations.where((element) => element.date.month < date);
    var all = _getAverages(e.toList());
    avg.addAll({i: all});
  }

  return avg;
}

double _getAverages(List<Evaluation> evaluations) {
  /*
    String count5 =
        evaluations.where((e) => e.value.value == 5).length.toString();
    String count4 =
        evaluations.where((e) => e.value.value == 4).length.toString();
    String count3 =
        evaluations.where((e) => e.value.value == 3).length.toString();
    String count2 =
        evaluations.where((e) => e.value.value == 2).length.toString();
    String count1 =
        evaluations.where((e) => e.value.value == 1).length.toString();
    */
  double allAvg = 0;

  if (evaluations.length > 0) {
    evaluations.forEach((e) {
      allAvg += e.value.value * (e.value.weight / 100);
    });

    allAvg = allAvg /
        evaluations.map((e) => e.value.weight / 100).reduce((a, b) => a + b);
  } else {
    allAvg = 0.0;
  }
  return allAvg;
}
