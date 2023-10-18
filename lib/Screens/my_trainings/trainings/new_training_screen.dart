import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/Screens/my_trainings/trainings/training_screen.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/color_picker_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';
import 'package:gorilla_grab/widgets/buttons.dart';
import 'package:gorilla_grab/widgets/pick_color_box.dart';

class NewTrainingScreen extends StatelessWidget {
  NewTrainingScreen({Key? key}) : super(key: key);

  final TrainingController trainingController = Get.find<TrainingController>();
  final ColorPickerController colorPickerController =
      Get.put(ColorPickerController());
  final newTrainingName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allAppBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(tSizesBarAppHeight),
        child: CustomAppBarBackTraining(),
      ),
      body: GetBuilder<TrainingController>(
        init: trainingController,
        builder: (controller) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(tSizesMarginButtonInputs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Input
                  CustomTextFieldTraining(
                    newTrainingName: newTrainingName,
                    trainingController: trainingController,
                    labelText: tButtonLabelTextNewTraining,
                    hintText: tButtonHintTextNewTraining,
                    prefixIcon: const Icon(Icons.flash_on_sharp),
                  ),

                  //Color pick up
                  const PickUpColorBox(),
                  const SizedBox(
                    height: tSizesMargin,
                  ),

                  //Button Save
                  CustomButtonForm(
                    text: tButtonSaveTraining,
                    onPressed: () {
                      trainingController.addNewTraining(
                          trainingName: newTrainingName.text,
                          trainingColor: colorPickerController.getColorValue());

                      Get.to(() => DashBoardHomeScreen());
                    },
                  ),
                  const SizedBox(height: tSizesMargin * 3),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
