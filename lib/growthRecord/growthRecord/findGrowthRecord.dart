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
                "ToDo",
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
                      Text("折れ線グラフ"),
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
                            height: 500,
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

  PointsLineChartWeight(this.weightList, {this.animate});

  factory PointsLineChartWeight.withSampleData() {
    return new PointsLineChartWeight(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<LinearWeight, int>> _createSampleData() {
    final data = [
      new LinearWeight(0, 5),
      new LinearWeight(1, 25),
      new LinearWeight(2, 100),
      new LinearWeight(3, 75),
    ];

    return [
      new charts.Series<LinearWeight, int>(
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
    return new charts.LineChart(weightList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
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

  PointsLineChartHeight(this.heightList, {this.animate});

  factory PointsLineChartHeight.withSampleData() {
    return new PointsLineChartHeight(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<LinearHeight, int>> _createSampleData() {
    final data = [
      new LinearHeight(0, 5),
      new LinearHeight(1, 25),
      new LinearHeight(2, 100),
      new LinearHeight(3, 75),
    ];

    return [
      new charts.Series<LinearHeight, int>(
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
    return new charts.LineChart(heightList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }
}

class LinearHeight {
  final int day;
  final int height;
  LinearHeight(this.day, this.height);
}

