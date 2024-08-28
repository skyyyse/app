import 'dart:convert';
import 'package:app/controller/Token_controller.dart';
import 'package:app/model/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Post_controller extends GetxController{
  final title=TextEditingController();
  final description=TextEditingController();
  var posts = <Post>[].obs;
  var loading = false.obs;
  final token=Get.put(Token_controller());
  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    final url = 'http://10.0.2.2:8000/api/post/get';
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
  Future<void> store(String image) async {
    var headers = {
      'Authorization': 'Bearer 126|dZscg5qQZXlNug98muzpRXlEOEKilgII0aN0jn1F76ee0043',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6Imk3TGM4MGNGM3RUVExiZkhPVks5R1E9PSIsInZhbHVlIjoidXQ1WlhsaGJQaFhlMVZhSDVGeWlJaFlZWHFrS3pDcDFYeVJTT0lNVXBIM1lzZHM3eW9oVWltbXFHMG5lVnFlTk9VNzJaYkdSUG1MYXI2QzVxQkdsck1UZUlTRlFvWXN6b2FkSzREZnJBZmdjN2hWVVFhOHdZY25wTFpMMm1SZU4iLCJtYWMiOiI4NzllMGY2NTczMWU0NjI2MzAzMzRiMDhmYzY4YzQ2ZWExZTQ0MDQ1MDUzZjEzNDM0Y2MyZDkzY2IyZjhjYjdmIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6InhYUEM5ckRCNmhpeHZ5aVhkbkFDb0E9PSIsInZhbHVlIjoiUVY4aTNLNEUwNTQ2blBaUnNnZ3l6NFpWL05DTmppUDZTZFM1ZHBuWUxQZjY1UHd5Z0tBVjVQNXZuRE5BMFcyMnNXV1UzUVVOdDlRTlhkZEhReDBEN2xTNkZYYVRZNlhtMFdSUGh5OFdWejFpellELzBrT2R4RmlXOUhrQzdFd2UiLCJtYWMiOiI3NDUxODcwYTBlMGY2NzM1ZWZjZmFlY2U3ZjY5ZGZjZjcyMmI2YTI2YTVlMjg2ZjMxNzg0NTg1NmM2Yjg3N2M1IiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8000/api/post/store'));
    request.fields.addAll({
      'title': '${title.text}',
      'description': '${description.text}'
    });
    request.files.add(await http.MultipartFile.fromPath('image', '${image}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.snackbar('Sucess', 'Create  posts sucessfull..');
      fetchPosts();
    }
    else {
      print(response.reasonPhrase);
    }

  }
}