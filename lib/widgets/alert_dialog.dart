import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.titleError});

  final String titleError;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: tColorBottomSheet.withOpacity(0.5),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 300),
          decoration: BoxDecoration(
              color: tColorBottomSheet,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleError,
                    style: tStyleBigTitle,
                  ),
                  TextButton(
                    child: const Text('Back'),
                    onPressed: () => Get.back(),
                  )
                ]),
          ),
        ));
  }
}
