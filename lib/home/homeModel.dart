import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  String? greeting;

  void fetchTime() async {
    final int now = DateTime.now().hour;
    if (4 < now && now <= 11) {
      final String Greeting = "おはようございます";
      this.greeting = Greeting;
      notifyListeners();
    }
    else if (11 < now && now <= 17) {
      final String Greeting = "こんにちは";
      this.greeting = Greeting;
      notifyListeners();
    }
    else if ((17 < now && now <= 24) || (0 <= now && now <= 4)) {
      final String Greeting = "こんばんは";
      this.greeting = Greeting;
      notifyListeners();
    }
  }
}