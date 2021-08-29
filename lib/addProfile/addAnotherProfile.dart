import 'package:babyapp/addProfile/addAnotherProfileModel.dart';
import 'package:babyapp/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddAnotherProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBAnotherProfileModel>(
      create: (_) => AddBAnotherProfileModel(),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              backgroundColor: Color(0xff181E27),
              title: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Add Baby Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              elevation: 0.0,
            ),
            backgroundColor: Color(0xff181E27),
            body: Consumer<AddBAnotherProfileModel>(
                builder: (context, model, child) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0),
                          width: double.infinity,
                          child: Text(
                            "赤ちゃんの情報を入力してください（任意）",
                            style: TextStyle(
                              color: Color(0x98FFFFFF),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            onChanged: (text) {
                              model.babyName = text;
                            },
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              filled: true,
                              labelText: 'お名前',
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
                            controller: model.birthController,
                            onTap: () {
                              //ドラムロール式の生年月日選択ができるようにする
                              DatePicker.showDatePicker(context,
                                  minTime: DateTime(2018, 1, 1),
                                  showTitleActions: true,
                                  maxTime: DateTime.now().add(new Duration(days: 360)),
                                  onConfirm: (text) {
                                    model.setBabyBirthDay(text);
                                    model.babyBirthDay = text;
                                  }, currentTime: DateTime.now(), locale: LocaleType.jp);
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              filled: true,
                              labelText: '誕生日・出産予定日',
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
                                await model.addBlog();
                                await Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomePage();
                                    },
                                  ),
                                );
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
                              '完了',
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
              }
            ),

        ),
      ),
    );
  }
}
