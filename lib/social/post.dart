import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_wongnok/social/newpostpage.dart';
import 'dart:io';
import 'package:project_wongnok/home.dart';

class PostPage extends StatefulWidget {
  final List<Post> posts;

  const PostPage({Key? key, required this.posts}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> _posts = [];

  void _addPost(Post post) {
    setState(() {
      // ตรวจสอบให้แน่ใจว่า ID ของ Post ไม่ซ้ำกับที่มีอยู่แล้วใน List
      if (!_posts.any((existingPost) => existingPost.id == post.id)) {
        _posts.add(post);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Post> allPosts = [...widget.posts, ..._posts];

    return Scaffold(
        appBar: AppBar(
          title: Text("Post"),
          backgroundColor: Colors.grey,
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: allPosts.length,
          itemBuilder: (BuildContext context, int index) {
            Post post = allPosts[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  post.image != null
                      ? Expanded(
                          child: Image.file(File(post.image!)),
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(post.content),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePost()),
              ).then((newPost) {
                if (newPost != null) {
                  // สุ่ม ID ให้กับ Post ใหม่
                  newPost.id = Random().nextInt(1000000);
                  _addPost(newPost);
                }
              });
            },
            child: Icon(Icons.add)));
  }
}
