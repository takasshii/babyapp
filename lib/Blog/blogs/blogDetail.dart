import 'package:babyapp/Blog/blogs/blogsModel.dart';
import 'package:babyapp/Blog/addBlog/editBlogPage.dart';
import 'package:babyapp/domain/blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogDetail extends StatelessWidget {
  const BlogDetail(this.blog);
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogListModel>(
      create: (_) => BlogListModel()..fetchBlogList(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff181E27),
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Blog Detail",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Consumer<BlogListModel>(
                  builder: (context, model, child) {
                    return PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Delete"),
                          value: 1,
                        ),
                      ],
                      onSelected: (result) async {
                        if (result == 0) {
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBlogPage(blog),
                            ),
                          );
                          if (title != null) {
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('$title?????????????????????'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          model.fetchBlogList();
                        }
                        if (result == 1) {
                          showConfirmDialog(context, blog, model);
                        }
                      }
                    );
                  }
                ),
              ),
            ],
            elevation: 0.0,
          ),
        ),
        backgroundColor: Color(0xff181E27),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //Status?????????
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    "Title",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  //Status?????????
                  child: Text(
                    blog.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  //Status?????????
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    "Author",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  //Status?????????
                  child: Text(
                    blog.author,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  //Status?????????
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    "Content",
                    style: TextStyle(
                      color: Color(0x98FFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                //1??????
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  //Status?????????
                  child: Text(
                    blog.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),// ???????????????
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
        ),
      ),
    );
  }
  Future showConfirmDialog(
      BuildContext context,
      Blog blog,
      BlogListModel model,
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("???????????????"),
          content: Text("???${blog.title}???????????????????????????"),
          actions: [
            TextButton(
              child: Text("?????????"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("??????"),
              onPressed: () async {
                // model?????????
                await model.delete(blog);
                Navigator.pop(context);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${blog.title}?????????????????????'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
