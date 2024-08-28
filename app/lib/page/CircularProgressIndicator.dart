import 'package:flutter/material.dart';

class CircularProgressIndicator_page extends StatelessWidget {
  const CircularProgressIndicator_page({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
