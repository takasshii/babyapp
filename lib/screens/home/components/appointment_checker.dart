import 'package:babyapp/constants.dart';
import 'package:flutter/material.dart';

class AppointmentChecker extends StatelessWidget {
  const AppointmentChecker({Key? key, required this.press}) : super(key: key);

  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          width: double.infinity,
          child: const Text(
            "Your next appointment",
            style: TextStyle(color: Color(0x98FFFFFF), fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: ElevatedButton(
            onPressed: press,
            child: const Text(
              'No Upcoming Appointments!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              minimumSize: const Size(double.infinity, 60),
            ),
          ),
        ),
      ],
    );
  }
}
