import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Utils/SchoolController.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Models/School.dart';

class SchoolSelect extends StatefulWidget {
  @override
  _SchoolSelectState createState() => _SchoolSelectState();
}

class _SchoolSelectState extends State<SchoolSelect> {
  SchoolController schoolController = Get.find();

  Future<List<School>> getSchoolList() async {
    var schools = await context.read<ApiClient>().getSchools();
    return schools;
  }

  @override
  void initState() {
    super.initState();
    getSchoolList().then((value) => setState(() {
          schoolList = value;
          schoolList2 = value;
        }));
  }

  List<School> schoolList;
  List<School> schoolList2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: schoolList2 != null
            ? Column(
                children: [
                  SizedBox(height: 32.0),

                  // Search Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "Keresés",
                            ),
                            onChanged: (pattern) {
                              List<School> results =
                                  schoolController.search(schoolList, pattern);
                              print('${results.length} - ${schoolList.length}');
                              setState(() {
                                schoolList2 = results;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Feather.x),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  // Schools
                  Expanded(
                    child: CupertinoScrollbar(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: schoolList2.length,
                        itemBuilder: (context, int index) {
                          School school = schoolList2[index];
                          return SchoolTile(
                            school.name,
                            school.id,
                            school.city,
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }
}

class SchoolTile extends StatelessWidget {
  final String title;
  final String schoolId;
  final String city;

  SchoolTile(this.title, this.schoolId, this.city);

  @override
  Widget build(BuildContext context) {
    SchoolController schoolController = Get.find();
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        schoolController.select(School(id: schoolId, name: title, city: city));
        Navigator.pop(context);
      },
      child: ListTile(
        title: Text(title),
        subtitle: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                schoolId,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                city,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
