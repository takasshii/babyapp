import 'package:babyapp/screens/test_home/components/title_with_custom_underline.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({Key? key, required this.title, required this.press})
      : super(key: key);

  final String title;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          TitleWithCustomUnderline(text: title),
          Spacer(),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: press,
            child: Text(
              "more",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
