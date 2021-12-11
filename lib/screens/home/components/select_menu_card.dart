import 'package:flutter/material.dart';

import '../../../constants.dart';

class SelectMenuCard extends StatelessWidget {
  const SelectMenuCard(
      {Key? key,
      required this.title,
      required this.region,
      required this.price,
      required this.press})
      : super(key: key);

  //画像追加ならここに String image を追加する
  final String title, region;
  final int price;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5),
      width: size.width * 0.4,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  )
                ]),
            child: Row(
              children: [
                //ここに写真入れる
                GestureDetector(
                  onTap: press,
                  child: Container(
                    height: size.height * 0.2,
                    child: Card(
                      color: kBackgroundColor,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n".toUpperCase(),
                        style: Theme.of(context).textTheme.button),
                    TextSpan(
                        text: region,
                        style: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ))
                  ]),
                ),
                Spacer(),
                Text(
                  '\$$price',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: kPrimaryColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
