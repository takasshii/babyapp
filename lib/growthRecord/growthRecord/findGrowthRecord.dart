import 'dart:collection';
import 'package:babyapp/growthRecord/addGrowthRecord/addGrowthRecordPage.dart';
import 'package:babyapp/growthRecord/growthRecord/growthRecordDetail.dart';
import 'package:babyapp/growthRecord/growthRecord/growthRecordModel.dart';
import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'babyWeightModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FindGrowthRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PlanListModel>(
              create: (_) => PlanListModel()..fetchPlanList()),
          ChangeNotifierProvider<BabyWeightModel>(
              create: (_) => BabyWeightModel()),
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff181E27),
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "GrowthRecord",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text('体重',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ),
                Tab(
                  child: Text(
                    '身長',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
              indicatorColor: Colors.tealAccent,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(Icons.baby_changing_station), //ここにロゴ置く
                  iconSize: 30,
                  onPressed: () {}, //ここで設定開く
                ),
              ),
            ],
            elevation: 0.0,
          ),
          backgroundColor: Color(0xff181E27),
          body: TabBarView(children: <Widget>[
            Consumer<BabyWeightModel>(
              builder: (context, model, child) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Container(
                            height: 500,
                            padding: EdgeInsets.all(10),
                            child: PointsLineChartWeight.withSampleData(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Consumer<PlanListModel>(
              builder: (context, model, child) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("折れ線グラフ"),
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Container(
                            height: 300,
                            padding: EdgeInsets.all(10),
                            child: PointsLineChartHeight.withSampleData(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]),
          floatingActionButton: Consumer<PlanListModel>(
            builder: (context, model, child) {
              return FloatingActionButton(
                onPressed: () async {
                  final bool? added = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlanPage(),
                      fullscreenDialog: true,
                    ),
                  );
                  if (added != null && added) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.greenAccent,
                      content: Text('投稿が完了しました'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  model.fetchPlanList();
                },
                child: Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}


//ここから体重
class PointsLineChartWeight extends StatelessWidget {
  final List<charts.Series<dynamic, num>> weightList;
  final bool? animate;

  const PointsLineChartWeight(this.weightList, {this.animate});

  factory PointsLineChartWeight.withSampleData() {
    return PointsLineChartWeight(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<LinearWeight, int>> _createSampleData() {
    final data = [
      LinearWeight(0, 2980),
      LinearWeight(1, 4780),
      LinearWeight(2, 5830),
      LinearWeight(3, 6630),
      LinearWeight(4, 7220),
      LinearWeight(5, 7670),
      LinearWeight(6, 8010),
      LinearWeight(7, 8300),
      LinearWeight(8, 8530),
      LinearWeight(9, 8730),
      LinearWeight(10, 8910),
      LinearWeight(11, 9090),
    ];

    return [
      charts.Series<LinearWeight, int>(
        id: 'weight',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        domainFn: (LinearWeight weight, _) => weight.day,
        measureFn: (LinearWeight weight, _) => weight.weight,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(weightList,
        animate: animate,
        defaultRenderer: charts.LineRendererConfig(includePoints: true));
  }
}

class LinearWeight {
  final int day;
  final int weight;
  LinearWeight(this.day, this.weight);
}




//ここから身長
class PointsLineChartHeight extends StatelessWidget {
  final List<charts.Series<dynamic, num>> heightList;
  final bool? animate;

  const PointsLineChartHeight(this.heightList, {this.animate});

  factory PointsLineChartHeight.withSampleData() {
    return PointsLineChartHeight(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<LinearHeight, int>> _createSampleData() {
    final data = [
      LinearHeight(0, 5),
      LinearHeight(1, 25),
      LinearHeight(2, 100),
      LinearHeight(3, 75),
    ];

    return [
      charts.Series<LinearHeight, int>(
        id: 'weight',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        domainFn: (LinearHeight height, _) => height.day,
        measureFn: (LinearHeight height, _) => height.height,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(heightList,
        animate: animate,
        defaultRenderer: charts.LineRendererConfig(includePoints: true));
  }
}

class LinearHeight {
  final int day;
  final int height;
  LinearHeight(this.day, this.height);
}

