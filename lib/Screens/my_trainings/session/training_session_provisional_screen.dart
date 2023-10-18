import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/models/exercise_model.dart';
import 'package:gorilla_grab/Screens/models/session_provisional_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/session_rep_screen.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/session_timer_screen.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/widgets/headers.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/exercises_controller.dart';
import '../../../controllers/trainings_controller.dart';
import '../../models/training_model.dart';

class TrainingSessionScreen extends StatelessWidget {
  final TrainingModel trainingModel;
  final ProvisionalExercisesSession exercisesSession;

  final ExercisesController exercisesController =
      Get.put(ExercisesController());

  final TrainingController trainingController = Get.put(TrainingController());
  final RecordsController recordsController = Get.put(RecordsController());

  TrainingSessionScreen({
    Key? key,
    required this.trainingModel,
    required this.exercisesSession,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tColorBottomSheet,
      body: GetBuilder<ExercisesController>(builder: (controller) {
        var exercisesList =
            exercisesController.getExercises(trainingModel: trainingModel);
        return Container(
          //color: tColorPink,
          child: Stack(children: [
            //Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HeaderWithBackSession(
                trainingModel: trainingModel,
                exerciseSession: exercisesSession,
                exercisesController: exercisesController,
              ),
            ),

            //Exercise list
            Positioned(
              top: 200,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                //color: tColorPink,
                child: ListView.builder(
                    itemCount: exercisesList.length,
                    itemBuilder: (context, index) {
                      bool istimer = exercisesList[index].timer;
                      ExerciseModel exercise = exercisesList[index];
                      Color exerciseColor = Color(exercise.color);

                      //Timer records
                      String currentTimerRecord =
                          recordsController.getCurrentTimerRecord(
                              exerciseModel: exercise,
                              sessionId: exercisesSession.exercisesSessionId);

                      String lastTimerRecord =
                          recordsController.getLastTimerRecordSum(
                              currentRecordDate:
                                  exercisesSession.exercisesSessionDate,
                              exerciseId: exercise.exerciseId);

                      double timerGap =
                          recordsController.calculateTimerRecordsGap(
                              currentRecord: currentTimerRecord,
                              lastRecord: lastTimerRecord);

                      int timerGapInt = timerGap.toInt();

                      //Rep records

                      String currentRepRecord =
                          recordsController.getCurrentRepRecord(
                              exerciseModel: exercise,
                              sessionId: exercisesSession.exercisesSessionId);

                      String lastRepRecord = recordsController.getRepFormat(
                          repRecord: recordsController
                              .findLastRepModelBeforeDate(
                                currentRecordDate:
                                    exercisesSession.exercisesSessionDate,
                                exerciseId: exercise.exerciseId,
                              )
                              .repRecord);

                      double repGap = recordsController.calculateRepRecordsGap(
                          currentRecord: currentRepRecord,
                          lastRecord: lastRepRecord);
                      int repGapInt = repGap.toInt();

                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 0,
                            right: tSizesMargin,
                            left: tSizesMargin,
                            bottom: 14),
                        child: Container(
                          height: 65,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(allBoxRadius),
                            gradient: const LinearGradient(colors: [
                              tColorBottomSheetG1,
                              tColorBottomSheetG1,
                            ], stops: [
                              0.1,
                              1
                            ]),
                          ),
                          child: ListTile(
                            //tileColor: tColorBlack,
                            onTap: () {
                              if (exercisesList[index].timer) {
                                Get.to(SessionTimerScreen(
                                    provisionalTimerRecordsModel:
                                        recordsController
                                            .getProvisionalTimerRecord(
                                                exerciseModel: exercise,
                                                sessionId: exercisesSession
                                                    .exercisesSessionId),
                                    exerciseModel: exercisesList[index]));
                              } else {
                                Get.to(SessionRepScreen(
                                    exerciseModel: exercise,
                                    provisionalRepRecordsModel:
                                        recordsController
                                            .getProvisionalRepRecord(
                                                exerciseModel: exercise,
                                                sessionId: exercisesSession
                                                    .exercisesSessionId)));
                              }
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                //color: tColorBottomSheet,
                                child: exercisesController.getExerciseIcon(
                                    isTimer: istimer, color: exerciseColor),
                              ),
                            ),
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Exercise name
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 57,
                                  width: 100,
                                  //color: tColorPink,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      exercisesList[index].name,
                                      softWrap: true,
                                      maxLines: 2,
                                      style: tStyleListTileExerciseName,
                                    ),
                                  ),
                                ),

                                //Records
                                Container(
                                  height: 40,
                                  width: 70,
                                  //color: tColorPink,
                                  child: exercisesList[index].timer
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lastTimerRecord == '00:00'
                                                  ? 'LR --:--'
                                                  : 'LR $lastTimerRecord',
                                              style: tStyleListTileLR,
                                            ),
                                            Text('CR $currentTimerRecord',
                                                style: tStyleListTileCR)
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lastRepRecord == '9999'
                                                  ? 'LR -- rp'
                                                  : 'LR $lastRepRecord rp',
                                              style: tStyleListTileLR,
                                            ),
                                            Text('CR $currentRepRecord rp',
                                                style: tStyleListTileCR)
                                          ],
                                        ),
                                )
                              ],
                            ),

                            //Exercise Gap
                            trailing: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                    width: 75,
                                    //color: tColorWhite,
                                    child: exercise.timer
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              timerGap >= 0
                                                  ? const Icon(
                                                      Icons
                                                          .arrow_drop_up_rounded,
                                                      color: tColorGreen)
                                                  : const Icon(
                                                      Icons
                                                          .arrow_drop_down_rounded,
                                                      color: tColorPrimary_8),
                                              Text(
                                                  lastTimerRecord == '00:00'
                                                      ? '--'
                                                      : '${timerGapInt.toString()}%',
                                                  style: timerGap >= 0
                                                      ? tStyleGapRecordsPositive
                                                      : tStyleGapRecordsNegative),
                                              const SizedBox(
                                                width: 0,
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              repGap >= 0 ||
                                                      lastRepRecord == '9999'
                                                  ? const Icon(
                                                      Icons
                                                          .arrow_drop_up_rounded,
                                                      color: tColorGreen)
                                                  : const Icon(
                                                      Icons
                                                          .arrow_drop_down_rounded,
                                                      color: tColorPrimary_8),
                                              lastRepRecord != '9999'
                                                  ? Text(
                                                      '${repGapInt.toString()}%',
                                                      style: repGap >= 0
                                                          ? tStyleGapRecordsPositive
                                                          : tStyleGapRecordsNegative)
                                                  : const Text('--',
                                                      style:
                                                          tStyleGapRecordsPositive),
                                              const SizedBox(
                                                width: 0,
                                              )
                                            ],
                                          ))),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ]),
        );
      }),
    );
  }
}
