import 'package:flutter/material.dart';
import 'post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: Center(
        child: Card(
          margin: const EdgeInsets.only(left: 5, right: 15, top: 5),
          color: Colors.indigo[800],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.podcasts_sharp,
                  color: Colors.white,
                ),
                title: Text(
                  post.author + " " + post.postType,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                    "On " + post.datePosted + ", At " + post.timePosted,
                    style: const TextStyle(color: Colors.white60)),
              ),
              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.black26,
                ),
                // color: Colors.grey[700],
                margin: const EdgeInsets.only(
                    top: 5, bottom: 20, left: 15, right: 15),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    post.content,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Icon(
                      Icons.emoji_objects_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      post.likes.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Icon(
                        Icons.mode_comment_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: Text(
                          post.comments.toString(),
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
