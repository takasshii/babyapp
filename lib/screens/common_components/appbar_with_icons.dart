import 'package:flutter/material.dart';

import '../../constants.dart';

class appbar_with_icons extends StatelessWidget with PreferredSizeWidget {
  const appbar_with_icons({
    Key? key,
    required this.press_left_icon,
    required this.press_right_icon,
    required this.title,
  }) : super(key: key);

  final String title;
  final void Function() press_left_icon, press_right_icon;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          child: IconButton(
            icon: const Icon(Icons.account_circle),
            iconSize: 30,
            onPressed: press_left_icon, //ここで設定開く
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: kDefaultPadding / 2),
          child: Text(
            "$title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: IconButton(
              icon: const Icon(Icons.baby_changing_station), //ここにロゴ置く
              iconSize: 30,
              onPressed: press_right_icon, //ここで設定開く
            ),
          ),
        ],
        elevation: 0.0,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
