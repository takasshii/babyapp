import 'package:babyapp/Diary/addDiary/addDiaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AddDiaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddDiaryModel>(
      create: (_) => AddDiaryModel(),
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
        body: Consumer<AddDiaryModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        onChanged: (text) {
                          model.title = text;
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: 'タイトル',
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
                              controller: model.dayController,
                              onTap: () {
                                //ドラムロール式の生年月日選択ができるようにする
                                DatePicker.showDatePicker(context,
                                    minTime: DateTime.now()
                                        .add(Duration(days: 360) * (-1)),
                                    showTitleActions: true,
                                    maxTime: DateTime.now()
                                        .add(Duration(days: 360)),
                                    onConfirm: (text) {
                                  model.setDay(text);
                                  model.day = text;
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.jp);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: true,
                                labelText: '日にち',
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
                        onChanged: (text) {
                          model.content = text;
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
                          labelText: '内容',
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
                        onPressed: () async {
                          try {
                            await model.addPlan();
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text(
                          'Create New Plan',
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
