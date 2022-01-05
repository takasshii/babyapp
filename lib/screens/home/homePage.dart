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
import 'package:babyapp/screens/home/components/appbar_with_icons.dart';
import 'package:babyapp/screens/home/homeModel.dart';
import 'package:babyapp/users/profilePage.dart';
import 'package:babyapp/users/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
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
            return const Center(child: const CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  show_name_and_greeting(user),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: const Text(
                      "Your next appointment",
                      style: TextStyle(color: Color(0x98FFFFFF), fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyAppointment()),
                        );
                      },
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

                  //1つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookAppointment()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: const Text(
                                          'Book Appointment',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: const SizedBox(
                                          width: 260,
                                          child: Text(
                                            'Schedule an Appointment with our licenced professional.',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //2つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindDiary()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                    const Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Diary',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          "Record your diary and look-back on one's life with your baby.",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigoAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //3つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindRecord()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                    const Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: const Text(
                                          'Record',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: SizedBox(
                                          child: Text(
                                            'Record your baby health and Make use of your baby medical check',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //4つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindGrowthRecord()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                    const Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'GrowthRecord',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: const Text(
                                          "Record your baby's weight and height. You can check your baby growth easily.",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //5つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindBlog()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                    const Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Blog',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          "Search about information to live with your baby happily.",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //6つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindPlan()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                    const Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'ToDo',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Check and add your medical schedule about your baby.',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //7つ目ボタン
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectCard()),
                        );
                      },
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                    const Icon(Icons.calendar_today, size: 70),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Email Us',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Send us an email and we will get back to you within 2 days.',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent.withOpacity(0.9),
                        onPrimary: Colors.white,
                        minimumSize: const Size(double.infinity, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 24),
                    child: const Center(
                      child: const Text(
                        '©︎mwith',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // ここに追加
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Column show_name_and_greeting(UserDetail user) {
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
