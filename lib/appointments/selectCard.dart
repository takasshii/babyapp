import 'package:babyapp/screens/test_home/components/body.dart';
import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppbar(), body: Body());
  }

  AppBar buildAppbar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    );
  }
}
