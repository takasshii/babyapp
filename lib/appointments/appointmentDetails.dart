import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xff181E27),
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.baby_changing_station), //ここにロゴ置く
                iconSize: 30,
                onPressed: () {}, //ここで設定開く
              ),
            ),
          ],
          elevation: 0.0,
        ),
      ),
      backgroundColor: Color(0xff181E27),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //Statusを取得
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: Text(
                "Type of appointment",
                style: TextStyle(
                  color: Color(0x98FFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              width: double.infinity,
              //Statusを取得
              child: Text(
                "[AppointmentType]",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Container(
              //Statusを取得
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              child: Text(
                "Next Appointment",
                style: TextStyle(
                  color: Color(0x98FFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              width: double.infinity,
              //Statusを取得
              child: Text(
                "[Aug...]",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  //todo
                },
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0x98FFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color(0x98FFFFFF),
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: double.infinity,
                        //Statusを取得
                        child: Text(
                          "[Name Name]",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff181E27),
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0),
              child: ElevatedButton(
                onPressed: () {
                  //todo
                },
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "What's the problem",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0x98FFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color(0x98FFFFFF),
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: double.infinity,
                        //Statusを取得
                        child: Text(
                          "[AppointmentDescription]This is test of row.This is test of row.This is test of row.This is test of row.This is test of row.This is test of row.This is test of row.This is test of row.This is test of row.",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff181E27),
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  //todo
                },
                child: const Text(
                  'Reschedule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  onPrimary: Colors.white,
                  minimumSize: Size(300, 60),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  //todo
                },
                child: const Text(
                  'Cancel Appointment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  minimumSize: Size(230, 60),
                ),
              ),
            ),
            // ここに追加
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}
