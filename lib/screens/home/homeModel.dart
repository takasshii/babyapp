import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  String? greeting;

  void fetchTime() async {
    final int now = DateTime.now().hour;
    if (4 < now && now <= 11) {
      const String Greeting = "おはようございます";
      greeting = Greeting;
      notifyListeners();
    }
    else if (11 < now && now <= 17) {
      const String Greeting = "こんにちは";
      greeting = Greeting;
      notifyListeners();
    }
    else if ((17 < now && now <= 24) || (0 <= now && now <= 4)) {
      const String Greeting = "こんばんは";
      greeting = Greeting;
      notifyListeners();
    }
  }
}