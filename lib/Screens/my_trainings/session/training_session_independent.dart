import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/models/rep_records_model.dart';
import 'package:gorilla_grab/models/session_finished_model.dart';
import 'package:gorilla_grab/models/timer_records_model.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/widgets/headers.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/exercises_controller.dart';
import '../../../controllers/trainings_controller.dart';

import '../../../models/training_model.dart';

class TrainingSessionIndependentScreen extends StatelessWidget {
  final TrainingModel trainingModel;
  final SessionFinished exercisesSession;
  //final int sessionNumber;

  final ExercisesController exercisesController =
      Get.put(ExercisesController());

  final TrainingController trainingController = Get.put(TrainingController());
  final RecordsController recordsController = Get.put(RecordsController());

  TrainingSessionIndependentScreen({
    Key? key,
    required this.trainingModel,
    required this.exercisesSession,
    //required this.sessionNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tColorBottomSheet,
      body: GetBuilder<ExercisesController>(builder: (controller) {
        var exercisesList = exercisesSession.exercisesListFinished;
        return Container(
          //color: tColorPink,
          child: Stack(children: [
            //Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HeaderWithBackSessionFinished(
                trainingModel: trainingModel,
                exerciseSession: exercisesSession,
                exercisesController: exercisesController,
                //sessionNumber: sessionNumber,
              ),
            ),

            //Exercise list
            Positioned(
              top: 210,
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                //color: tColorPink,
                child: ListView.builder(
                    itemCount: exercisesList.length,
                    itemBuilder: (context, index) {
                      ExerciseModel exercise = exercisesList[index];
                      bool istimer = exercisesList[index].timer;

                      //Timer variables:
                      List<String> timerRecordsList =
                          recordsController.getFilteredTimerRecordsList(
                              exerciseId: exercise.exerciseId,
                              sessionId: exercisesSession.sessionId);

                      String timerRecord = recordsController.getRecordsSum(
                          recordsList: timerRecordsList);

                      TimerRecordsModel currentTimerRecordsModel =
                          recordsController.getCurrentTimerRecordsModel(
                              exerciseId: exercise.exerciseId,
                              sessionId: exercisesSession.sessionId);

                      String lastTimerRecord =
                          recordsController.getLastTimerRecordSum(
                        currentRecordDate: currentTimerRecordsModel.recordDay,
                        exerciseId: exercise.exerciseId,
                      );

                      //Rep variables:
                      String repRecord = recordsController.getFilteredRepRecord(
                          exerciseId: exercise.exerciseId,
                          sessionId: exercisesSession.sessionId);
                      RepRecordsModel currentRepRecordsModel =
                          recordsController.getCurrentRepRecordsModel(
                              exerciseId: exercise.exerciseId,
                              sessionId: exercisesSession.sessionId);

                      String lastRepRecord = recordsController.getRepFormat(
                          repRecord: recordsController
                              .findLastRepModelBeforeDate(
                                currentRecordDate:
                                    currentRepRecordsModel.recordDay,
                                exerciseId: exercise.exerciseId,
                              )
                              .repRecord);

                      double timerGap =
                          recordsController.calculateTimerRecordsGap(
                              currentRecord: timerRecord,
                              lastRecord: lastTimerRecord);

                      int timerGapInt = timerGap.toInt();

                      double repGap = recordsController.calculateRepRecordsGap(
                          currentRecord: repRecord, lastRecord: lastRepRecord);
                      int repGapInt = repGap.toInt();

                      Color exerciseColor = Color(exercise.color);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: tSizesMargin, vertical: 7),
                        child:

                            //Exercise
                            Container(
                                height: 65,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  gradient: gradient2,
                                ),
                                child: ListTile(
                                  //tileColor: tColorBlack,
                                  onTap: () {},
                                  contentPadding: EdgeInsets.zero,
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                        //color: tColorBottomSheet,
                                        child:
                                            exercisesController.getExerciseIcon(
                                                isTimer: istimer,
                                                color: exerciseColor)),
                                  ),
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //Exercise name
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 57,
                                        width: 100,
                                        // color: tColorPink,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
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
                                                  Text('CR $timerRecord',
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
                                                  Text('CR $repRecord rp',
                                                      style: tStyleListTileCR)
                                                ],
                                              ),
                                      )
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Container(
                                        width: 75,
                                        //color: tColorPinky,
                                        child: exercise.timer
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  timerGap >= 0
                                                      ? const Icon(
                                                          Icons
                                                              .arrow_drop_up_rounded,
                                                          color: tColorGreen)
                                                      : const Icon(
                                                          Icons
                                                              .arrow_drop_down_rounded,
                                                          color:
                                                              tColorPrimary_8),
                                                  Text(
                                                      lastTimerRecord == '00:00'
                                                          ? '--'
                                                          : '${timerGapInt.toString()}%',
                                                      style: timerGap >= 0
                                                          ? tStyleGapRecordsPositive
                                                          : tStyleGapRecordsNegative),
                                                  SizedBox(
                                                    width: 0,
                                                  )
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  repGap >= 0 ||
                                                          lastRepRecord ==
                                                              '9999'
                                                      ? const Icon(
                                                          Icons
                                                              .arrow_drop_up_rounded,
                                                          color: tColorGreen)
                                                      : const Icon(
                                                          Icons
                                                              .arrow_drop_down_rounded,
                                                          color:
                                                              tColorPrimary_8),
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
                                              )),
                                  ),
                                )),
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
