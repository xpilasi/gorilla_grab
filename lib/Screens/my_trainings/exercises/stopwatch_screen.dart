import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/models/session_provisional_model.dart';
import 'package:gorilla_grab/models/timer_provisional_records_model.dart';
import 'package:gorilla_grab/models/timer_records_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/session_timer_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';

class StopwatchScreen extends StatelessWidget {
  final ExercisesController exercisesController =
      Get.put(ExercisesController());
  final TrainingController trainingController = Get.put(TrainingController());
  final RecordsController recordsController = Get.put(RecordsController());

  StopwatchScreen(
      {Key? key,
      required this.exerciseModel,
      required this.provisionalExercisesSession,
      required this.provisionalTimerRecordsModel})
      : super(key: key);

  final ProvisionalExercisesSession provisionalExercisesSession;
  final ExerciseModel exerciseModel;
  final ProvisionalTimerRecordsModel provisionalTimerRecordsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tColorPink,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(tSizesBarAppHeight),
          child: CustomAppBarBackExerciseT(
            backColor: tColorPink,
            context: context,
            exercisesController: exercisesController,
            exerciseModel: exerciseModel,
            appBarTitle: '',
          )),
      body: GetBuilder<RecordsController>(builder: (controller) {
        return Stack(children: [
          //Fondo con gradient
          Positioned(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [tColorPink, tColorPinky]))),
          ),

          //Stopwatch
          Positioned(
            top: 200,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                  child: Text(
                recordsController.getFormattedTime(),
                style: tStyleStopwatchInside,
              )),
            ),
          ),

          //Buttons
          ButtonsStopwatch(
              recordsController: recordsController,
              provisionalTimerRecordsModel: provisionalTimerRecordsModel,
              exerciseModel: exerciseModel)
        ]);
      }),
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
    return Positioned(
        bottom: 300,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 300,
            height: 100,
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
                          color: tColorPink,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          color: tColorWhite,
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
                    color: tColorWhite,
                  ),
                  onPressed: () {
                    recordsController.addLap(
                      provisionalTimerRecordsModel:
                          provisionalTimerRecordsModel,
                    );
                    Get.to(() => SessionTimerScreen(
                        provisionalTimerRecordsModel:
                            provisionalTimerRecordsModel,
                        exerciseModel: exerciseModel));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
