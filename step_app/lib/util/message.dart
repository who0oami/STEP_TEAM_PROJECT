import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  Desciption : 모든 화면에서 Snack Bar나 Alert를 사용할 경우 공통 사항으로 
  Date : 2025-12-11
  Author : 지현
*/

class Message {
  // Snack Bar
  void snackBar(String itemTitle, String message) {
    Get.snackbar(
      itemTitle,
      message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  } // snackBar

  // Dialog
  void showDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: const Color.fromARGB(
        255,
        193,
        197,
        201,
      ),
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
