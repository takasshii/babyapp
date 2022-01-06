import 'package:flutter/material.dart';

import '../../constants.dart';

class BottomLogo extends StatelessWidget {
  const BottomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
          EdgeInsets.only(top: kDefaultPadding / 2, bottom: kDefaultPadding),
      child: Center(
        child: Text(
          '©︎mwith',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
