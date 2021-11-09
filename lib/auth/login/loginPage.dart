import 'package:babyapp/users/addProfile/addAnotherProfile.dart';
import 'package:babyapp/auth/login/forgotPassword.dart';
import 'package:babyapp/home/homePage.dart';
import 'package:babyapp/auth/login/loginModel.dart';
import 'package:babyapp/auth/signUp/signUpModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff181E27),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: AppBar(
              backgroundColor: Color(0xff181E27),
              flexibleSpace: Center(
                child: Container(
                    width: 200,
                    child: Center(
                      child: Text(
                        'mwith',
                        style: GoogleFonts.lobster(
                            color: Colors.white, fontSize: 60),
                      ),
                    )),
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
                      'Signup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
                indicatorColor: Colors.tealAccent,
              ),
              elevation: 0.0,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TabBarView(
              children: <Widget>[
                ChangeNotifierProvider<LoginModel>(
                  create: (_) => LoginModel(),
                  child: Consumer<LoginModel>(builder: (context, model, child) {
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (text) {
                                model.mail = text;
                              },
                              controller: mailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: true,
                                labelText: 'Email Address',
                                labelStyle: TextStyle(
                                  color: Color(0x98FFFFFF),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                onChanged: (text) {
                                  model.password = text;
                                },
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(color: Colors.white),
                                obscureText: !context.watch<LoginModel>().showPassword,
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  filled: true,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Color(0x98FFFFFF),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: IconButton(

                                    icon: Icon(context
                                        .watch<LoginModel>()
                                        .showPassword // パスワード表示状態を監視(watch)
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () => context
                                        .read<LoginModel>()
                                        .togglePasswordVisible(), // パスワード表示・非表示をトグルする
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 32),
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await model.login();
                                    await _showDialog(context, 'ログインしました');
                                    Navigator.push(
                                      context,
                                      await Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return HomePage();
                                          },
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    _showDialog(context, e.toString());
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent,
                                  onPrimary: Colors.white,
                                  minimumSize: Size(230, 60),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPassword()),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0x98FFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                ChangeNotifierProvider<SignUpModel>(
                  create: (_) => SignUpModel(),
                  child:
                      Consumer<SignUpModel>(builder: (context, model, child) {
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 0),
                              child: TextFormField(
                                controller: nameController,
                                onChanged: (text) {
                                  model.name = text;
                                },
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  filled: true,
                                  labelText: 'Name',
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
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: mailController,
                                onChanged: (text) {
                                  model.mail = text;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  filled: true,
                                  labelText: 'Email Address',
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
                              padding: EdgeInsets.only(top: 12),
                              child: TextFormField(
                                controller: passwordController,
                                onChanged: (text) {
                                  model.password = text;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(color: Colors.white),
                                obscureText:
                                    !context.watch<SignUpModel>().showPassword,
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  filled: true,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Color(0x98FFFFFF),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(context
                                            .watch<SignUpModel>()
                                            .showPassword // パスワード表示状態を監視(watch)
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () => context
                                        .read<SignUpModel>()
                                        .togglePasswordVisible(), // パスワード表示・非表示をトグルする
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 32),
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await model.signUp();
                                    _showDialog(context, '登録完了しました');
                                    // 追加情報に遷移＋サインアップ画面を破棄
                                    await Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return AddAnotherProfile();
                                        },
                                      ),
                                    );
                                  } catch (e) {
                                    _showDialog(context, e.toString());
                                  }
                                },
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
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
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
