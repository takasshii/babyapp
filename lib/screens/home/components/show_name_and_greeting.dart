import 'package:babyapp/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homeModel.dart';

class show_name_and_greeting extends StatelessWidget {
  const show_name_and_greeting({Key? key, required this.user})
      : super(key: key);

  final UserDetail user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          //時間帯で変わるようにする
          child: Consumer<HomeModel>(
            builder: (context, model, child) {
              final greeting = model.greeting;
              if (greeting == null) {
                return const Center(child: const CircularProgressIndicator());
              }
              return Text(
                greeting,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.left,
              );
            },
          ),
        ),
        Row(
          children: [
            Container(
              //名前を取得
              child: Text(
                "${user.name}さん",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              //名前を取得
              child: const Text(
                "👋",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
