import 'package:babyapp/Blog/blogs/findBlog.dart';
import 'package:babyapp/Diary/diary/findDiary.dart';
import 'package:babyapp/ToDo/plans/findPlan.dart';
import 'package:babyapp/appointments/bookAppointment.dart';
import 'package:babyapp/appointments/myAppointment.dart';
import 'package:babyapp/appointments/selectCard.dart';
import 'package:babyapp/constants.dart';
import 'package:babyapp/domain/user.dart';
import 'package:babyapp/growthRecord/growthRecord/findGrowthRecord.dart';
import 'package:babyapp/record/record/findRecord.dart';
import 'package:babyapp/screens/common_components/appbar_with_icons.dart';
import 'package:babyapp/screens/common_components/bottom_logo.dart';
import 'package:babyapp/screens/home/components/appointment_checker.dart';
import 'package:babyapp/screens/home/components/home_main_button.dart';
import 'package:babyapp/screens/home/homeModel.dart';
import 'package:babyapp/users/profilePage.dart';
import 'package:babyapp/users/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/show_name_and_greeting.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ListenableProvider<UserModel>(
            create: (_) => UserModel()..fetchUserList()),
        ListenableProvider<HomeModel>(create: (_) => HomeModel()..fetchTime()),
      ],
      child: Scaffold(
        appBar: appbar_with_icons(
          title: 'Home',
          press_left_icon: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (ProfilePage())));
          },
          press_right_icon: () {},
        ),
        backgroundColor: kBackgroundColor,
        body: Consumer<UserModel>(builder: (context, model, child) {
          final UserDetail? user = model.userDetailList;
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  ShowNameAndGreeting(user: user),
                  AppointmentChecker(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAppointment()),
                      );
                    },
                  ),
                  //1つ目ボタン
                  HomeMainButton(
                    title: 'Book Appointment',
                    description:
                        'Schedule an Appointment with our licenced professional.',
                    color: Colors.greenAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookAppointment()),
                      );
                    },
                  ),
                  //2つ目ボタン
                  HomeMainButton(
                    title: 'Diary',
                    description:
                        "Record your diary and look-back on one's life with your baby.",
                    color: Colors.indigoAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindDiary()),
                      );
                    },
                  ),
                  //3つ目ボタン
                  HomeMainButton(
                    title: 'Record',
                    description:
                        'Record your baby health and Make use of your baby medical check',
                    color: Colors.deepPurpleAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindRecord()),
                      );
                    },
                  ),
                  //4つ目ボタン
                  HomeMainButton(
                    title: 'GrowthRecord',
                    description:
                        "Record your baby's weight and height. You can check your baby growth easily.",
                    color: Colors.redAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindGrowthRecord()),
                      );
                    },
                  ),
                  //5つ目ボタン
                  HomeMainButton(
                    title: 'Blog',
                    description:
                        "Search about information to live with your baby happily.",
                    color: Colors.deepOrangeAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindBlog()),
                      );
                    },
                  ),
                  //6つ目ボタン
                  HomeMainButton(
                    title: 'ToDo',
                    description:
                        'Check and add your medical schedule about your baby.',
                    color: Colors.pinkAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindPlan()),
                      );
                    },
                  ),
                  //7つ目ボタン
                  HomeMainButton(
                    title: 'Email Us',
                    description:
                        'Send us an email and we will get back to you within 2 days.',
                    color: Colors.redAccent.withOpacity(0.9),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectCard()),
                      );
                    },
                  ),
                  const BottomLogo(),
                  // ここに追加
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
