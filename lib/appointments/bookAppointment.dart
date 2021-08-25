import 'package:flutter/material.dart';

class BookAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff181E27),
        title: Text(
          "Book Appointment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xff181E27),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            children: [
              Container(
                //Statusを取得
                padding: EdgeInsets.only(top: 0),
                width: double.infinity,
                child: Text(
                  "Fill out the information below in order to book your appointment correctly",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0x98FFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Text(
                  "Emails will be send to:",
                  style: TextStyle(
                    color: Color(0x98FFFFFF),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 4),
                width: double.infinity,
                child: Text(
                  "[Your EmailAddress]",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    filled: true,
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color(0x98FFFFFF),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    filled: true,
                    labelText: 'Type of Appointment',
                    labelStyle: TextStyle(
                      color: Color(0x98FFFFFF),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    //todo
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Choose Date',
                                  style: TextStyle(
                                    color: Color(0x98FFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 10),
                                child: Text(
                                  '[YY/MM/DD/HH/MM]',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0x98FFFFFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.date_range_outlined),
                                iconSize: 24,
                                onPressed: () {}, //ここで設定開く
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  minLines: 10,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    filled: true,
                    labelText: 'About Problem',
                    labelStyle: TextStyle(
                      color: Color(0x98FFFFFF),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    /*new RadioListTile(
                        activeColor: Colors.deepPurpleAccent,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Female'),
                        value: 'female',
                        groupValue: "gender",
                        onChanged:(value) {
                          //todo
                        },
                      ),
                      new RadioListTile(
                        activeColor: Colors.deepPurpleAccent,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Male'),
                        value: 'male',
                        groupValue: "gender",
                        onChanged:(value) {
                          //todo
                        },
                      ),*/
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          //todo
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          minimumSize: Size(150, 60),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                //todo
                              },
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.deepPurpleAccent.withOpacity(0.9),
                                onPrimary: Colors.white,
                                minimumSize: Size(150, 60),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
