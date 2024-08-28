import 'package:app/page/test1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputScreen extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final id = int.tryParse(_idController.text);
                if (id != null) {
                  Get.to(() => DetailScreen(id: id));
                } else {
                  Get.snackbar(
                    'Error',
                    'Invalid ID',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
