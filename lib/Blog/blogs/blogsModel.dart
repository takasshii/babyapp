import 'package:babyapp/domain/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogListModel extends ChangeNotifier {
  List<Blog>? blogs;

  void fetchBlogList() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('blogs')
        .orderBy('updatedAt', descending: true)
        .limit(10)
        .get();

    final List<Blog> blogs = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String title = data['title'];
      final String author = data['author'];
      final String content = data['content'];
      final String id = document.id;
      final DateTime updatedAt = data["updatedAt"].toDate();
      return Blog(id, title, author, content, updatedAt);
    }).toList();

    this.blogs = blogs;
    notifyListeners();
  }

  Future delete(Blog blog) {
    return FirebaseFirestore.instance.collection('blogs').doc(blog.id).delete();
  }
}
