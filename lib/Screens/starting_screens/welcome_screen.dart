import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/starting_screens/log_in_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  final String title = 'Track your progress';
  final String subtitle = 'Create trainings and track your sessions results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allAppBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: tSizesMargin * 3),
        child: Container(
          //color: tColorPinky,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(tImgLogoGorillaMoon),
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Container(
                      //color: tColorBlue,
                      child: Column(
                    children: [
                      Text(title.toUpperCase(),
                          style: tStyleOnboardingTitle,
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        subtitle,
                        style: tStyleOnboardingSubtitle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
                ),
                Container(
                  color: tColorTransparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: gradient1,
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            height: 47,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: allAppBackground,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextButton(
                              child: const Text(
                                'Sign up',
                                style: tStyleBottomSheet,
                              ),
                              onPressed: () => (Get.to(() => LogInScreen())),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: gradient1,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                            child: const Text(
                              'Sign In',
                              style: tStyleBottomSheet,
                            ),
                            onPressed: () => (Get.to(() => LogInScreen())),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
