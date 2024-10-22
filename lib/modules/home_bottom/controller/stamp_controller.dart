import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StampController extends GetxController {
  // Variable to hold the selected position
  var selectedNumber = 0.obs;

  // Reactive color variable to hold the selected color
  var selectedColor = Colors.black.obs;

  // Method to change the selected number
  void selectNumber(int number) {
    selectedNumber.value = number;
  }

  // Method to change the selected color
  void selectColor(Color color) {
    selectedColor.value = color;
  }
}
