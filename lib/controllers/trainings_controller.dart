import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/trainings/edit_training_screen%20copy.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import '../models/training_model.dart';
import '../widgets/buttons.dart';

class TrainingController extends GetxController {
  final ExercisesController exercisesController =
      Get.put(ExercisesController());
  List<TrainingModel> myTrainingsList = [];

  //To create new training:
  addNewTraining({required String trainingName, required int trainingColor}) {
    TrainingModel newTraining = TrainingModel(
        trainingId: UniqueKey().toString(),
        name: trainingName,
        creationDate: DateTime.now(),
        color: trainingColor);
    myTrainingsList.add(newTraining);

    update();
  }

  //To create new training:
  updateTraining({
    required TrainingModel trainingModel,
    required String newName,
    required int newColor,
  }) {
    trainingModel.name = newName;
    trainingModel.color = newColor;

    update();
  }

  //To remove the training:
  removeTraining({required TrainingModel trainingModel}) {
    int trainingIndex = myTrainingsList.indexWhere(
      (training) => training.trainingId == trainingModel.trainingId,
    );

    myTrainingsList.removeAt(trainingIndex);

    Get.back();
    update();
  }

//To show or not the clear icon
  bool isVisible = false;
  void showClearIcon({required String isFilled}) {
    isVisible = isFilled.isNotEmpty;
    update();
  }

  Widget tryWidget({required Widget widget}) {
    try {
      return widget;
    } catch (e) {
      return Text('$e');
    }
  }

  void handleMenuOptionSelected(String option, int index, BuildContext context,
      TrainingModel trainingModel) {
    if (option == 'Edit') {
      Get.to(() => EditTrainingScreen(
            currentTrainingName: trainingModel.name,
            trainingModel: trainingModel,
          ));
    } else if (option == 'Delete') {
      confirmRemoveMenu(
          context: context, trainingModel: myTrainingsList[index]);
    }
  }

//To deploy bottomSheet:
  confirmRemoveMenu({required BuildContext context, required trainingModel}) {
    showModalBottomSheet(
        backgroundColor: tColorBottomSheet,
        showDragHandle: true,
        //barrierColor: tColorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width: 340,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Text(
                      "Do you want to remove this training?",
                      style: tStyleInputButton,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonBottomCancel(
                            heigh: 40,
                            width: 160,
                            text: "CANCEL",
                            onPressed: () {
                              Get.back();
                            }),
                        CustomButtonBottomSheet(
                            heigh: 40,
                            width: 160,
                            text: "DELETE",
                            onPressed: () {
                              removeTraining(trainingModel: trainingModel);
                              Get.to(() => DashBoardHomeScreen());
                              update();
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

//to get timerExercises:
  String timerExercisesNumber({required TrainingModel trainingModel}) {
    int exercisesTimer = 0;

    List<ExerciseModel> exercisesList =
        exercisesController.getExercises(trainingModel: trainingModel);

    for (var exercise in exercisesList) {
      if (exercise.timer) {
        exercisesTimer += 1;
      }
    }

    return exercisesTimer.toString();
  }

  //to get timerExercises:
  String repExercisesNumber({required TrainingModel trainingModel}) {
    int exercisRep = 0;
    List<ExerciseModel> exercisesList =
        exercisesController.getExercises(trainingModel: trainingModel);

    for (var exercise in exercisesList) {
      if (exercise.timer != true) {
        exercisRep += 1;
      }
    }

    return exercisRep.toString();
  }

  TrainingModel getTrainingModel({required String trainingId}) {
    TrainingModel trainingModel = TrainingModel(
        color: 1,
        name: 'provisional',
        creationDate: DateTime.now(),
        trainingId: '23');
    for (var el in myTrainingsList) {
      if (el.trainingId == trainingId) {
        trainingModel = el;
      }
    }
    return trainingModel;
  }

  Color getColor({required String trainingId}) {
    Color trainingColor = tColorGreen;
    for (var el in myTrainingsList) {
      if (el.trainingId == trainingId) {
        trainingColor = Color(el.color);
      }
    }

    return trainingColor;
  }

//To get the trainig name with the id
  String getTrainingName({required String trainingId}) {
    TrainingModel trainingModel = myTrainingsList
        .firstWhere((element) => element.trainingId == trainingId);

    String trainingName = trainingModel.name;
    return trainingName;
  }
} //Fin Controller
