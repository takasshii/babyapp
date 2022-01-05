import 'package:babyapp/screens/test_home/components/select_menu_card.dart';
import 'package:babyapp/screens/test_home/components/title_with_more_btn.dart';
import 'package:flutter/material.dart';

import 'header_with_search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //横サイズを取得
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: "recomended", press: () {}),
          SelectMenuCard(
            title: "たかっしー",
            region: "Japan",
            price: 440,
            press: () {},
          ),
        ],
      ),
    );
  }
}
