import 'package:app/page/create_post.dart';
import 'package:app/page/favorite_page.dart';
import 'package:app/page/history_page.dart';
import 'package:app/page/home_page.dart';
import 'package:app/page/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class main_page extends StatefulWidget {
  main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  List page = [
    home_page(),
    favorite_page(),
    history_page(),
    setting_page(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[index],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),  // Custom border radius
        ),
        onPressed: (){
          Get.to(create_post());
        },
        child: Icon(Icons.add_circle,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int value) {
          setState(() {
            this.index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.manage_history_sharp), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
