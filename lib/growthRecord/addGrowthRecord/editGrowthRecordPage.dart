import 'package:babyapp/growthRecord/addGrowthRecord/editGrowthRecordModel.dart';
import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class EditPlanPage extends StatelessWidget {
  const EditPlanPage(this.plan);
  final ToDo plan;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditPlanModel>(
      create: (_) => EditPlanModel(plan),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff181E27),
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Edit ToDo",
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
        body: Consumer<EditPlanModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: model.titleController,
                        onChanged: (text) {
                          model.setTitle(text);
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: 'title',
                          labelStyle: TextStyle(
                            color: Color(0x98FFFFFF),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(top: 20, right: 5),
                            child: TextFormField(
                              controller: model.startController,
                              onTap: () {
                                //ドラムロール式の生年月日選択ができるようにする
                                DatePicker.showDateTimePicker(context,
                                    minTime: DateTime.now(),
                                    showTitleActions: true,
                                    maxTime: DateTime.now().add(Duration(days: 360)),
                                    onConfirm: (text) {
                                      model.setStart(text);
                                      model.start = text;
                                    }, currentTime: model.start, locale: LocaleType.jp);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: true,
                                labelText: '開始時刻',
                                labelStyle: TextStyle(
                                  color: Color(0x98FFFFFF),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: TextFormField(
                              controller: model.endController,
                              onTap: () {
                                //ドラムロール式の生年月日選択ができるようにする
                                DatePicker.showDateTimePicker(context,
                                    minTime: DateTime.now(),
                                    showTitleActions: true,
                                    maxTime: DateTime.now().add(Duration(days: 360)),
                                    onConfirm: (text) {
                                      model.setEnd(text);
                                      model.end = text;
                                    }, currentTime: model.end, locale: LocaleType.jp);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: true,
                                labelText: '終了時刻',
                                labelStyle: TextStyle(
                                  color: Color(0x98FFFFFF),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(top: 20, left: 5),
                            child: TextFormField(
                              controller: model.notificationController,
                              onTap: () {
                                //ドラムロール式で選択
                                DatePicker.showDateTimePicker(context,
                                    minTime: DateTime.now(),
                                    showTitleActions: true,
                                    maxTime: DateTime.now().add(Duration(days: 360)),
                                    onConfirm: (text) {
                                      model.setNotification(text);
                                      model.notification = text;
                                    }, currentTime: model.notification, locale: LocaleType.jp);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: true,
                                labelText: '通知時間',
                                labelStyle: TextStyle(
                                  color: Color(0x98FFFFFF),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: model.belongingsController,
                        onChanged: (text) {
                          model.setBelongings(text);
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: '必要なもの',
                          labelStyle: TextStyle(
                            color: Color(0x98FFFFFF),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: model.contentController,
                        onChanged: (text) {
                          model.setContent(text);
                        },
                        minLines: 10,
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: 'Memo',
                          labelStyle: TextStyle(
                            color: Color(0x98FFFFFF),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        onPressed: model.isUpdated()
                            ? () async {
                                // 追加の処理
                                try {
                                  await model.update();
                                  Navigator.of(context).pop(model.title);
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            : null,
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.white,
                          minimumSize: Size(230, 60),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
