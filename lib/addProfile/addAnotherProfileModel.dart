import 'package:babyapp/domain/user.dart';
import 'package:babyapp/users/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBAnotherProfileModel extends ChangeNotifier {
  final current_user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String? user_id;

  String? babyName;
  DateTime? babyBirthDay;
  final birthController = TextEditingController();

  void setBabyBirthDay(DateTime babyBirthDay) {
    final year = babyBirthDay.year.toString();
    final month = babyBirthDay.month.toString();
    final day = babyBirthDay.day.toString();
    this.birthController.text = '$year/$month/$day';
    notifyListeners();
  }

  Future addBlog() async {
    final userDetailList = await FirebaseFirestore.instance.collection('users').where("uid", isEqualTo: uid).get();
    final String id = userDetailList.docs.first.id;
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'babyName': babyName,
      'babyBirthDay': babyBirthDay,
      'imageURL' : null,
    },SetOptions(merge : true));
  }
}