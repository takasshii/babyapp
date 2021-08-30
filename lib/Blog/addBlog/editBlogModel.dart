import 'package:babyapp/domain/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBlogModel extends ChangeNotifier {
  final Blog blog;
  EditBlogModel(this.blog) {
    titleController.text = blog.title;
    authorController.text = blog.author;
    contentController.text = blog.content;
  }

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final contentController = TextEditingController();

  String? title;
  String? author;
  String? content;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }
  void setAuthor(String author) {
    this.author= author;
    notifyListeners();
  }
  void setContent(String content) {
    this.content = content;
    notifyListeners();
  }

  bool isUpdated(){
    return title != null || author != null || content != null;
  }

  Future update() async {
    this.title = titleController.text;
    this.author = authorController.text;
    this.content = contentController.text;
    await FirebaseFirestore.instance.collection('blogs').doc(blog.id).update({
      'title': title,
      'author': author,
      'content': content,
    });
  }
}