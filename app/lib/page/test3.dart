import 'package:app/model/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModel {
  final int id;
  final String name;
  final String? gender;
  final String? phone;
  final String? address;
  final String? image;
  final int role;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    this.gender,
    this.phone,
    this.address,
    this.image,
    required this.role,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      phone: json['phone'],
      address: json['address'],
      image: json['image'],
      role: json['role'],
      email: json['email'],
    );
  }
}

class UserController extends GetxController {
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
          "Authorization":
              "Bearer 88|5WnqObhTV3BR5apuUmZgxtlPMR4YdfdXfRkNaI0ke7d715f7",
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
}

class ProfileScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (userController.error.value.isNotEmpty) {
          return Center(child: Text(userController.error.value));
        }

        final user = userController.user.value;
        if (user == null) {
          return Center(child: Text('No user data available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }
}
