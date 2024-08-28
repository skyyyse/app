import 'package:app/controller/Comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Function_controller extends GetxController {
  final comment = Get.put(Comment_controller());
  var selectedValue = 1.obs;
  void updateValue(int value) {
    selectedValue.value = value;
  }

  option(value, id, post_id) {
    switch (value) {
      case "Report":
        return Report();
        break;
      case "Copy":
        return Copy();
        break;
      case "Delete":
        return Delete(id, post_id);
        break;
    }
  }

  void Delete(id, post_id) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure you want to Delete?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              comment.Delete(id, post_id);
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void Copy() {
    Get.dialog(
      AlertDialog(
        title: Text('Copy'),
        content: Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              print('Cancel pressed');
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              print('OK pressed');
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void Report() {
    int _selectedValue = 1; // Default selected value
    Get.dialog(
      AlertDialog(
        title: Text('Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => RadioListTile<int>(
                  title: Text('Option 1'),
                  value: 1,
                  groupValue: selectedValue.value,
                  onChanged: (value) {
                    if (value != null) {
                      updateValue(value);
                    }
                  },
                )),
            Obx(
              () => RadioListTile<int>(
                title: Text('Option 2'),
                value: 2,
                groupValue: selectedValue.value,
                onChanged: (value) {
                  if (value != null) {
                    updateValue(value);
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              print('Cancel pressed');
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              print('OK pressed');
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
