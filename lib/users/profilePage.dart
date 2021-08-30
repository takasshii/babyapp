import 'package:babyapp/users/addProfile/editProfile.dart';
import 'package:babyapp/domain/user.dart';
import 'package:babyapp/auth/login/loginPage.dart';
import 'package:babyapp/users/userModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel()..fetchUserList(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff181E27),
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Profile",
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
          child: Consumer<UserModel>(builder: (context, model, child) {
            final UserDetail? user = model.userDetailList;
            if (user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: user.imageURL != null
                                  ? Image.network(user.imageURL!)
                                  : Icon(
                                      Icons.account_circle,
                                      size: 90,
                                    ), //ここで設定開く
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 44,
                          height: 44,
                          padding: EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 1, color: Colors.white10)),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Color(0x98FFFFFF),
                            ),
                            iconSize: 24,
                            onPressed: () async {
                              final bool? edited = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => (EditProfile(user)),
                                ),
                              );
                              if (edited != null && edited) {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('ユーザー情報を編集しました'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              model.fetchUserList();
                            }, //ここで設定開く
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 44,
                          height: 44,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: Colors.white10),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.login_rounded,
                              color: Color(0x98FFFFFF),
                            ),
                            iconSize: 24,
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              // ログイン画面に遷移＋プロフィール画面を破棄
                              await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }),
                              );
                            }, //ここで設定開く
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        //名前を取得
                        child: Text(
                          user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        //年齢を取得
                        child: Text(
                          "[age]",
                          style: TextStyle(
                            color: Color(0x98FFFFFF),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Text(
                      user.email,
                      style: TextStyle(
                          color: Colors.deepPurpleAccent.withOpacity(0.9),
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    //Statusを取得
                    padding: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      "Baby's Info",
                      style: TextStyle(
                        color: Color(0x98FFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      user.babyName != null
                          ? Container(
                              padding: EdgeInsets.only(top: 10),
                              //名前を取得
                              child: Text(
                                user.babyName as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              //名前を取得
                              child: Text(
                                '[未記入]',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                      user.babyBirthDay != null
                          ? Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "[${user.babyBirthDay!.year.toString()}/${user.babyBirthDay!.month.toString()}/${user.babyBirthDay!.day.toString()}]",
                                style: TextStyle(
                                  color: Color(0x98FFFFFF),
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              //年齢を取得
                              child: Text(
                                "[age]",
                                style: TextStyle(
                                  color: Color(0x98FFFFFF),
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                    ],
                  ),
                  Container(
                    //Statusを取得
                    padding: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      "Status",
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
                      "[Status]",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    //Statusを取得
                    padding: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      "Next Appointment",
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
                      "[Aug...]",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    //Statusを取得
                    padding: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      "Past Appointment",
                      style: TextStyle(
                        color: Color(0x98FFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  //1つ目
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        //todo
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Text(
                                          'Book Appointment',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.chevron_right_rounded,
                                            color: Color(0x98FFFFFF),
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 4),
                                      child: SizedBox(
                                        child: Text(
                                          '[YY/MM/DD/HH/MM]',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 4, bottom: 4),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            'For',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4,
                                          top: 4,
                                          right: 25,
                                          bottom: 4),
                                      child: Text(
                                        '[Name]',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.deepOrangeAccent
                                              .withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ), // ここに追加
                ],
              ),
            );
          }),
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
}
