import 'package:babyapp/Diary/addDiary/editDiaryPage.dart';
import 'package:babyapp/Diary/diary/diaryModel.dart';
import 'package:babyapp/domain/diary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryDetail extends StatelessWidget {
  const DiaryDetail(this.diary);

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaryListModel>(
      create: (_) => DiaryListModel()..fetchDiaryList(),
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
                child: Consumer<DiaryListModel>(
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
                              builder: (context) => EditDiaryPage(diary),
                            ),
                          );
                          if (title != null) {
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('$title?????????????????????'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          model.fetchDiaryList();
                        }
                        if (result == 1) {
                          showConfirmDialog(context, diary, model);
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
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //Status?????????
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
                diary.day != null
                    ? Container(
                        padding: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        //Status?????????
                        child: Text(
                          diary.title != null ? diary.title! : '??????',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                diary.day != null
                    ? Column(
                        children: [
                          Container(
                            //Status?????????
                            padding: EdgeInsets.only(top: 20, bottom: 10),
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
                              diary.day != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        '${diary.day!.year}/${diary.day!.month}/${diary.day!.day}',
                                        style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      )
                    : Container(),

                //1??????
                diary.content != null
                    ? Column(
                        children: [
                          Container(
                            //Status?????????
                            padding: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: Text(
                              "Memo",
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
                            //Status?????????
                            child: Text(
                              diary.content!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
    Diary diary,
    DiaryListModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("???????????????"),
          content: diary.title != null
              ? Text("???${diary.title}???????????????????????????")
              : Text('????????????????????????????????????'),
          actions: [
            TextButton(
              child: Text("?????????"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("??????"),
              onPressed: () async {
                // model?????????
                await model.delete(diary);
                Navigator.pop(context);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${diary.title}?????????????????????'),
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
