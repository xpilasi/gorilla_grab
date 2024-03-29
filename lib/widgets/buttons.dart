import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/my_trainings/session/training_session_provisional_screen.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/controllers/profile_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';

import '../models/training_model.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../controllers/exercises_controller.dart';
import '../controllers/trainings_controller.dart';

class CustomTextFieldTraining extends StatelessWidget {
  const CustomTextFieldTraining({
    super.key,
    required this.newTrainingName,
    required this.trainingController,
    required this.prefixIcon,
    required this.labelText,
    required this.hintText,
  });

  final TextEditingController newTrainingName;
  final TrainingController trainingController;

  final Icon prefixIcon;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: tColorWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                style: tStyleInput,
                maxLength: 15,
                textCapitalization: TextCapitalization.words,
                controller: newTrainingName,
                decoration: InputDecoration(
                  floatingLabelStyle: tStyleInputButton,
                  counterText: '',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: tStyleInputLabel,
                  hintText: hintText,
                  hintStyle: tStyleInputHint,
                  prefixIcon: prefixIcon,
                ),
                onChanged: (value) {
                  trainingController.showClearIcon(isFilled: value);
                },
              ),
            ),
            GestureDetector(
              onTap: (() {
                newTrainingName.clear();
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.clear,
                    color: trainingController.isVisible
                        ? tColorPink
                        : Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldEditTraining extends StatelessWidget {
  const CustomTextFieldEditTraining({
    super.key,
    required this.newTrainingName,
    required this.trainingController,
    required this.prefixIcon,
    required this.labelText,
    required this.hintText,
    required this.currentTrainingName,
  });

  final TextEditingController newTrainingName;
  final TrainingController trainingController;

  final Icon prefixIcon;
  final String labelText;
  final String hintText;
  final String currentTrainingName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: tColorBottomSheetG,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                style: tStyleInput,
                maxLength: 15,
                textCapitalization: TextCapitalization.words,
                controller: newTrainingName,
                decoration: InputDecoration(
                  floatingLabelStyle: tStyleInputButton,
                  counterText: '',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: tStyleInputLabel,
                  hintText: hintText,
                  hintStyle: tStyleInputHint,
                  prefixIcon: prefixIcon,
                ),
                onChanged: (value) {
                  trainingController.showClearIcon(isFilled: value);
                },
              ),
            ),
            GestureDetector(
              onTap: (() {
                newTrainingName.clear();
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.clear,
                    color: trainingController.isVisible
                        ? tColorPinky
                        : Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldExercise extends StatelessWidget {
  const CustomTextFieldExercise({
    super.key,
    required this.newExerciseName,
    required this.exerciseController,
    required this.prefixIcon,
    required this.labelText,
    required this.hintText,
  });

  final TextEditingController newExerciseName;
  final ExercisesController exerciseController;

  final Icon prefixIcon;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: tColorWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                style: tStyleInput,
                maxLength: 20,
                textCapitalization: TextCapitalization.words,
                controller: newExerciseName,
                decoration: InputDecoration(
                  floatingLabelStyle: tStyleInputButton,
                  counterText: '',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: tStyleInputLabel,
                  hintText: hintText,
                  hintStyle: tStyleInputHint,
                  prefixIcon: prefixIcon,
                ),
                onChanged: (value) {
                  exerciseController.showClearIcon(isFilled: value);
                },
              ),
            ),
            GestureDetector(
              onTap: (() {
                newExerciseName.clear();
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.clear,
                    color: exerciseController.isVisible
                        ? tColorPink
                        : Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButtonForm extends StatelessWidget {
  const CustomButtonForm({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient1, borderRadius: BorderRadius.circular(30)),
      height: 50,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: tStyleBottomSheet),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.heigh,
    required this.width,
  });

  final String text;
  final double heigh;
  final double width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigh,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            foregroundColor: tColorWhite,
            backgroundColor: tColorTurk),
        onPressed: onPressed,
        child: Text(text, style: tStyleBottomSheet),
      ),
    );
  }
}

class CustomButtonBottomSheet extends StatelessWidget {
  const CustomButtonBottomSheet({
    super.key,
    required this.text,
    this.onPressed,
    required this.heigh,
    required this.width,
  });

  final String text;
  final double heigh;
  final double width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigh,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            foregroundColor: tColorWhite,
            backgroundColor: tColorPinky),
        onPressed: onPressed,
        child: Text(text, style: tStyleBottomSheet),
      ),
    );
  }
}

class CustomButtonBottomCancel extends StatelessWidget {
  const CustomButtonBottomCancel({
    super.key,
    required this.text,
    this.onPressed,
    required this.heigh,
    required this.width,
  });

