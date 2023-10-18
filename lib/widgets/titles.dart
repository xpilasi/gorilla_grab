import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/models/exercise_model.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';

import '../Screens/models/training_model.dart';
import '../constants/text_styles.dart';
import 'buttons.dart';

class TitleWithAddButton extends StatelessWidget {
  TitleWithAddButton({
    super.key,
    required this.trainingModel,
    required this.title,
    required this.onPressed,
    required this.subtitle,
    required this.totalNumber,
  });

  final TrainingModel trainingModel;
  final String title;
  final String subtitle;
  final int totalNumber;
  final void Function()? onPressed;
  final SessionsController sessionsController = Get.put(SessionsController());

  @override
  Widget build(BuildContext context) {
    bool sessionActive = sessionsController.trainingSessionActive(
        trainingId: trainingModel.trainingId);
    bool trainingHasExercices = false;

    totalNumber >= 1 ? trainingHasExercices = true : false;
    return Positioned(
      child: Container(
        height: 80,
        //color: tColorGreeny,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: tSizesMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tStyleTitles,
                  ),
                  Visibility(
                    visible: totalNumber >= 1,
                    child: Text(
                      '$subtitle: $totalNumber',
                      style: tStyleSubTitles,
                    ),
                  ),
                ],
              ),
            ),

            //Add buton new exercise
            sessionActive == false
                ? Padding(
                    padding: const EdgeInsets.all(tSizesMargin),
                    child: Visibility(
                      visible: trainingHasExercices,
                      child: AddButton(
                        trainingModel: trainingModel,
                        onPressed: onPressed,
                      ),
                    ),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}

class TitleWithAddButtonSession extends StatelessWidget {
  TitleWithAddButtonSession({
    super.key,
    required this.trainingModel,
    required this.title,
    required this.onPressed,
    required this.subtitle,
    required this.totalNumber,
    required this.exercisesList,
  });

  final TrainingModel trainingModel;
  final String title;
  final String subtitle;
  final int totalNumber;
  final void Function()? onPressed;
  final SessionsController sessionsController = Get.put(SessionsController());
  final List<ExerciseModel> exercisesList;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: 80,
        //color: tColorGreeny,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: tSizesMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tStyleTitles,
                  ),
                  Visibility(
                    visible: totalNumber >= 1,
                    child: Text(
                      '$subtitle: $totalNumber',
                      style: tStyleSubTitles,
                    ),
                  ),
                ],
              ),
            ),
            exercisesList.isNotEmpty
                ?
                //Add buton new exercise
                sessionsController.trainingSessionActive(
                        trainingId: trainingModel.trainingId)
                    ? Padding(
                        padding: const EdgeInsets.all(tSizesMargin),
                        child: PendingSessionButton(
                          trainingModel: trainingModel,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(tSizesMargin),
                        child: AddButton(
                          trainingModel: trainingModel,
                          onPressed: onPressed,
                        ),
                      )
                : Text('')
          ],
        ),
      ),
    );
  }
}

class TitleLeft extends StatelessWidget {
  const TitleLeft({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: 80,
        //color: tColorGreeny,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: tSizesMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tStyleTitles,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
