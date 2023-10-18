import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/models/exercise_model.dart';
import 'package:gorilla_grab/Screens/models/rep_provisional_records_model.dart';
import 'package:gorilla_grab/Screens/models/session_provisional_model.dart';
import 'package:gorilla_grab/Screens/models/timer_provisional_records_model.dart';

import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';

import '../../../constants/sizes.dart';
import '../../../controllers/exercises_controller.dart';
import '../../../widgets/buttons.dart';

class SessionRepScreen extends StatelessWidget {
  final ExercisesController exercisesController =
      Get.put(ExercisesController());
  final TrainingController trainingController = Get.put(TrainingController());
  final SessionsController sessionsController = Get.put(SessionsController());
  final RecordsController recordsController = Get.put(RecordsController());

  SessionRepScreen({
    Key? key,
    required this.exerciseModel,
    required this.provisionalRepRecordsModel,
  }) : super(key: key);

  final ExerciseModel exerciseModel;

  final ProvisionalRepRecordsModel provisionalRepRecordsModel;

  @override
  Widget build(BuildContext context) {
    ProvisionalExercisesSession provisionalExercisesSession = sessionsController
        .getProvisionalSession(trainingId: exerciseModel.trainingId);

    exerciseModel.sessionId = provisionalExercisesSession.exercisesSessionId;

    List<String> timerRecordsExercise =
        recordsController.getFilteredTimerRecordsList(
            exerciseId: exerciseModel.exerciseId,
            sessionId: provisionalExercisesSession.exercisesSessionId);
    return Scaffold(
      backgroundColor: tColorBottomSheet,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(tSizesBarAppHeight),
          child: CustomAppBarBackExerciseRep(
            provisionalRepRecordsModel: provisionalRepRecordsModel,
            provisionalExercisesSession: provisionalExercisesSession,
            context: context,
            exercisesController: exercisesController,
            exerciseModel: exerciseModel,
            appBarTitle: exerciseModel.name,
          )),
      body: GetBuilder<RecordsController>(builder: (controller) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Container(
                  //color: tColorGreen,
                  child: Text(
                    exerciseModel.name,
                    style: tStyleRepTitle,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 200,
                child: Container(
                  //color: tColorGreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${provisionalRepRecordsModel.repRecord}',
                        style: tStyleRep,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DecreaseButton(
                            onPressed: () =>
                                (recordsController.decreaseRepRecord(
                                    provisionalRepRecordsModel:
                                        provisionalRepRecordsModel)),
                          ),
                          IncreaseButton(
                            onPressed: () =>
                                (recordsController.increaseRepRecord(
                                    provisionalRepRecordsModel:
                                        provisionalRepRecordsModel)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        );
      }),
    );
  }
}
