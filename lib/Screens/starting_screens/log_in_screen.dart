import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
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
                //Logo Gorilla
                const GorillaLogoImg(),

                const SizedBox(
                  height: 60,
                ),
                //Inputs
                InputEmailAndPswd(profileController: profileController),

                //LogIn Button
                LogInButton(),

                //Forgot Password
                ForgotPswd(),

                const SizedBox(
                  height: 30,
                ),
                //LogIn with Google
                LogInButtonGoogle(),

                //New at Gorilla Grab
                NewAtGorillaGrab()
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
            child: const Text('Password forgotten?'),
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

class NewAtGorillaGrab extends StatelessWidget {
  const NewAtGorillaGrab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      //color: tColorBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New at Gorilla Grab?',
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            child: Text('Sign up'),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({
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
          'Log In',
          style: tStyleBottomSheet,
        ),
        onPressed: () => (Get.to(() => DashBoardHomeScreen())),
      ),
    );
  }
}

class LogInButtonGoogle extends StatelessWidget {
  const LogInButtonGoogle({
    super.key,
  });

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
              child: const Text(
                'Log In with Google',
                style: tStyleBottomSheet,
              ),
              onPressed: () => (Get.to(() => DashBoardHomeScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class InputEmailAndPswd extends StatelessWidget {
  const InputEmailAndPswd({
    super.key,
    required this.profileController,
  });

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
