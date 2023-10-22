import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/session_provisional_model.dart';
import 'package:gorilla_grab/models/session_finished_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/exercises_screen.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';

import '../models/training_model.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../constants/text_styles.dart';

class HeaderWithClear extends StatelessWidget {
  const HeaderWithClear({
    super.key,
    required this.trainingModel,
    required this.onPressed,
  });

  final TrainingModel trainingModel;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Clear screen:
        Positioned(
          top: 45,
          child: IconButton(
            icon: const Icon(
              Icons.clear_rounded,
              color: tColorWhite,
            ),
            onPressed: onPressed,
          ),
        ),
        //TITLE
        Positioned(
          top: 50,
          right: tSizesMargin,
          child: Container(
            //color: tColorBox_1,
            child: Text(
              trainingModel.name,
              style: tStyleBigTitleTraining,
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderForMenu extends StatelessWidget {
  const HeaderForMenu({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //TITLE
        Positioned(
          top: 55,
          left: tSizesMargin + 10,
          child: Container(
            //color: tColorBox_1,
            child: Text(
              title,
              style: tStyleBigTitle,
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderWithBackSession extends StatelessWidget {
  const HeaderWithBackSession({
    super.key,
    required this.trainingModel,
    required this.exerciseSession,
    required this.exercisesController,
  });

  final TrainingModel trainingModel;
  final ProvisionalExercisesSession exerciseSession;
  final ExercisesController exercisesController;

  @override
  Widget build(BuildContext context) {
    String year =
        exerciseSession.exercisesSessionDate.toString().substring(0, 4);
    String month =
        exerciseSession.exercisesSessionDate.toString().substring(5, 7);
    String day =
        exerciseSession.exercisesSessionDate.toString().substring(8, 10);
    String dateEu = '$day/$month/$year';
    String session = 'New Session';

    String startTime =
        exerciseSession.exercisesSessionDate.toString().substring(10, 16);

    return Container(
      height: 220,
      //color: tColorPink,
      child: Stack(
        children: [
          //Title
          Positioned(
            top: 90,
            right: 0,
            left: 0,
            child: Container(
              //color: tColorBox_1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    trainingModel.name,
                    textAlign: TextAlign.left,
                    style: tStyleBigTitlePinky,
                  ),
                  Text(
                    session,
                    textAlign: TextAlign.left,
                    style: tStyleBigTitle,
                  ),
                  Text(
                    dateEu,
                    textAlign: TextAlign.left,
                    style: tStyleTitleSession,
                  ),
                ],
              ),
            ),
          ),

          //Start time
          Positioned(
            top: 180,
            left: tSizesMargin,
            right: tSizesMargin,
            child: Container(
              //color: tColorBox_1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start: $startTime',
                    textAlign: TextAlign.left,
                    style: tStyleSubTitles,
                  ),
                ],
              ),
            ),
          ),

          //Back icon:
          Positioned(
            top: 45,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: tColorWhite,
                size: 20,
              ),
              onPressed: () {
                Get.to(() => ExercisesScreen(trainingModel: trainingModel));
              },
            ),
          ),

          //Actions:
          Positioned(
            top: 45,
            right: 8,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.arrow_down_circle,
                    color: tColorTurk,
                    size: 29,
                  ),
                  onPressed: () {
                    exercisesController.confirmSaveSession(
                        context: context,
                        provisionalExercisesSession: exerciseSession,
                        trainingModel: trainingModel);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.clear_circled,
                    color: tColorPrimary_8,
                    size: 29,
                  ),
                  onPressed: () {
                    exercisesController.confirmRemoveMenuSessionProvisional(
                      context: context,
                      trainingModel: trainingModel,
                      exercisesSession: exerciseSession,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWithBackSessionFinished extends StatelessWidget {
  HeaderWithBackSessionFinished({
    super.key,
    required this.trainingModel,
    required this.exerciseSession,
    required this.exercisesController,
    //required this.sessionNumber,
  });

  final TrainingModel trainingModel;
  final SessionFinished exerciseSession;
  final ExercisesController exercisesController;
  //final int sessionNumber;
  final RecordsController recordsController = Get.put(RecordsController());
  final SessionsController sessionsController = Get.put(SessionsController());

  @override
  Widget build(BuildContext context) {
    String year = exerciseSession.createdAt.toString().substring(0, 4);
    String month = exerciseSession.createdAt.toString().substring(5, 7);
    String day = exerciseSession.createdAt.toString().substring(8, 10);
    String dateEu = '$day/$month/$year';
    int sessionNumber = sessionsController.getSessionFinishedNumber(
        sessionFinished: exerciseSession);
    String sessionNumberString = sessionNumber.toString();
    String sessionFull = 'Session #$sessionNumberString';
    String startTime = exerciseSession.startTime;
    String endTime = exerciseSession.endTime;

    String sessionDuration = exerciseSession.sessionDuration;

    String sessionDurationFull = recordsController.getTimerRecordFormatHours(
        timerRecord: sessionDuration);
    return Container(
      height: 230,
      //color: tColorPink,
      child: Stack(
        children: [
          //Title:
          Positioned(
            top: 90,
            right: 0,
            left: 20,
            child: Container(
              //color: tColorBox_1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainingModel.name,
                    textAlign: TextAlign.left,
                    style: tStyleBigTitlePinky,
                  ),
                  Text(
                    sessionFull,
                    textAlign: TextAlign.left,
                    style: tStyleBigTitle,
                  ),
                  Text(
                    '$dateEu   |  $startTime - $endTime ',
                    textAlign: TextAlign.left,
                    style: tStyleTitleSession,
                  ),
                  Text(
                    'Duration:  $sessionDurationFull',
                    textAlign: TextAlign.left,
                    style: tStyleTitleSession,
                  ),
                ],
              ),
            ),
          ),

          //Start and end:
          //Positioned(
          //   top: 210,
          //   left: 20,
          //   right: tSizesMargin,
          //   child: Container(
          //     //color: tColorBox_1,
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           'Start: $startTime',
          //           textAlign: TextAlign.left,
          //           style: tStyleSubTitles,
          //         ),
          //         Text(
          //           'End: $endTime',
          //           textAlign: TextAlign.left,
          //           style: tStyleSubTitles,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          //Back icon:
          Positioned(
            top: 45,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: tColorWhite,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),

          //Actions:
          Positioned(
            top: 45,
            right: 8,
            child: Row(
              children: [
                const IconButton(
                  icon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: tColorGreen,
                    size: 29,
                  ),
                  onPressed: null,
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.trash_circle,
                    color: tColorPrimary_2,
                    size: 30,
                  ),
                  onPressed: () {
                    exercisesController.confirmRemoveMenuSessionFinished(
                        context: context,
                        trainingModel: trainingModel,
                        sessionFinished: exerciseSession);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
