import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/Screens/home/dashboard_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/profile_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final nameProfile = TextEditingController(text: 'your@email.com');
    final lastNameProfile = TextEditingController(text: 'tProfileLastName');
    final emailProfile = TextEditingController(text: 'tProfileMail');
    final passwordlProfile = TextEditingController(text: 'tProfileMail');
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
                  image: AssetImage(tImgLogoGorilla),
                  width: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                //Inpunt Email User
                CustomTextFieldSign(
                  profileController: profileController,
                  isPassword: false,
                  prefixIcon: const Icon(
                    CupertinoIcons.at,
                    color: tColorPink,
                  ),
                  labelText: 'your@email.com',
                  hintText: '',
                ),
                //Inpunt Password
                CustomTextFieldSign(
                  profileController: profileController,
                  isPassword: true,
                  prefixIcon: const Icon(
                    CupertinoIcons.lock,
                    color: tColorPink,
                  ),
                  labelText: 'yourPassword',
                  hintText: '',
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: gradient1,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                    child: const Text(
                      'Log In',
                      style: tStyleBottomSheet,
                    ),
                    onPressed: () => (Get.to(() => DashBoardHomeScreen())),
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
