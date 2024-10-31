class Post {
  final int idPosts;
  final String title;
  final String content;
  final String createdAt;
  String email;

  Post({
    required this.idPosts,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.email,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      idPosts: json['id_posts'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_posts': idPosts,
      'title': title,
      'content': content,
      'created_at': createdAt,
      'email': email,
    };
  }
}
