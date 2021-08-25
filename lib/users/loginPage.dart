import 'package:babyapp/users/forgotPassword.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff181E27),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250.0),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: AppBar(
              backgroundColor: Color(0xff181E27),
              flexibleSpace: Center(
                child: Container(
                  height: 130,
                  width: 200,
                  color: Colors.red,
                ),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text('Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  ),
                  Tab(
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
                indicatorColor: Colors.tealAccent,
              ),
              elevation: 0.0,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TabBarView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
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
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              filled: true,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Color(0x98FFFFFF),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.visibility_off),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 32),
                          child: ElevatedButton(
                            onPressed: () {
                              //todo
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent,
                              onPrimary: Colors.white,
                              minimumSize: Size(230, 60),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPassword()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0x98FFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
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
                        Container(
                          padding: EdgeInsets.only(top: 12),
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
                          padding: EdgeInsets.only(top: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              filled: true,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Color(0x98FFFFFF),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.visibility_off),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 32),
                          child: ElevatedButton(
                            onPressed: () {
                              //todo
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent,
                              onPrimary: Colors.white,
                              minimumSize: Size(230, 60),
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
      ),
    );
  }
}
