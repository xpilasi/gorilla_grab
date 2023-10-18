import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/controllers/color_picker_controller.dart';

class ColorToPickUp extends StatelessWidget {
  ColorToPickUp({
    required this.colorToPickUp,
    this.onPressed,
  });

  final Color colorToPickUp;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorPickerController colorPickerController =
        Get.put(ColorPickerController());

    return CircleAvatar(
      radius: 25,
      child: GestureDetector(
        onTap: () {
          colorPickerController.setSelectedColor(colorToPickUp);

          print(colorPickerController.selectedColor);
        },
        child: Container(
          decoration: BoxDecoration(
            color: colorToPickUp,
            shape: BoxShape.circle,
          ),
          width: 50,
          child: GetBuilder<ColorPickerController>(
            builder: (colorPickerController) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  const ListTile(),
                  if (colorPickerController.isColorSelected(colorToPickUp))
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
