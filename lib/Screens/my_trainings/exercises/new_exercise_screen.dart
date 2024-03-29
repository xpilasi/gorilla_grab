import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/training_model.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/controllers/color_picker_controller.dart';
import 'package:gorilla_grab/widgets/pick_color_box.dart';

import '../../../constants/texts.dart';
import '../../../constants/variables.dart';
import '../../../controllers/exercises_controller.dart';
import '../../../widgets/bars.dart';
import '../../../widgets/buttons.dart';

// ignore: must_be_immutable
class NewExerciseScreen extends StatelessWidget {
  NewExerciseScreen({Key? key, required this.trainingModel}) : super(key: key);

  final TrainingModel trainingModel;

  final ExercisesController exerciseController =
      Get.find<ExercisesController>();
  final ColorPickerController colorPickerController =
      Get.put(ColorPickerController());
  final newExerciseName = TextEditingController();
  bool switchTimer = true;

  final userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allAppBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(tSizesBarAppHeight),
        child: CustomAppBarBackTraining(),
      ),
      body: GetBuilder<ExercisesController>(
        init: exerciseController,
        builder: (controller) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(tSizesMarginButtonInputs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFieldExercise(
                    newExerciseName: newExerciseName,
                    exerciseController: exerciseController,
                    labelText: tButtonLabelTextNewExercise,
                    hintText: tButtonHintTextNewExercise,
                    prefixIcon: const Icon(Icons.flash_on_sharp),
                  ),
                  const PickUpColorBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "REPETITION",
                        style: exerciseController.isRep(isRep: switchTimer),
                      ),
                      SizedBox(
                        width: 80,
                        child: Switch(
                          activeColor: tColorPink,
                          inactiveThumbColor: tColorPrimary_2,
                          inactiveTrackColor: tColorPrimary_2Dark,
                          value: switchTimer,
                          onChanged: (value) {
                            switchTimer = !switchTimer;
                            exerciseController.update();
                          },
                        ),
                      ),
                      Text(
                        "TIMER",
                        style: exerciseController.isTimer(isTimer: switchTimer),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  CustomButtonForm(
                    text: tButtonSaveExercise,
                    onPressed: () {
                      exerciseController.addNewExercise(
                          user: userEmail!,
                          exerciseName: newExerciseName.text,
                          isTimer: switchTimer,
                          exerciseColor: colorPickerController.getColorValue(),
                          trainingModel: trainingModel);
                      exerciseController.update();

                      Get.back();
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
