import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/models/exercise_model.dart';
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

class SessionTimerScreen extends StatelessWidget {
  final ExercisesController exercisesController =
      Get.put(ExercisesController());
  final TrainingController trainingController = Get.put(TrainingController());
  final SessionsController sessionsController = Get.put(SessionsController());
  final RecordsController recordsController = Get.put(RecordsController());

  SessionTimerScreen({
    Key? key,
    required this.exerciseModel,
    required this.provisionalTimerRecordsModel,
  }) : super(key: key);

  final ExerciseModel exerciseModel;
  final ProvisionalTimerRecordsModel provisionalTimerRecordsModel;

  @override
  Widget build(BuildContext context) {
    ProvisionalExercisesSession provisionalExercisesSession = sessionsController
        .getProvisionalSession(trainingId: exerciseModel.trainingId);

    exerciseModel.sessionId = provisionalExercisesSession.exercisesSessionId;

    List<String> provisionalTimerRecords =
        provisionalTimerRecordsModel.timerRecordsList;

    List<String> timerRecordsExercise =
        recordsController.getFilteredTimerRecordsList(
            exerciseId: exerciseModel.exerciseId,
            sessionId: provisionalExercisesSession.exercisesSessionId);
    return Scaffold(
      backgroundColor: tColorBottomSheet,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(tSizesBarAppHeight),
          child: CustomAppBarBackExerciseTimer(
            provisionalTimerRecordsModel: provisionalTimerRecordsModel,
            provisionalExercisesSession: provisionalExercisesSession,
            context: context,
            exercisesController: exercisesController,
            exerciseModel: exerciseModel,
            appBarTitle: exerciseModel.name,
          )),
      body: GetBuilder<RecordsController>(builder: (controller) {
        String recordsSum = recordsController.getRecordsSum(
            recordsList: provisionalTimerRecords);

        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              //Records
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 355),
                  child: ListView.builder(
                      itemCount: provisionalTimerRecords.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: tSizesMargin, vertical: 7),
                          child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: tColorBottomSheetG1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Record Index
                                    Container(
                                      alignment: Alignment.center,
                                      width: 25,
                                      //color: tColorGreeny,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color(exerciseModel.color),
                                        child: Text(
                                          '${index + 1}',
                                          style: tStyleStopwatchIndex,
                                        ),
                                      ),
                                    ),

                                    //Record Time
                                    Container(
                                        alignment: Alignment.center,
                                        width: 250,
                                        //color: tColorPinky,
                                        child: Text(
                                          provisionalTimerRecords[index],
                                          textAlign: TextAlign.center,
                                          style: tStyleStopwatch,
                                        )),

                                    //Remove button
                                    Container(
                                      width: 25,
                                      alignment: Alignment.center,
                                      //color: tColorGreen,
                                      child: IconButton(
                                          padding: EdgeInsets.only(right: 0),
                                          icon: const Icon(
                                            CupertinoIcons.clear_circled_solid,
                                            color: tColorPink,
                                            size: 30,
                                          ),
                                          iconSize: 25,
                                          onPressed: () {
                                            recordsController.removeLap(
                                                indexToRemove: index,
                                                provisionalTimerRecordsModel:
                                                    provisionalTimerRecordsModel);
                                          }),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              ),

              //Header records
              Positioned(
                top: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: tColorBottomSheetG1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Total time Title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Container(
                          height: 180,
                          //color: tColorGreen,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "TOTAL RECORD",
                                style: tStyleStopwatchBig,
                              ),
                              Text(
                                recordsController.getTimerRecordFormat(
                                    timerRecord: recordsSum),
                                style: tStyleStopwatchBigTimer,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //Stopwatch
              Positioned(
                top: 200,
                right: 20,
                left: 20,
                child: FullStopwatch(
                  exerciseModel: exerciseModel,
                  recordsController: recordsController,
                  provisionalTimerRecordsModel: provisionalTimerRecordsModel,
                ),
              ),

              //Countdown
              recordsController.showCountdownText
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: tColorBottomSheet.withOpacity(0.9)),
                        child: Center(
                          child: Text(
                            recordsController.countdownText,
                            textAlign: TextAlign.center,
                            style: tStyleListCountdown,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    )
            ]),
          ),
        );
      }),
    );
  }
}

class StopwatchCustom extends StatelessWidget {
  const StopwatchCustom({
    super.key,
    required this.recordsController,
  });

  final RecordsController recordsController;

  @override
  Widget build(BuildContext context) {
    return Text(
      recordsController.getFormattedTime(),
      style: tStyleStopwatchInside,
      textAlign: TextAlign.center,
    );
  }
}

class ButtonsStopwatch extends StatelessWidget {
  const ButtonsStopwatch({
    super.key,
    required this.recordsController,
    required this.provisionalTimerRecordsModel,
    required this.exerciseModel,
  });

  final RecordsController recordsController;
  final ProvisionalTimerRecordsModel provisionalTimerRecordsModel;
  final ExerciseModel exerciseModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(30), color: tColorPinky),
      child: Container(
        width: 300,
        //height: 100,
        //color: tColorGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Refresh
            IconButton(
              iconSize: 35,
              alignment: Alignment.center,
              icon: const Icon(
                Icons.refresh,
                color: tColorWhite,
              ),
              onPressed: () {
                recordsController.reset();
              },
            ),

            //Start/Stop
            IconButton(
              iconSize: 40,
              icon: recordsController.isRunning
                  ? const Icon(
                      Icons.stop_rounded,
                      color: tColorPinky,
                    )
                  : const Icon(
                      Icons.play_arrow_rounded,
                      color: tColorGreeny,
                    ),
              onPressed: () {
                recordsController.isRunning
                    ? recordsController.stop()
                    : recordsController.start();
              },
            ),

            //Save
            IconButton(
              iconSize: 35,
              icon: const Icon(
                Icons.fiber_manual_record,
                color: tColorPrimary_8,
              ),
              onPressed: () {
                recordsController.addLap(
                  provisionalTimerRecordsModel: provisionalTimerRecordsModel,
                );
                Get.to(() => SessionTimerScreen(
                    provisionalTimerRecordsModel: provisionalTimerRecordsModel,
                    exerciseModel: exerciseModel));
              },
            )
          ],
        ),
      ),
    );
  }
}

class FullStopwatch extends StatelessWidget {
  const FullStopwatch(
      {super.key,
      required this.recordsController,
      required this.provisionalTimerRecordsModel,
      required this.exerciseModel});
  final RecordsController recordsController;
  final ProvisionalTimerRecordsModel provisionalTimerRecordsModel;
  final ExerciseModel exerciseModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      //width: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: tColorBottomSheetG1),
      child: Stack(children: [
        Positioned(
            top: 5,
            left: 0,
            right: 10,
            child: StopwatchCustom(recordsController: recordsController)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 5,
          child: ButtonsStopwatch(
              recordsController: recordsController,
              provisionalTimerRecordsModel: provisionalTimerRecordsModel,
              exerciseModel: exerciseModel),
        ),
      ]),
    );
  }
}
