import 'package:babyapp/ToDo/addToDo/addPlanPage.dart';
import 'package:babyapp/ToDo/plans/planDetail.dart';
import 'package:babyapp/ToDo/plans/plansModel.dart';
import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlanListModel>(
      create: (_) => PlanListModel()..fetchPlanList(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff181E27),
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Blog List",
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
                    padding: EdgeInsets.only(top: 12, right: 20, left: 20),
                    child: Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
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
                        title: Container(
                          child: Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 200),
                                padding: EdgeInsets.only(left: 12),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    plan.title!,
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
                              plan.start != null ? Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 4),
                                        child: Text(
                                          '${plan.start!.hour}:${plan.start!.minute}',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '~',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.deepOrangeAccent
                                            .withOpacity(0.9),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '${plan.start!.hour}:${plan.start!.minute}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.deepOrangeAccent
                                            .withOpacity(0.9),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ) : Container(),
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
                              left: 12, top: 4, right: 12),
                          child: plan.content != null ? Text(
                            plan.content!,
                            style: TextStyle(
                              color: Color(0x98FFFFFF),
                              fontSize: 14,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ): Container(),
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
