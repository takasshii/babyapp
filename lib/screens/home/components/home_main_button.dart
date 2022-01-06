import 'package:babyapp/constants.dart';
import 'package:flutter/material.dart';

class HomeMainButton extends StatelessWidget {
  const HomeMainButton(
      {Key? key,
      required this.press,
      required this.title,
      required this.description,
      required this.color})
      : super(key: key);

  final void Function() press;
  final String title, description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: ElevatedButton(
        onPressed: press,
        child: SizedBox(
          width: size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: kDefaultPadding / 5),
                child: Icon(Icons.calendar_today, size: 70),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding / 5),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding / 5),
                        child: SizedBox(
                          width: size.width,
                          child: Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.white,
          minimumSize: const Size(double.infinity, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
