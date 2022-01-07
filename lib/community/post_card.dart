import 'package:flutter/material.dart';
import 'post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.author + " " + post.postType),
          Text(post.datePosted),
          Text(post.content),
          Text("Likes: " + post.likes.toString()),
          // Text(post.postId.toString()),
          Text("Comments" + post.comments.toString()),
        ],
      ),
    );
  }
}
