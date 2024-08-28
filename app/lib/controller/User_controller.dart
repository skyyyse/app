import 'package:app/controller/Token_controller.dart';
import 'package:app/model/User.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User_controller extends GetxController {
  final token = Get.put(Token_controller());
  var user = Rx<User?>(null);
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }
  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/user/get'),
        headers: {
          "Authorization": "Bearer ${token.data['token']}",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          user.value = User.fromJson(jsonResponse['user']);
        } else {
          error.value = 'Failed to load user data';
        }
      } else {
        error.value = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> changes_Image() async {
    print('object');
    // isLoading.value = true;
    // try {
    //   final response = await http.get(
    //     Uri.parse('http://10.0.2.2:8000/api/user/get'),
    //     headers: {
    //       "Authorization": "Bearer ${token.data['token']}",
    //       'Content-Type': 'application/json',
    //     },
    //   );
    //
    //   if (response.statusCode == 200) {
    //     final jsonResponse = json.decode(response.body);
    //     if (jsonResponse['status'] == true) {
    //       user.value = User.fromJson(jsonResponse['user']);
    //     } else {
    //       error.value = 'Failed to load user data';
    //     }
    //   } else {
    //     error.value = 'Failed to load data: ${response.statusCode}';
    //   }
    // } catch (e) {
    //   error.value = 'Error: $e';
    // } finally {
    //   isLoading.value = false;
    // }
  }
}
