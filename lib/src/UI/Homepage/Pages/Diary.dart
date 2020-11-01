import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penproject/src/Bloc/Diary.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/AllAverage.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/SubjectTile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable.dart';

class HomepageDiary extends StatefulWidget {
  HomepageDiary({Key key}) : super(key: key);

  @override
  _HomepageDiaryState createState() => _HomepageDiaryState();
}

class _HomepageDiaryState extends State<HomepageDiary> {
  @override
  void initState() {
    super.initState();
    Get.context.bloc<DiaryBloc>().add(Load());
  }

  RefreshController refreshController = RefreshController(initialRefresh: true);

  void _onRefresh() async {
    await Get.context.bloc<DiaryBloc>().refreshDiary();
    refreshController.refreshCompleted();
    Get.context.bloc<DiaryBloc>().add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
        child: SmartRefresher(
            controller: refreshController,
            onRefresh: _onRefresh,
            child:
                BlocBuilder<DiaryBloc, LoaderState>(builder: (context, state) {
              if (state is Loaded) {
                if (state.data.containsKey('reloaded') != true) {
                  return HomepageDiaryBody(
                    allAverages: state.data['averages'],
                    subjects: state.data['subjectAverages'],
                    rows: state.data['evaltablerows'],
                    isTable: state.data['isTable'],
                  );
                } else {
                  Get.context.bloc<DiaryBloc>().add(Load());
                  return Container();
                }
              } else if (state is Loading) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            })));
  }
}

class HomepageDiaryBody extends StatelessWidget {
  final Map<int, dynamic> allAverages;
  final List<Map<String, dynamic>> subjects;
  final List<DataRow> rows;
  final bool isTable;
  HomepageDiaryBody({this.allAverages, this.subjects, this.rows, this.isTable});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: DiaryAllAverage(
            averages: allAverages,
          ),
        ),
        (isTable)
            ? SliverToBoxAdapter(
                child: Column(
                children: [
                  EvalTable(printSubject: true, dataRows: rows),
                  SizedBox(
                    height: 30,
                  )
                ],
              ))
            : SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 1.2),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return DiarySubjectTile(
                    name: subjects[index]['subjectname'],
                    average: subjects[index]['average'],
                    id: subjects[index]['id'],
                  );
                }, childCount: subjects.length))
      ],
    );
  }
}
