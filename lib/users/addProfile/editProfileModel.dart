import 'dart:io';
import 'package:babyapp/auth/authModel.dart';
import 'package:babyapp/domain/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileModel extends ChangeNotifier {
  final UserDetail user;
  File? imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }


  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    imageFile = File(pickedFile!.path);
    notifyListeners();
  }

  EditProfileModel(this.user) {
    nameController.text = user.name;
    emailController.text = user.email;
    user.babyName != null
      ?babyNameController.text = user.babyName!
        :babyNameController.text = '';
    user.babyBirthDay != null
        ?babyBirthController.text = '${user.babyBirthDay!.year.toString()}/${user.babyBirthDay!.month.toString()}/${user.babyBirthDay!.day.toString()}'
        :babyBirthController.text = '';

  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final babyNameController = TextEditingController();
  final babyBirthController = TextEditingController();

  String? name;
  String? email;
  String? babyName;
  DateTime? babyBirthDay;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setBabyName(String babyName) {
    this.babyName = babyName;
    notifyListeners();
  }

  void setBabyBirthDay(DateTime babyBirthDay) {
    final year = babyBirthDay.year.toString();
    final month = babyBirthDay.month.toString();
    final day = babyBirthDay.day.toString();
    babyBirthController.text = '$year/$month/$day';
    notifyListeners();
  }

  bool isUpdated() {
    return name != null || email != null || babyName != null || babyBirthDay != null;
  }


  Future update() async {
    final firebaseCurrentUser = AuthModel().user;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    name = nameController.text;
    email = emailController.text;
    babyName = babyNameController.text;
    babyBirthDay = babyBirthDay;
    final imageURL = await _uploadImage();
    await firebaseCurrentUser!.updateEmail(email!);
    final userDetailList =
    await FirebaseFirestore.instance.collection('users').doc(user.id).set({
      'name': name,
      'email': email,
      'babyName': babyName,
      'babyBirthDay': babyBirthDay,
      'imageURL' : imageURL,
    },SetOptions(merge : true));
  }

  Future<String> _uploadImage() async {
    final storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage
        .ref()
        .child("users/$user.name")
        .putFile(imageFile!);
    final String downloadUrl =
    await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