  final String text;
  final double heigh;
  final double width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigh,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            //foregroundColor: tColorTurk,
            backgroundColor: tColorPink),
        onPressed: onPressed,
        child: Text(text, style: tStyleBottomSheet),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    this.exercisesController,
    this.trainingModel,
    this.onPressed,
  });

  final ExercisesController? exercisesController;
  final TrainingModel? trainingModel;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: gradient1,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          '+ new',
          style: tStyleBottomSheet,
        ),
      ),
    );
  }
}

class PendingSessionButton extends StatelessWidget {
  PendingSessionButton({
    super.key,
    this.exercisesController,
    this.trainingModel,
  });

  final ExercisesController? exercisesController;
  final TrainingModel? trainingModel;
  final SessionsController sessionsController = Get.put(SessionsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: tColorPrimary_6,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {
          sessionsController.trainingSessionActive(
                  trainingId: trainingModel!.trainingId)
              ? Get.to(() => TrainingSessionScreen(
                  exercisesSession: sessionsController.getProvisionalSession(
                      trainingId: trainingModel!.trainingId),
                  trainingModel: trainingModel!))
              : null;
        },
        child: const Text(
          ' Continue session ',
          style: tStyleBottomSheet,
        ),
      ),
    );
  }
}

class GoButton extends StatelessWidget {
  final void Function()? onPressed;
  const GoButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: gradient1,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            'Go!',
            style: tStyleBottomSheet,
          ),
        ));
  }
}

class IncreaseButton extends StatelessWidget {
  final void Function()? onPressed;

  const IncreaseButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: tColorPrimary_2,
          borderRadius: BorderRadius.circular(30),
        ),
        child: CircleAvatar(
          backgroundColor: tColorPrimary,
          radius: 30,
          child: IconButton(
              icon: const Icon(Icons.add, color: tColorWhite),
              onPressed: onPressed),
        ));
  }
}

class DecreaseButton extends StatelessWidget {
  final void Function()? onPressed;

  const DecreaseButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: tColorPrimary_2,
          borderRadius: BorderRadius.circular(30),
        ),
        child: CircleAvatar(
          backgroundColor: tColorPrimary,
          radius: 30,
          child: IconButton(
              icon: const Icon(
                Icons.remove,
                color: tColorWhite,
              ),
              onPressed: onPressed),
        ));
  }
}

class CustomTextFieldEditProfile extends StatelessWidget {
  const CustomTextFieldEditProfile({
    super.key,
    required this.newData,
    required this.profileController,
    required this.prefixIcon,
    required this.labelText,
    required this.hintText,
    required this.inputTitle,
    required this.isPassword,
  });

  final TextEditingController newData;
  final ProfileController profileController;

  final Icon prefixIcon;
  final String labelText;
  final String hintText;
  final String inputTitle;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 10),
            child: Text(
              inputTitle,
              style: tStyleTitles,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: tSizesMargin),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              //color: tColorGreen,
              color: tColorBottomSheetG,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      obscureText: isPassword,
                      style: tStyleInput,
                      maxLength: 15,
                      textCapitalization: TextCapitalization.words,
                      controller: newData,
                      decoration: InputDecoration(
                        floatingLabelStyle: tStyleInputButton,
                        counterText: '',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: labelText,
                        labelStyle: tStyleInputLabel,
                        hintText: hintText,
                        hintStyle: tStyleInputHint,
                        prefixIcon: prefixIcon,
                      ),
                      onChanged: (value) {
                        profileController.showClearIcon(isFilled: value);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      newData.clear();
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.clear,
                          color: profileController.isVisible
                              ? tColorPinky
                              : Colors.transparent),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSubmitButton extends StatelessWidget {
  ProfileSubmitButton(
      {super.key,
      required this.name,
      required this.lastName,
      required this.email,
      required this.password});

  final String name;
  final String lastName;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.symmetric(vertical: 30, horizontal: tSizesMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: gradient1,
      ),
      child: TextButton(
        child: const Text(
          'UPDATE',
          style: tStyleBottomSheet,
        ),
        onPressed: () {
          profileController.updateProfileBasicData(
            email: email,
            name: name,
            lastName: lastName,
            password: password,
          );
        },
      ),
    );
  }
}

class CustomTextFieldSign extends StatelessWidget {
  const CustomTextFieldSign({
    super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.controller,
  });

  final controller;
  final Icon prefixIcon;
  final String labelText;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: tColorWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      obscureText: isPassword,
                      style: tStyleBottomSheetDark,
                      maxLength: 20,
                      //textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        counterText: '',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        labelText: labelText,
                        labelStyle: tStyleInputLabelDark,
                        //hintText: hintText,
                        //hintStyle: tStyleInputHint,
                        prefixIcon: prefixIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
