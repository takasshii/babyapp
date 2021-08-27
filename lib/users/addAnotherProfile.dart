import 'package:flutter/material.dart';

class AddAnotherProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xff181E27),
          title: Text(
            "Add Baby Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
        ),
        backgroundColor: Color(0xff181E27),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  width: double.infinity,
                  child: Text(
                    "赤ちゃんの情報を入力してください",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
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
                    onTap: () {
                      //ドラムロール式の生年月日選択ができるようにする
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
                  //自動計算する
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      labelText: '年齢',
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      labelText: 'お腹の中にいた週(任意)',
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      labelText: '生まれた時の体重(任意)',
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
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      labelText: '予防接種の選択をラジオボタンで(任意)',
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
                    onPressed: () {
                      //todo
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
        ),

    );
  }
}
