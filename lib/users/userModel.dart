import 'package:babyapp/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends ChangeNotifier {
  final current_user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  UserDetail? userDetailList;

    void fetchUserList() async {
      final userDetailList =
      await FirebaseFirestore.instance.collection('users').where("uid", isEqualTo: uid).get();
      final String id = userDetailList.docs.first.id;
      final String name = userDetailList.docs.first.get('name');
      final String email = userDetailList.docs.first.get('email');
      final String? babyName = userDetailList.docs.first.get('babyName');
      final DateTime? babyBirthDay = userDetailList.docs.first.get('babyBirthDay').toDate();
      final String? imageURL = userDetailList.docs.first.get('imageURL');
      this.userDetailList = UserDetail(id, name, email, babyName, babyBirthDay,imageURL);
      notifyListeners();
    }
}
