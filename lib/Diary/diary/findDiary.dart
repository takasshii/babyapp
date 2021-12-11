import 'dart:collection';
import 'package:babyapp/Diary/addDiary/addDiaryPage.dart';
import 'package:babyapp/Diary/diary/diaryDetail.dart';
import 'package:babyapp/Diary/diary/diaryModel.dart';
import 'package:babyapp/domain/diary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class FindDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DiaryListModel>(
            create: (_) => DiaryListModel()..fetchDiaryList()),
        ChangeNotifierProvider<ChangeCalender>(create: (_) => ChangeCalender()),
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
                "Diary",
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
        body: SingleChildScrollView(
          child: Consumer<DiaryListModel>(
            builder: (context, model, child) {
              final List<Diary>? diaries = model.diaries;

              if (diaries == null) {
                return Center(child: CircularProgressIndicator());
              }

              Map<DateTime, List> _eventsList = {};

              diaries.forEach((element) {
                if (element.day != null &&
                    _eventsList[DateTime(element.day!.year, element.day!.month,
                            element.day!.day)] !=
                        null) {
                  _eventsList[DateTime(element.day!.year, element.day!.month,
                          element.day!.day)]!
                      .add(element);
                } else if (element.day != null) {
                  _eventsList[DateTime(element.day!.year, element.day!.month,
                      element.day!.day)] = [element];
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
              DateTime FocusedDay = store.FocusedDay;
              DateTime? SelectedDay = store.SelectedDay;

              return Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: FocusedDay,
                    eventLoader: getEventForDay,
                    calendarFormat: store.calendarFormat,
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: Colors.white),
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      formatButtonShowsNext: false,
                    ),
                    onFormatChanged: (format) {
                      store.changeFormat(format);
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(SelectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      store.changeSelected(selectedDay, focusedDay);
                      getEventForDay(selectedDay);
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return _buildEventsMarker(date, events);
                        }
                      },
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E().format(day);

                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        if (day.weekday == DateTime.saturday) {
                          final text = DateFormat.E().format(day);

                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.blue),
                            ),
                          );
                        }
                        if (day.weekday != DateTime.sunday &&
                            day.weekday != DateTime.saturday) {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }
                      },
                    ),
                    onPageChanged: (focusedDay) {
                      FocusedDay = focusedDay;
                    },
                  ),
                  SelectedDay != null
                      ? ListView(
                          shrinkWrap: true,
                          children: getEventForDay(SelectedDay)
                              .map(
                                (diary) => Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, right: 20, left: 20),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(top: 8, bottom: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.black.withOpacity(0.7)),
                                    child: ListTile(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DiaryDetail(diary),
                                          ),
                                        );
                                        model.fetchDiaryList();
                                      },
                                      title: Container(
                                        child: Row(
                                          children: [
                                            diary.day != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 2),
                                                    child: Text(
                                                      '${diary.day!.month}/${diary.day!.day}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors
                                                              .deepOrangeAccent
                                                              .withOpacity(
                                                                  0.9)),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                : Container(),
                                            Expanded(
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 200),
                                                padding:
                                                    EdgeInsets.only(left: 12),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    diary.title ?? '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
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
                                            left: 12, top: 4, right: 12),
                                        child: diary.content != null
                                            ? Text(
                                                diary.content,
                                                style: TextStyle(
                                                  color: Color(0x98FFFFFF),
                                                  fontSize: 16,
                                                ),
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList())
                      : Container(),
                ],
              );
            },
          ),
        ),
        floatingActionButton: Consumer<DiaryListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDiaryPage(),
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
                model.fetchDiaryList();
              },
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Positioned(
      right: 5,
      bottom: 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[300],
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
