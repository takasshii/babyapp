import 'package:babyapp/Blog/addBlog/editBlogModel.dart';
import 'package:babyapp/domain/blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBlogPage extends StatelessWidget {
  const EditBlogPage(this.blog);
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBlogModel>(
      create: (_) => EditBlogModel(blog),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff181E27),
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Blog List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(Icons.baby_changing_station), //ここにロゴ置く
                  iconSize: 30,
                  onPressed: () {}, //ここで設定開く
                ),
              ),
            ],
            elevation: 0.0,
          ),
        ),
        backgroundColor: Color(0xff181E27),
        body: Consumer<EditBlogModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: model.titleController,
                        onChanged: (text) {
                          model.setTitle(text);
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: 'title',
                          labelStyle: TextStyle(
                            color: Color(0x98FFFFFF),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: model.authorController,
                        onChanged: (text) {
                          model.setAuthor(text);
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: 'author',
                          labelStyle: TextStyle(
                            color: Color(0x98FFFFFF),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: model.contentController,
                        onChanged: (text) {
                          model.setAuthor(text);
                        },
                        minLines: 10,
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          labelText: 'Content',
                          labelStyle: TextStyle(
                            color: Color(0x98FFFFFF),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        onPressed: model.isUpdated()
                            ? () async {
                                // 追加の処理
                                try {
                                  await model.update();
                                  Navigator.of(context).pop(model.title);
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            : null,
                        child: const Text(
                          'Update',
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
            );
          },
        ),
      ),
    );
  }
}
