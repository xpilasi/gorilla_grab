import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/Screens/starting_screens/signup_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/auth_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signUserIn() async {
      authController.showingDialogProgress(context: context);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: pswdController.text);
        //print('User signed in');
      } on FirebaseAuthException catch (e) {
        //Wrong email
        if (e.code == 'user-not-found') {
          //show error to user
          // ignore: use_build_context_synchronously
          authController.wrongEmailMessage(context: context);
        }
        //Wrong password
        else if (e.code == 'wrong-password') {
          //show error to user
          // ignore: use_build_context_synchronously
          authController.wrongEmailPassword(context: context);
        }
      }
    }

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
                //Logo Gorilla
                const GorillaLogoImg(),

                const SizedBox(
                  height: 60,
                ),
                //Inputs
                InputEmailAndPswd(
                  emailController: emailController,
                  pswdController: pswdController,
                ),

                //LogIn Button
                LogInButton(
                  onTap: signUserIn,
                  onPressed: signUserIn,
                ),

                //Forgot Password
                const ForgotPswd(),

                const SizedBox(
                  height: 30,
                ),
                //LogIn with Google
                ButtonGoogle(
                  buttonText: 'Log In with Google',
                  onPressed: () => (Get.to(() => DashBoardHomeScreen())),
                ),

                //New at Gorilla Grab
                NewAndAlreadyAtGorillaGrab(
                  text: 'New at Gorilla Grab?',
                  action: 'Sign up',
                  onPressed: () => (Get.to(() => SignUpScreen())),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPswd extends StatelessWidget {
  const ForgotPswd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      //color: tColorBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text(
              'Forgot Password?',
              style: tStyleOnboardingForgotPswd,
            ),
            onPressed: () => {},
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class NewAndAlreadyAtGorillaGrab extends StatelessWidget {
  const NewAndAlreadyAtGorillaGrab({
    super.key,
    required this.text,
    required this.onPressed,
    required this.action,
  });

  final String text;
  final String action;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      //color: tColorBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.right,
            style: tStyleOnboardingText,
          ),
          const SizedBox(
            width: 2,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              action,
              style: tStyleOnboardingTextLink,
            ),
          ),
        ],
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  void Function()? onTap;
  void Function()? onPressed;

  LogInButton({super.key, required this.onTap, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: gradient1, borderRadius: BorderRadius.circular(30)),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            'Log In',
            style: tStyleBottomSheet,
          ),
        ),
      ),
    );
  }
}

class ButtonGoogle extends StatelessWidget {
  const ButtonGoogle({
    super.key,
    required this.buttonText,
    this.onPressed,
  });
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient1, borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
            color: tColorBottomSheet, borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(1),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                tImgLogoGoogle,
              ),
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: tStyleBottomSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputEmailAndPswd extends StatelessWidget {
  InputEmailAndPswd(
      {super.key, required this.emailController, required this.pswdController});

  final TextEditingController emailController;
  final TextEditingController pswdController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        CustomTextFieldSign(
          controller: pswdController,
          isPassword: true,
          prefixIcon: const Icon(
            CupertinoIcons.lock,
            color: tColorPink,
          ),
          labelText: 'yourPassword',
          hintText: '',
        ),
      ],
    );
  }
}

class GorillaLogoImg extends StatelessWidget {
  const GorillaLogoImg({
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
