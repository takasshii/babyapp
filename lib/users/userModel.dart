import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  void fetchBlogList() async {
    final QuerySnapshot user =
    await FirebaseFirestore.instance.collection('users').where("uid", isEqualTo: uid).get();


    return user(name,email);

    notifyListeners();
  }
}
