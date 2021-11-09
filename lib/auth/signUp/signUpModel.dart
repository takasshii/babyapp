import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String name = '';
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool showPassword = false;
  void togglePasswordVisible() {
    showPassword = !showPassword;
    notifyListeners();
  }

  Future signUp() async {
    if (name.isEmpty) {
      throw ('名前を入力してください');
    }

    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }

    // todo
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;
    final email = user!.email;


    FirebaseFirestore.instance.collection('users').add(
      {
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
        'uid': FirebaseAuth.instance.currentUser!.uid
      },
    );
  }
}