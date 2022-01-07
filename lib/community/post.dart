class Post {
  final dynamic content,
      postType,
      likes,
      author,
      comments,
      datePosted,
      postId,
      timePosted;

  Post(
      {required this.content,
      required this.datePosted,
      required this.postType,
      required this.likes,
      required this.author,
      required this.comments,
      required this.postId,
      required this.timePosted});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        content: json['content'],
        datePosted: json['date_posted'].split("T")[0],
        postType: json['post_type'],
        author: json['author'],
        likes: json['likes'],
        postId: json['id'],
        comments: json['commentCount'],
        timePosted: json['date_posted'].split("T")[1].split(".")[0]);
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
