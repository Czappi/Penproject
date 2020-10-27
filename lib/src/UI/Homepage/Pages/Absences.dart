import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/Absences.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Absences/Chart.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Absences/Tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

//
class HomepageAbsences extends StatefulWidget {
  HomepageAbsences({Key key}) : super(key: key);

  @override
  _HomepageAbsencesState createState() => _HomepageAbsencesState();
}

class _HomepageAbsencesState extends State<HomepageAbsences> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.context.bloc<AbsencesBloc>().add(Load());
    super.initState();
  }

  void _onRefresh() async {
    await Get.context.bloc<AbsencesBloc>().refreshAbsences();
    refreshController.refreshCompleted();
    Get.context.bloc<AbsencesBloc>().add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh,
        child:
            BlocBuilder<AbsencesBloc, LoaderState>(builder: (context, state) {
          if (state is Loaded) {
            if (state.data.containsKey('reloaded') != true) {
              if (state.data['absences'] != null) {
                //print(state.data['absences']);
                return HomepageAbsencesBody(
                  data: state.data['absences'] ?? [],
                  list: state.data['absences_tiles'] ?? [],
                );
              } else {
                return Container(
                  child: Center(
                    child: Text(
                      'noabsences'.tr,
                      style: Get.textTheme.headline6,
                    ),
                  ),
                );
              }
            } else {
              Get.context.bloc<AbsencesBloc>().add(Load());
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
        }));
  }
}

class HomepageAbsencesBody extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final List<Map<String, dynamic>> list;

  const HomepageAbsencesBody({
    this.list,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: AbsencesChart(data: data ?? []),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return AbsencesTile(
              typename: list[itemIndex]['typename'],
              date: list[itemIndex]['date'],
            );
          }
          return Divider(height: 0, color: Colors.grey);
        }, semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        }, childCount: math.max(0, list.length * 2 - 1)))
      ],
    );
  }
}
