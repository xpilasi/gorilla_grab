import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorPickerController extends GetxController {
  Rx<Color?> selectedColor = Rx<Color?>(null);

  void setSelectedColor(Color color) {
    selectedColor.value = color;
    update();
  }

  bool isColorSelected(Color color) {
    return selectedColor.value == color;
  }

  int getColorValue() {
    Color? color = selectedColor.value;
    return color?.value ?? Colors.transparent.value;
  }
}
