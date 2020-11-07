import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Bloc/Home.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Widgets/ErrorWidget.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Absences/Chart.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/AllAverage.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Home/Lessons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomepageHome extends StatefulWidget {
  HomepageHome({Key key}) : super(key: key);

  @override
  _HomepageHomeState createState() => _HomepageHomeState();
}

class _HomepageHomeState extends State<HomepageHome> {
  RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    Get.context.bloc<HomeBloc>().add(Load());
  }

  void _onRefresh() async {
    await Get.context.bloc<HomeBloc>().refreshHome();
    refreshController.refreshCompleted();
    Get.context.bloc<HomeBloc>().add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh,
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<HomeBloc, LoaderState>(builder: (context, state) {
          if (state is Loaded) {
            if (state.data.containsKey('reloaded') != true) {
              return HomepageHomeBody(
                lessons: state.data.containsKey('lessons')
                    ? state.data['lessons']
                    : [],
                absences: state.data.containsKey('absences')
                    ? state.data['absences']
                    : [],
                averages: state.data.containsKey('averages')
                    ? state.data['averages']
                    : [],
              );
            } else {
              Get.context.bloc<HomeBloc>().add(Load());
              return Container();
            }
          } else if (state is Loading) {
            return Container(
              //color: Colors.red,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is LoadError) {
            return PenErrorWidget();
          }
          return Container();
        }));
  }
}

class HomepageHomeBody extends StatelessWidget {
  final List<Lesson> lessons;
  final Map<int, double> averages;
  final List<Map<String, dynamic>> absences;
  const HomepageHomeBody({
    this.lessons,
    this.averages,
    this.absences,
  });

  @override
  Widget build(BuildContext context) {
    var wlist = widgetList(lessons, averages, absences);

    return ListView.builder(
        itemCount: wlist.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(bottom: 30.sp),
            child: wlist[i],
          );
        });
  }
}

List<Widget> widgetList(List<Lesson> lessons, Map<int, double> averages,
    List<Map<String, dynamic>> absences) {
  List<Widget> list = [];

  list.add(HomeLessons(
    lessons: lessons,
  ));

  if (averages.isNotEmpty) {
    list.add(DiaryAllAverage(
      averages: averages,
    ));
  }
  if (absences.isNotEmpty) {
    list.add(AbsencesChart(data: absences));
  }
  return list;
}
