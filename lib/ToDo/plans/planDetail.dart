import 'package:babyapp/ToDo/addToDo/editPlanPage.dart';
import 'package:babyapp/ToDo/plans/plansModel.dart';
import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanDetail extends StatelessWidget {
  PlanDetail(this.plan);

  final ToDo plan;

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
                "Detail",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Consumer<PlanListModel>(
                  builder: (context, model, child) {
                    return PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Delete"),
                          value: 1,
                        ),
                      ],
                      onSelected: (result) async {
                        if (result == 0) {
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPlanPage(plan),
                            ),
                          );
                          if (title != null) {
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('$titleを編集しました'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          model.fetchPlanList();
                        }
                        if (result == 1) {
                          showConfirmDialog(context, plan, model);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
            elevation: 0.0,
          ),
        ),
        backgroundColor: Color(0xff181E27),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //Statusを取得
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    "Title",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  //Statusを取得
                  child: Text(
                    plan.title!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                plan.start != null
                    ? Column(
                        children: [
                          Container(
                            //Statusを取得
                            padding: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: Text(
                              "Time",
                              style: TextStyle(
                                color: Color(0x98FFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Row(
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
                          ),
                        ],
                      )
                    : Container(),
                //1つ目
                plan.content != null
                    ? Column(
                        children: [
                          Container(
                            //Statusを取得
                            padding: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: Text(
                              "Content",
                              style: TextStyle(
                                color: Color(0x98FFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            //Statusを取得
                            child: Text(
                              plan.content!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    : Container(),
                Container(
                  //Statusを取得
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    "詳細",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                plan.notification != null
                    ? Column(
                        children: [
                          Container(
                            //Statusを取得
                            padding: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: Text(
                              "通知時間",
                              style: TextStyle(
                                color: Color(0x98FFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            //Statusを取得
                            child: Text(
                              '${plan.notification!.hour}:${plan.notification!.minute}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    : Container(),
                plan.belongings != null
                    ? Column(
                        children: [
                          Container(
                            //Statusを取得
                            padding: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: Text(
                              "持ち物",
                              style: TextStyle(
                                color: Color(0x98FFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            //Statusを取得
                            child: Text(
                              plan.belongings!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
        ),
      ),
    );
  }

  Future showConfirmDialog(
    BuildContext context,
    ToDo plan,
    PlanListModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${plan.title}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                // modelで削除
                await model.delete(plan);
                Navigator.pop(context);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${plan.title}を削除しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
