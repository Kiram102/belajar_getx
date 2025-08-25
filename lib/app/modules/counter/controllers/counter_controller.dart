import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt hitung = 0.obs;
  RxDouble fontSize = 20.0.obs; 

  void increment() {
    if (hitung < 100) {
      hitung++; 
      fontSize.value += 2; 
      if (fontSize > 40) fontSize.value = 40.0; 
    } else {
      Get.snackbar(
        'Stop',
        'Counter tidak boleh lebih dari 100',
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning, color: Colors.white),
        colorText: Colors.white,
      );
    }
  }

  void decrement() {
    if (hitung > 0) {
      hitung--; 
      fontSize.value -= 2; 
      if (fontSize < 12) fontSize.value = 12.0; 
    } else {
      Get.snackbar(
        'Stop',
        'Counter tidak boleh kurang dari 0',
        backgroundColor: Colors.red,
        icon: Icon(Icons.warning, color: Colors.white),
        colorText: Colors.white,
      );
    }
  }
}