import 'package:flutter/material.dart';
import 'package:get/get.dart';

void myLoading() {
  Get.defaultDialog(
      title: 'Loading',
      content: const CircularProgressIndicator(),
      barrierDismissible: false);
}
