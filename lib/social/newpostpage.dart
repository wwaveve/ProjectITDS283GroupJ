import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_wongnok/social/post.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<Post> _posts = [];
  String _title = '';
  String _content = '';
  int _id = 0;
  File? _image;

  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
          backgroundColor: Colors.grey,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: getImage,
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: _image == null
                            ? Icon(Icons.add_a_photo, size: 50.0)
                            : Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Content'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some content';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _content = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Create a new post object
                          final newPost = Post(
                            id: _posts.length + 1,
                            title: _title,
                            image: _image?.path,
                            content: _content,
                          );

                          // Add the new post to the existing list of posts
                          setState(() {
                            _posts.add(newPost);
                          });

                          // Navigate to the PostPage and pass the updated list of posts
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostPage(posts: _posts),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                      child: Text('Create Post'),
                    ),
                  ]),
            )));
  }
}

class Post {
  int id;
  String title;
  String content;
  String? image;

  Post(
      {required this.id,
      required this.title,
      required this.content,
      this.image});
}
