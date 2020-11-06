import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:provider/provider.dart';
import 'package:penproject/src/Models/School.dart';

class SchoolController {
  School school;

  static String specialChars(String s) => s
      .replaceAll("é", "e")
      .replaceAll("á", "a")
      .replaceAll("ó", "o")
      .replaceAll("ő", "o")
      .replaceAll("ö", "o")
      .replaceAll("ú", "u")
      .replaceAll("ű", "u")
      .replaceAll("ü", "u")
      .replaceAll("í", "i");

  select(School selected) {
    school = selected;
  }

  Future<School> getbyId(String id) async {
    var schools = await Get.context.read<ApiClient>().getSchools();

    return schools.firstWhere((element) => element.id == id);
  }

  search(List<School> all, String pattern) {
    pattern = specialChars(pattern.toLowerCase());
    if (pattern == "") return all;

    List<School> results = [];

    all.forEach((item) {
      int contains = 0;

      pattern.split(" ").forEach((variation) {
        if (specialChars(item.name.toLowerCase()).contains(variation)) {
          contains++;
        }
      });

      if (contains == pattern.split(" ").length) results.add(item);
    });

    results.sort((a, b) => a.name.compareTo(b.name));

    return results;
  }
}
