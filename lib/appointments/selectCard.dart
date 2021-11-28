import 'package:babyapp/constants.dart';
import 'package:babyapp/screens/home/components/body.dart';
import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Body()
    );
  }

  AppBar buildAppbar() {
    return AppBar(backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),);
  }
}
