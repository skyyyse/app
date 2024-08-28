import 'dart:convert';

import 'package:app/controller/Token_controller.dart';
import 'package:app/model/Post.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class History_controller extends GetxController{
  var posts = <Post>[].obs;
  var loading = false.obs;
  final token=Get.put(Token_controller());
  Future<void> fetchPosts() async {
    final url = 'http://10.0.2.2:8000/api/history/get?user_id=${token.data['user']['id']}';
    try {
      loading.value = true;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        loading.value = false;
        final List<dynamic> jsonList = json.decode(response.body)['post'];
        posts.assignAll(jsonList.map((json) => Post.fromJson(json)).toList());
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> delete(int id) async {
    final url = 'http://10.0.2.2:8000/api/post/delete?id=${id}';
    try {
      loading.value = true;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('object');
        fetchPosts();
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      print(e);
    }
  }
}