import 'package:babyapp/auth/authModel.dart';
import 'package:babyapp/home/homePage.dart';
import 'package:babyapp/auth/login/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MaterialApp(home: new RootPage(),
          routes: <String,WidgetBuilder>{
            '/home':(BuildContext context) => HomePage(),
          }),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _loggedIn = context.watch<AuthModel>().loggedIn;
    if (_loggedIn) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}


