import 'dart:collection';
import 'package:babyapp/record/addRecord/addRecordPage.dart';
import 'package:babyapp/record/record/recordDetail.dart';
import 'package:babyapp/record/record/recordModel.dart';
import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class FindRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PlanListModel>(
              create: (_) => PlanListModel()..fetchPlanList()),
          ChangeNotifierProvider<ChangeCalender>(
              create: (_) => ChangeCalender()),
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
                  child: Text('Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ),
                Tab(
                  child: Text(
                    '体重',
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
          body: Consumer<PlanListModel>(
            builder: (context, model, child) {
              final List<ToDo>? plans = model.plans;

              if (plans == null) {
                return Center(child: CircularProgressIndicator());
              }

              DateTime _focusedDay = DateTime.now();
              DateTime? _selectedDay;
              Map<DateTime, List> _eventsList = {};
              plans.forEach((element) {
                if (element.start != null) {
                  _eventsList[element.start!] = [element.title];
                }
              });

              int getHashCode(DateTime key) {
                return key.day * 1000000 + key.month * 10000 + key.year;
              }

              final _events = LinkedHashMap<DateTime, List>(
                equals: isSameDay,
                hashCode: getHashCode,
              )..addAll(_eventsList);

              List getEventForDay(DateTime day) {
                return _events[day] ?? [];
              }

              final store = Provider.of<ChangeCalender>(context);

              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                eventLoader: getEventForDay,
                calendarFormat: store.calendarFormat,
                onFormatChanged: (format) {
                  store.changeFormat(format);
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  store.changeSelected(_selectedDay, focusedDay);
                },
              );

              final List<Widget> widgets = plans
                  .map(
                    (plan) => Padding(
                      padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 12),
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
                                plan.start != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 2),
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
                                              fontSize: 14,
                                              color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Container(),
                                plan.end != null
                                    ? Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 4),
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
                                              left: 8, right: 4),
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
                                left: 8, right: 12, bottom: 4),
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
                shrinkWrap: true,
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
      ),
    );
  }
}
