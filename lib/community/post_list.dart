import 'dart:developer';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'dart:convert';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  static const urlPrefix = 'http://10.0.2.2:8000';

  var text = "";

  Future<void> getRequest() async {
    log('Button clicked');
    try {
      final url = Uri.parse('$urlPrefix/api/posts');
      log('url: $url');
      Response response = await get(url);
      log('response: $response');
      text =
          'Status code: ${response.statusCode} \n header: ${response.headers} \n body: ${response.body} ';
      log(text);
    } catch (e) {
      log('exception: $e');
      text = '$e';
      // return;
    }
  }

  String getText() {
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.amber),
          onPressed: getRequest,
          child: const Text('GET'),
        ),
        Text(getText())
      ],
    ));
  }
}

class Post {
  Post(this.content, this.datePosted, this.postType, this.likes, this.user);
  final String content, postType;
  final int likes, user;
  final DateTime datePosted;
}
