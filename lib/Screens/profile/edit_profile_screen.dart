import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final TrainingController trainingController = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    final nameProfile = TextEditingController(text: tProfileName);
    final lastNameProfile = TextEditingController(text: tProfileLastName);
    final emailProfile = TextEditingController(text: tProfileMail);
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
          children: [
            //Name
            CustomTextFieldEditProfile(
              inputTitle: 'Name',
              prefixIcon: const Icon(
                CupertinoIcons.person_fill,
                color: tColorPinky,
              ),
              newData: nameProfile,
              trainingController: trainingController,
              labelText: 'Name',
              hintText: tProfileName,
            ),

            //Last Name
            CustomTextFieldEditProfile(
              inputTitle: 'Last Name',
              prefixIcon: const Icon(
                CupertinoIcons.profile_circled,
                color: tColorPinky,
              ),
              newData: lastNameProfile,
              trainingController: trainingController,
              labelText: 'Name',
              hintText: tProfileLastName,
            ),

            //Email
            CustomTextFieldEditProfile(
              inputTitle: 'Email',
              prefixIcon: const Icon(
                CupertinoIcons.mail,
                color: tColorPinky,
              ),
              newData: emailProfile,
              trainingController: trainingController,
              labelText: 'Name',
              hintText: tProfileName,
            ),
          ],
        )),
      ),
    );
  }
}
