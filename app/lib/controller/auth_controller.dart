import 'dart:convert';
import 'package:app/page/login_page.dart';
import 'package:app/page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class auth_controller extends GetxController {
  bool isHidden = true;
  bool validate = false;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm_password = TextEditingController();
  var loading = false.obs;
  void login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      loading.value = true;
      await Future.delayed(Duration(seconds: 2));
      Get.snackbar("Error", "Data is not empty");
      loading.value = false;
    } else {
      loading.value = true;
      try {
        var headers = {
          'Content-Type': 'application/json',
          'Cookie':   'XSRF-TOKEN=eyJpdiI6InIwcGJKYVV3MnV5Y3Urb1RualpYdkE9PSIsInZhbHVlIjoiUmhNSVVCSVFpQ215TDYxbVFPYm9TRGpKV2hEWU5OeUJNTUp1QmhsRTA4akUxeTJDOW4vdkZQU2JVcG1VdFBNUTJMbXZ6MmdmVmZJa1A5TVFHb3N0Z2ZnVENXM1hZMGdUcjk2RDdxb0JZV0tnUjRlQUFValBNQjB0TkhMWjRWMTQiLCJtYWMiOiI1ZGNlNDY5NjNkYzI0YWU4MmZjZWQwYzg2ZjM1OWI1NThlNTc5YzA4NWM4NjEyMTc3YjRmM2Q2M2NiNzM1MmY2IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjgrVTdhckc2N1ZDcjZ5VHNKY0JlNkE9PSIsInZhbHVlIjoiRWZLdGkzRnlZWTdNeGJPb1NESGxPWXdwVTllMzdnUG8yaHJ6c1pacmRQaTE3T0xyQzI5bVFnVmdWTzR1eUo4aGV5YjVFcHM2TzNKV2tpSXZqMk95ZUtsVGFCb2M5a2owbkpBdFRTbC9SNHFETldZSU1JRDVHR0F5bFJscElNNTEiLCJtYWMiOiJiMTI2ZTcxNDYwNzE5MmU4NGMyYmU4ZDIzNGY1OGVkOGZhYWNkZjMwZWU3NzM2OTMxNTc1MmQ1YWI3N2M2YjA4IiwidGFnIjoiIn0%3D'
        };
        var request =
            http.Request('POST', Uri.parse('http://10.0.2.2:8000/api/login'));
        request.body = json.encode({
          "email": email,
          "password": password,
        });
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          String responseBody = await response.stream.bytesToString();
          Get.offAll(main_page(), arguments: json.decode(responseBody));
        } else {
          loading.value = true;
          await Future.delayed(Duration(seconds: 5));
          Get.snackbar("Error", "Data is not empty");
          loading.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void register(String username, String email, String password,
      String confirm_password) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirm_password.isEmpty) {
      loading.value = true;
      await Future.delayed(Duration(seconds: 3));
      Get.snackbar("Error", "Data is not empty");
      loading.value = false;
    } else {
      if (password != confirm_password) {
        loading.value = true;
        await Future.delayed(Duration(seconds: 3));
        Get.snackbar("Error", "Password  is Wrong....");
        loading.value = false;
      } else {
        loading.value = true;
        try {
          var headers = {
            'Content-Type': 'application/json',
            'Cookie':  'XSRF-TOKEN=eyJpdiI6InIwcGJKYVV3MnV5Y3Urb1RualpYdkE9PSIsInZhbHVlIjoiUmhNSVVCSVFpQ215TDYxbVFPYm9TRGpKV2hEWU5OeUJNTUp1QmhsRTA4akUxeTJDOW4vdkZQU2JVcG1VdFBNUTJMbXZ6MmdmVmZJa1A5TVFHb3N0Z2ZnVENXM1hZMGdUcjk2RDdxb0JZV0tnUjRlQUFValBNQjB0TkhMWjRWMTQiLCJtYWMiOiI1ZGNlNDY5NjNkYzI0YWU4MmZjZWQwYzg2ZjM1OWI1NThlNTc5YzA4NWM4NjEyMTc3YjRmM2Q2M2NiNzM1MmY2IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjgrVTdhckc2N1ZDcjZ5VHNKY0JlNkE9PSIsInZhbHVlIjoiRWZLdGkzRnlZWTdNeGJPb1NESGxPWXdwVTllMzdnUG8yaHJ6c1pacmRQaTE3T0xyQzI5bVFnVmdWTzR1eUo4aGV5YjVFcHM2TzNKV2tpSXZqMk95ZUtsVGFCb2M5a2owbkpBdFRTbC9SNHFETldZSU1JRDVHR0F5bFJscElNNTEiLCJtYWMiOiJiMTI2ZTcxNDYwNzE5MmU4NGMyYmU4ZDIzNGY1OGVkOGZhYWNkZjMwZWU3NzM2OTMxNTc1MmQ1YWI3N2M2YjA4IiwidGFnIjoiIn0%3D'
          };
          var request = http.Request('POST', Uri.parse('http://10.0.2.2:8000/api/register'));
          request.body = json.encode({
            "name": username,
            "email": email,
            "password": password,
          });
          request.headers.addAll(headers);
          http.StreamedResponse response = await request.send();
          if (response.statusCode == 200) {
            Get.to(login_page());
            this.clear();
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  void clear() {
    username.text = '';
    email.text = '';
    password.text = '';
    confirm_password.text = '';
    loading.value = false;
  }
}
