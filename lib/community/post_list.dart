import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boipoka_mobile/community/post_card.dart';
import 'package:boipoka_mobile/services/auth_service.dart';
import 'package:boipoka_mobile/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:boipoka_mobile/community/post.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final urlPrefix = Vars().getBaseUrl();
  final _storage = const FlutterSecureStorage();
  bool isLoggedIn = true;
  List<PostCard> allPosts = [];

  @override
  void initState() {
    var auth = AuthService();
    auth.checkLogin().then((value) => {
          setState(() {
            isLoggedIn = value;
          })
        });
    if (isLoggedIn) {
      getRequest();
    }
    log("hello");
    log(isLoggedIn.toString());
    super.initState();
  }

  var text = "";

  Future<void> getRequest() async {
    try {
      final token = await _storage.read(key: "token");
      final url = Uri.parse('$urlPrefix/api/posts/');

      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      decodedResponse.forEach((posts) {
        setState(() {
          allPosts.add(PostCard(Post.fromJson(posts)));
        });
      });
      log("hello");
    } catch (e) {
      log('exception: $e');
      text = '$e';
    }
  }

  String getText() {
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return !isLoggedIn
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You are not logged in!"),
              TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: const Text("Login"))
            ],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: allPosts,
            ));
  }
}
