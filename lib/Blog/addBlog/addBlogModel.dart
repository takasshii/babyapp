import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBlogModel extends ChangeNotifier {
  String? title;
  String? author;
  String? content;

  Future addBlog() async {
    if (title == null || title!.isEmpty) {
      throw Exception("titleが入力されていません");
    }
    if (author == null || author!.isEmpty) {
      throw Exception("authorが入力されていません");
    }
    if (content == null || content!.isEmpty) {
      throw Exception("contentが入力されていません");
    }

    await FirebaseFirestore.instance.collection('blogs').add({
      'title': title,
      'author': author,
      'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
