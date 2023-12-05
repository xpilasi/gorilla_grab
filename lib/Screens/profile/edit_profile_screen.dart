import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/profile_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final nameProfile = TextEditingController(text: tProfileName);
    final lastNameProfile = TextEditingController(text: tProfileLastName);
    final emailProfile = TextEditingController(text: tProfileMail);
    final passwordlProfile = TextEditingController(text: tProfileMail);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tColorTransparent,
        title: Text(
          'Edit Profile',
          style: tStyleBigTitle,
        ),
      ),
      backgroundColor: allAppBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: tSizesMargin, vertical: tSizesMargin),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Name
            CustomTextFieldEditProfile(
              profileController: profileController,
              isPassword: false,
              inputTitle: 'Name',
              prefixIcon: const Icon(
                CupertinoIcons.person_fill,
                color: tColorPinky,
              ),
              newData: nameProfile,
              labelText: 'yourName',
              hintText: tProfileName,
            ),

            //Last Name
            CustomTextFieldEditProfile(
              isPassword: false,
              inputTitle: 'Last Name',
              prefixIcon: const Icon(
                CupertinoIcons.profile_circled,
                color: tColorPinky,
              ),
              newData: lastNameProfile,
              profileController: profileController,
              labelText: 'yourLastName',
              hintText: tProfileLastName,
            ),

            //Email
            CustomTextFieldEditProfile(
              isPassword: false,
              inputTitle: 'Email',
              prefixIcon: const Icon(
                CupertinoIcons.mail,
                color: tColorPinky,
              ),
              newData: emailProfile,
              profileController: profileController,
              labelText: 'your@email.com',
              hintText: tProfileName,
            ),

            //Password
            CustomTextFieldEditProfile(
              isPassword: true,
              inputTitle: 'Password',
              prefixIcon: const Icon(
                CupertinoIcons.lock,
                color: tColorPinky,
              ),
              newData: passwordlProfile,
              profileController: profileController,
              labelText: 'new password',
              hintText: tProfileName,
            ),

            //Update button
            ProfileSubmitButton(
              name: nameProfile.text,
              lastName: lastNameProfile.text,
              email: emailProfile.text,
              password: passwordlProfile.text,
            ),
            const SizedBox(
              height: 100,
            )
          ],
        )),
      ),
    );
  }
}
