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
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 300),
          decoration: BoxDecoration(
              gradient: gradient1, borderRadius: BorderRadius.circular(30)),
          child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: tColorBottomSheet,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   titleError,
                    //   style: tStyleBigTitle,
                    // ),
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
                    Divider(
                      color: tColorBlacky.withOpacity(0.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextButton(
                        child: const Text(
                          'Try again',
                          style: tStyleBottomSheet,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
