import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/Screens/home/dashboard_screen.dart';
import 'package:gorilla_grab/Screens/starting_screens/log_in_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/profile_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pswdController = TextEditingController();
    final TextEditingController pswdConfirmController = TextEditingController();

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
                //Gorilla Logo
                const ImgGorillaSignIn(),

                const SizedBox(
                  height: 60,
                ),

                //Inputs fields Sign In
                InputFieldsSignIn(
                    emailController: emailController,
                    pswdController: pswdController,
                    pswdConfirmController: pswdConfirmController),

                //Sing up Button
                const SignUpButton(),

                const SizedBox(
                  height: 50,
                ),

                //Sing up with Google
                ButtonGoogle(
                  buttonText: 'Sign Up with Google',
                  onPressed: () {},
                ),

                //Already at Gorilla Grab
                NewAndAlreadyAtGorillaGrab(
                  action: 'Log in',
                  text: 'Already have an aaccount?',
                  onPressed: () => (Get.to(() => LogInScreen())),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: gradient1, borderRadius: BorderRadius.circular(30)),
      child: TextButton(
        child: const Text(
          'Sign Up',
          style: tStyleBottomSheet,
        ),
        onPressed: () => (Get.to(() => DashBoardHomeScreen())),
      ),
    );
  }
}

class InputFieldsSignIn extends StatelessWidget {
  const InputFieldsSignIn({
    super.key,
    required this.emailController,
    required this.pswdController,
    required this.pswdConfirmController,
  });

  final TextEditingController emailController;
  final TextEditingController pswdController;
  final TextEditingController pswdConfirmController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Inpunt Email User
        CustomTextFieldSign(
          controller: emailController,
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
          controller: pswdController,
          isPassword: true,
          prefixIcon: const Icon(
            CupertinoIcons.lock,
            color: tColorPink,
          ),
          labelText: 'password',
          hintText: '',
        ),
        CustomTextFieldSign(
          controller: pswdConfirmController,
          isPassword: true,
          prefixIcon: const Icon(
            CupertinoIcons.lock,
            color: tColorPink,
          ),
          labelText: 'confirm password',
          hintText: '',
        ),
      ],
    );
  }
}

class ImgGorillaSignIn extends StatelessWidget {
  const ImgGorillaSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(tImgLogoGorilla),
      width: 200,
    );
  }
}
