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
          margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 310),
          decoration: BoxDecoration(
              gradient: gradient1, borderRadius: BorderRadius.circular(30)),
          child: Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: tColorBottomSheet,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.warning_rounded,
                            color: tColorPinky,
                            size: 40,
                          ),
                          TextButton(
                            child: Text(
                              titleError,
                              style: tStyleBottomSheet,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: gradient1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton(
                            child: const Text(
                              'Try again',
                              style: tStyleBottomSheet,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
