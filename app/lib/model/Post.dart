import 'package:app/model/User.dart';
class Post{
  final int id;
  final String title;
  final String description;
  final String image;
  final int userId;
  final int commentCount;
  final int likeCount;
  User user;
  List<Like> like;
  List<favorite_model> favorite;
  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.userId,
    required this.commentCount,
    required this.likeCount,
    required this.user,
    required this.like,
    required this.favorite,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id']??"",
      title: json['title']??"",
      description: json['description']??"",
      image: json['image']??'',
      userId: json['user_id']??"",
      commentCount: json['comment_count']??"",
      likeCount: json['like_count']??"",
      user: User.fromJson(json['user']),
      like: (json['like'] as List).map((like) => Like.fromJson(like)).toList(),
      favorite: (json['favorite'] as List).map((favorite) => favorite_model.fromjson(favorite)).toList(),
    );
  }
}

class favorite_model {
  final int id;
  final int user_id;
  final int post_id;
  favorite_model({
    required this.id,
    required this.post_id,
    required this.user_id,
  });
  factory favorite_model.fromjson(Map<String, dynamic> json) {
    return favorite_model(
      id: json['id'],
      user_id: json['user_id'],
      post_id: json['post_id'],
    );
  }
}
class Like {
  final int id;
  final int userId;
  final int postId;

  Like({
    required this.id,
    required this.userId,
    required this.postId,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      userId: json['user_id'],
      postId: json['post_id'],
    );
  }
}