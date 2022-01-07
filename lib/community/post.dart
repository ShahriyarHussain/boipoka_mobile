class Post {
  final dynamic content, postType, likes, author, comments, datePosted, postId;

  Post(
      {required this.content,
      required this.datePosted,
      required this.postType,
      required this.likes,
      required this.author,
      required this.comments,
      required this.postId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      content: json['content'],
      datePosted: json['date_posted'],
      postType: json['post_type'],
      author: json['author'],
      likes: json['likes'],
      postId: json['id'],
      comments: json['commentCount'],
    );
  }

  Map toJsonPost() => {
        'content': content,
        'post_type': postType,
        'author': author,
      };

  @override
  String toString() {
    return "$content \n$datePosted \n$postType \n$likes \n$author \n$comments \n$postId \n";
  }
}
