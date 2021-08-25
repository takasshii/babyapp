import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Icon(Icons.chevron_left),
        backgroundColor: Color(0xff181E27),
        title: Text(
          "Forgot Password",
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
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: Text(
                  "登録したメールアドレスを入力してください。\n再設定用の認証コードを送信します。",
                  style: TextStyle(
                    color: Color(0x98FFFFFF),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
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
                padding: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    //todo
                  },
                  child: const Text(
                    'Send Request Rink',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
    );
  }
}
