import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorToast(String? msg) {
  Get.showSnackbar(
    GetSnackBar(
      message: msg,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    ),
  );
}

showSuccessToast(String? msg) {
  Get.showSnackbar(
    GetSnackBar(
      message: msg,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    ),
  );
}
