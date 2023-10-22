import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/training_model.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/color_picker_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';
import 'package:gorilla_grab/widgets/buttons.dart';
import 'package:gorilla_grab/widgets/color_picker.dart';

class EditTrainingScreen extends StatelessWidget {
  EditTrainingScreen(
      {Key? key,
      required this.currentTrainingName,
      required this.trainingModel})
      : super(key: key);

  final TrainingController trainingController = Get.find<TrainingController>();
  final ColorPickerController colorPickerController =
      Get.put(ColorPickerController());
  final String currentTrainingName;
  final TrainingModel trainingModel;

  @override
  Widget build(BuildContext context) {
    final newTrainingName = TextEditingController(text: currentTrainingName);
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
                  CustomTextFieldEditTraining(
                    currentTrainingName: currentTrainingName,
                    newTrainingName: newTrainingName,
                    trainingController: trainingController,
                    labelText: tButtonLabelTextNewTraining,
                    hintText: tButtonHintTextNewTraining,
                    prefixIcon: const Icon(Icons.flash_on_sharp),
                  ),
                  //Color pick up
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: tSizesMargin),
                    child: Column(
                      children: [
                        const Text(
                          'Pick up a color',
                          style: tStyleInputLabel,
                        ),
                        const SizedBox(
                          height: tSizesMargin,
                        ),
                        Container(
                          width: 300,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ColorToPickUp(
                                  colorToPickUp: tColorPink,
                                  onPressed: () {
                                    print('primer color');
                                  },
                                ),
                                ColorToPickUp(
                                  colorToPickUp: tColorGreeny,
                                  onPressed: () {},
                                ),
                                ColorToPickUp(
                                  colorToPickUp: tColorPrimary_6,
                                  onPressed: () {},
                                ),
                                ColorToPickUp(
                                  colorToPickUp: tColorPrimary,
                                  onPressed: () {},
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: tSizesMargin,
                  ),
                  CustomButtonForm(
                    text: tButtonSaveTraining,
                    onPressed: () {
                      trainingController.updateTraining(
                          trainingModel: trainingModel,
                          newName: newTrainingName.text,
                          newColor: colorPickerController.getColorValue());

                      Get.back();
                    },
                  ),
                  const SizedBox(height: tSizesMargin),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
