import 'package:app/model/User.dart';

class favorite_model {
  final int id;
  final int user_id;
  final int post_id;
  User user;
  post_model post;
  favorite_model({
    required this.id,
    required this.post_id,
    required this.user_id,
    required this.user,
    required this.post,
  });
  factory favorite_model.fromjson(Map<String, dynamic> json) {
    return favorite_model(
      id: json['id'],
      user_id: json['user_id'],
      post_id: json['post_id'],
      user: User.fromJson(json['user']),
      post: post_model.fromjson(json['post']),
    );
  }
}

class post_model {
  final int id;
  final String title;
  final String description;
  final String image;
  final int user_id;
  post_model(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.user_id});
  factory post_model.fromjson(Map<String, dynamic> json) {
    return post_model(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      user_id: json['user_id'],
    );
  }
}
