import 'package:app/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splash_page extends StatefulWidget {
  const splash_page({super.key});

  @override
  State<splash_page> createState() => _splash_pageState();
}

class _splash_pageState extends State<splash_page> {
  @override
  void initState() {
    super.initState();
    next_page();
  }

  next_page() {
    Future.delayed(Duration(seconds: 5), () {
      Get.offAll(login_page());
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Icon(
            Icons.person,
            size: 150,
          ),
        ),
      ),
    );
  }
}
