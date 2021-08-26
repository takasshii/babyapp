import 'package:flutter/material.dart';

class AddAnotherProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: Icon(Icons.chevron_left),
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
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                    border: Border.all(width: 2),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      size: 70,
                    ),
                    color: Color(0x98FFFFFF),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    "赤ちゃんの情報を入力してください",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                    ),
                    textAlign: TextAlign.center,
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
                      labelText: 'お腹の中にいた週',
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
                      labelText: '生まれた時の体重',
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
                      labelText: '予防接種の選択をラジオボタンで',
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
                      'Send Request Rink',
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
      ),
    );
  }
}
