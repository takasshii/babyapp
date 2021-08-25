import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: Icon(Icons.chevron_left),
          backgroundColor: Color(0xff181E27),
          title: Text(
            "Edit Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
        ),
        backgroundColor: Color(0xff181E27),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Column(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                    border: Border.all(width: 2),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      size: 70,
                    ),
                    color: Color(0x98FFFFFF),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      //todo
                    },
                    child: const Text(
                      'Change Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      minimumSize: Size(150, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      labelText: 'Email Address',
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      labelText: 'Your Age',
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
                  padding: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
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
                      primary: Colors.deepPurpleAccent,
                      onPrimary: Colors.white,
                      minimumSize: Size(300, 60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
