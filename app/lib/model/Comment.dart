
import 'package:app/model/User.dart';
class Comment{
  final int id;
  final String comment;
  final int user_id;
  final int post_id;
  User user;
  Comment({
    required this.id,
    required this.comment,
    required this.user_id,
    required this.post_id,
    required this.user
  });
  factory Comment.fromjson(Map<String,dynamic>json){
    return Comment(
      id:json['id'],
      comment:json['comment'],
      user_id:json['user_id'],
      post_id:json['post_id'],
      user: User.fromJson(json['user']),
    );
  }
}