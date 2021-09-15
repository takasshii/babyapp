import 'package:babyapp/ToDo/addToDo/addPlanPage.dart';
import 'package:babyapp/ToDo/plans/planDetail.dart';
import 'package:babyapp/ToDo/plans/plansModel.dart';
import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlanListModel>(
            create: (_) => PlanListModel()..fetchPlanList()),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
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
        ),
        backgroundColor: Color(0xff181E27),
        body: Consumer<PlanListModel>(
          builder: (context, model, child) {
            final List<ToDo>? plans = model.plans;

            if (plans == null) {
              return Center(child: CircularProgressIndicator());
            }

            final List<Widget> widgets = plans
                .map(
                  (plan) => Padding(
                    padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.black.withOpacity(0.7)),
                      child: ListTile(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanDetail(plan),
                            ),
                          );
                          model.fetchPlanList();
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: IconButton(
                            icon: Icon(Icons.check_box_outlined),
                            color: Colors.white,
                            //ここにロゴ置く
                            iconSize: 30,
                            onPressed: () async{
                              await Future.delayed(Duration(milliseconds: 500));
                              await model.delete(plan);
                              model.fetchPlanList();
                            }, //ここで設定開く
                          ),
                        ),
                        title: Container(
                          child: Row(
                            children: [
                              plan.start != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 2),
                                      child: Text(
                                        '${plan.start!.month}/${plan.start!.day} ${plan.start!.hour}:${plan.start!.minute}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.deepOrangeAccent
                                                .withOpacity(0.9)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container(),
                              plan.start != null
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(left: 2, right: 2),
                                      child: Text(
                                        '~',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container(),
                              plan.end != null
                                  ? Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, right: 4),
                                        child: Text(
                                          '${plan.end!.month}/${plan.end!.day} ${plan.end!.hour}:${plan.end!.minute}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.deepOrangeAccent
                                                  .withOpacity(0.9)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 4),
                                        child: Text(
                                          '期限指定なし',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.deepOrangeAccent),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0x98FFFFFF),
                                size: 32,
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 12, bottom: 4),
                          child: Container(
                            child: Text(
                              plan.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList();
            return ListView(
              padding: EdgeInsets.only(top: 10),
              children: widgets,
            );
          },
        ),
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
    );
  }
}
