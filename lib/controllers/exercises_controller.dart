import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/models/gap_performance_model.dart';
import 'package:gorilla_grab/models/rep_records_model.dart';
import 'package:gorilla_grab/models/session_provisional_model.dart';
import 'package:gorilla_grab/models/session_finished_model.dart';
import 'package:gorilla_grab/models/timer_records_model.dart';
import 'package:gorilla_grab/models/training_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/exercises_screen.dart';
import 'package:gorilla_grab/Screens/my_trainings/session/training_session_provisional_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class ExercisesController extends GetxController {
  final SessionsController sessionsController = Get.put(SessionsController());
  final RecordsController recordsController = Get.put(RecordsController());
  final PerformanceController performanceController =
      Get.put(PerformanceController());
  // final TrainingController trainingController = Get.put(TrainingController());

  List<ExerciseModel> allExercises = [];

//To show or not the clear icon
  bool isVisible = false;
  void showClearIcon({required String isFilled}) {
    isVisible = isFilled.isNotEmpty;
    update();
  }

//To  highlight Timer:
  TextStyle isTimer({required bool isTimer}) {
    TextStyle textStyle = const TextStyle(
        color: tColorWhite,
        fontSize: 20,
        fontFamily: fontInputs,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        letterSpacing: 0);

    if (isTimer != true) {
      textStyle = const TextStyle(
          color: tColorWhite,
          fontSize: 20,
          fontFamily: fontInputs,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          letterSpacing: 0);
    } else {
      textStyle = const TextStyle(
          color: tColorPink,
          fontSize: 20,
          fontFamily: fontInputs,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          letterSpacing: 0);
    }

    return textStyle;
  }

//To  highlight Repetition:
  TextStyle isRep({required bool isRep}) {
    TextStyle textStyle = tStyleInputIsRep;

    if (isRep != false) {
      textStyle = const TextStyle(
          color: tColorWhite,
          fontSize: 20,
          fontFamily: fontInputs,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          letterSpacing: 0);
    } else {
      textStyle = const TextStyle(
          color: tColorPrimary_2,
          fontSize: 20,
          fontFamily: fontInputs,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          letterSpacing: 0);
    }

    return textStyle;
  }

//To create new exercise
  void addNewExercise(
      {required String exerciseName,
      required bool isTimer,
      required TrainingModel trainingModel,
      required int exerciseColor}) {
    if (isTimer) {
      ExerciseModel newExercise = ExerciseModel(
        trainingId: trainingModel.trainingId,
        exerciseId: UniqueKey().toString(),
        name: exerciseName,
        timer: isTimer,
        color: exerciseColor,
        creationDate: DateTime.now(),
      );

      allExercises.add(newExercise);
    } else {
      ExerciseModel newExercise = ExerciseModel(
        trainingId: trainingModel.trainingId,
        exerciseId: UniqueKey().toString(),
        name: exerciseName,
        timer: isTimer,
        color: exerciseColor,
        creationDate: DateTime.now(),
      );

      allExercises.add(newExercise);
    }

    update();
  }

//To remove exercise:
  void removeExercise({
    required ExerciseModel exerciseModel,
    //required TrainingModel trainingModel,
  }) {
    int ejIndex = allExercises.indexWhere(
      (id) => id.exerciseId == exerciseModel.exerciseId,
    );

    allExercises.removeAt(ejIndex);

    update();
  }

//To get the exercises list of a Training:
  List<ExerciseModel> getExercises({required TrainingModel trainingModel}) {
    List<ExerciseModel> trainingExercisesList = [];

    for (var el in allExercises) {
      if (el.trainingId == trainingModel.trainingId) {
        trainingExercisesList.add(el);
      }
    }
    return trainingExercisesList;
  }

//To get the icon of an excercise;
  Icon getExerciseIcon({required bool isTimer, required Color color}) {
    double iconSize = 40;
    Icon icon = Icon(
      timerIcon,
      size: iconSize,
      color: color,
    );

    if (isTimer != true) {
      icon = Icon(
        repIcon,
        size: iconSize,
        color: color,
      );
    }

    return icon;
  }

//To get the color of an exercise:
  Color getExerciseColor({required bool isTimer}) {
    Color exerciseColor = timerColor;
    if (isTimer != true) {
      exerciseColor = repColor;
    }

    return exerciseColor;
  }

//To get the exercise name with the id
  String getExerciseName({required String exerciseId}) {
    ExerciseModel exerciseModel =
        allExercises.firstWhere((element) => element.exerciseId == exerciseId);

    String exerciseName = exerciseModel.name;
    return exerciseName;
  }

//To get the exercise Model with the id
  ExerciseModel getExerciseModel({required String exerciseId}) {
    ExerciseModel exerciseModel =
        allExercises.firstWhere((element) => element.exerciseId == exerciseId);

    return exerciseModel;
  }

//to create the provisional Session:
  void addNewExercisesSession({required TrainingModel trainingModel}) {
    var exercisesList = getExercises(trainingModel: trainingModel);
    String sessionId = UniqueKey().toString();

    //add the session Id (before empty) to the exercises
    for (var el in getExercises(trainingModel: trainingModel)) {
      el.sessionId = sessionId;
    }

    ProvisionalExercisesSession newExercisesSession =
        ProvisionalExercisesSession(
            trainingId: trainingModel.trainingId,
            exercisesSessionId: sessionId,
            exercisesSessionDate: DateTime.now(),
            exercisesSessionExercises: exercisesList);

    sessionsController.provisionalSessions.add(newExercisesSession);

    Get.to(TrainingSessionScreen(
      trainingModel: trainingModel,
      exercisesSession: newExercisesSession,
    ));
    update();
  }

//to remove Exercises Session finished:
  void removeExercisesSessionFinished({
    required SessionFinished sessionFinished,
  }) {
    String sessionId = sessionFinished.sessionId;

    int finishedSessionIndex = sessionsController.allSessions
        .indexWhere((id) => id.sessionId == sessionId);

    sessionsController.allSessions.removeAt(finishedSessionIndex);
    List<TimerRecordsModel> timerRecordsList =
        recordsController.finalTimerRecordsList;
    List<RepRecordsModel> repRecordsList =
        recordsController.finalRepRecordsList;

    List<int> timerIndexList = [];
//Remove the records corresponding to that session:

    timerRecordsList.removeWhere(
      (element) => element.sessionId == sessionId,
    );

    repRecordsList.removeWhere(
      (element) => element.sessionId == sessionId,
    );

//Remove performance records

    performanceController.gapPerformanceList.removeWhere(
      (element) => element.gapSessionId == sessionId,
    );

    update();
  }

//to remove Exercises Session provisional:
  void removeExercisesSessionProvisional({
    required TrainingModel trainingModel,
    required ProvisionalExercisesSession exercisesSession,
  }) {
    int provisionalSessionIndex = sessionsController.provisionalSessions
        .indexWhere((id) =>
            id.exercisesSessionId == exercisesSession.exercisesSessionId);

    try {
      sessionsController.provisionalSessions.removeAt(provisionalSessionIndex);
    } catch (e) {}

    //Remove the provisionalRepRecordList:

    recordsController.provisionalTimerRecordsList.removeWhere(
      (element) => element.sessionId == exercisesSession.exercisesSessionId,
    );

    recordsController.provisionalRepRecordsList.removeWhere(
      (element) => element.sessionId == exercisesSession.exercisesSessionId,
    );

    update();
  }

//To deploy bottomsheet: training remove
  void confirmRemoveMenu({
    required BuildContext context,
    required ExerciseModel exerciseModel,
    required TrainingModel trainingModel,
  }) {
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
                      tTextRemoveConfirmation,
                      style: tStyleBottomSheet,
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
                            text: tTextCancel,
                            onPressed: () {
                              Get.back();
                            }),
                        CustomButtonBottomSheet(
                            heigh: 40,
                            width: 160,
                            text: tTextRemove,
                            onPressed: () {
                              removeExercise(
                                exerciseModel: exerciseModel,
                              );
                              Get.back();
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

//To deploy bottomSheet: session finished remove
  void confirmRemoveMenuSessionFinished(
      {required BuildContext context,
      //required ProvisionalExercisesSession exercisesSession,
      required TrainingModel trainingModel,
      required SessionFinished sessionFinished}) {
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
                      tTextRemoveConfirmationSession,
                      style: tStyleBottomSheet,
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
                            text: tTextCancel,
                            onPressed: () {
                              Get.back();
                            }),
                        CustomButtonBottomSheet(
                            heigh: 40,
                            width: 160,
                            text: tTextDelete,
                            onPressed: () {
                              removeExercisesSessionFinished(
                                sessionFinished: sessionFinished,
                              );
                              Get.to(() => ExercisesScreen(
                                    trainingModel: trainingModel,
                                  ));
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

//To deploy bottomSheet: session provisional remove
  void confirmRemoveMenuSessionProvisional({
    required BuildContext context,
    required ProvisionalExercisesSession exercisesSession,
    required TrainingModel trainingModel,
  }) {
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
                      tTextRemoveConfirmationSession,
                      style: tStyleBottomSheet,
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
                            text: tTextCancel,
                            onPressed: () {
                              Get.back();
                            }),
                        CustomButtonBottomSheet(
                            heigh: 40,
                            width: 160,
                            text: tTextDelete,
                            onPressed: () {
                              removeExercisesSessionProvisional(
                                trainingModel: trainingModel,
                                exercisesSession: exercisesSession,
                              );
                              Get.to(() => ExercisesScreen(
                                    trainingModel: trainingModel,
                                  ));
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

//To save the session
  void saveTrainingSession(
      {required TrainingModel trainingModel,
      required ProvisionalExercisesSession exercisesSession,
      required String comment}) {
    int sessionIndex = sessionsController.provisionalSessions.indexWhere((id) =>
        id.exercisesSessionId == exercisesSession.exercisesSessionId &&
        id.isClosed == false);

// -- Sessions data

    sessionsController.provisionalSessions[sessionIndex].isClosed = true;

    //Finds provisional session:
    ProvisionalExercisesSession selectedSession =
        sessionsController.provisionalSessions[sessionIndex];

    String startTime =
        selectedSession.exercisesSessionDate.toString().substring(11, 16);
    var time = DateTime.now();

    String endTime = time.toString().substring(11, 16);

    //Creates finished session with the provisional session info:
    SessionFinished newSessionFinished = SessionFinished(
        sessionId: UniqueKey().toString(),
        createdAt: DateTime.now(),
        startTime: startTime,
        endTime: endTime,
        sessionDuration: sessionsController.calculateSessionTime(
            startTime: startTime, endTime: endTime),
        trainingId: trainingModel.trainingId,
        trainingName: trainingModel.name,
        exercisesListFinished: selectedSession.exercisesSessionExercises,
        sessionComment: comment);

    //Adds the finished session to the finished sessions list:
    sessionsController.allSessions.add(newSessionFinished);

// -- Records data

    //Adding the final TimerRecords
    for (var el in recordsController.provisionalTimerRecordsList) {
      TimerRecordsModel timerRecordsModel = TimerRecordsModel(
        recordDay: el.recordDay,
        sessionId: newSessionFinished.sessionId,
        exerciseId: el.exerciseId,
        trainingId: newSessionFinished.trainingId,
        timerRecordsId: el.timerRecordsId,
        timerRecordsList: el.timerRecordsList,
      );

      recordsController.finalTimerRecordsList.add(timerRecordsModel);

      //Adding the GapPerformanceModel

      String currentTimerRecord =
          recordsController.getRecordsSum(recordsList: el.timerRecordsList);

      String lastTimerRecord = recordsController.getLastTimerRecordSum(
        currentRecordDate: timerRecordsModel.recordDay,
        exerciseId: timerRecordsModel.exerciseId,
      );
      double timerGap = recordsController.calculateTimerRecordsGap(
          currentRecord: currentTimerRecord, lastRecord: lastTimerRecord);

      int timerGapInt = 999888777666;

      try {
        timerGapInt = timerGap.toInt();
      } catch (e) {}

      GapPerformanceModel newGapPerformanceModelTimer = GapPerformanceModel(
          gapId: UniqueKey().toString(),
          gapCreationDate: timerRecordsModel.recordDay,
          gapSessionId: timerRecordsModel.sessionId,
          gapTrainingId: timerRecordsModel.trainingId,
          gapExerciseId: timerRecordsModel.exerciseId,
          gapPerformance: currentTimerRecord,
          gapExerciseName:
              getExerciseName(exerciseId: timerRecordsModel.exerciseId),
          gapPercentagePerformance: timerGapInt);

      performanceController.gapPerformanceList.add(newGapPerformanceModelTimer);
    }

    //Adding the final RepRecord
    for (var el in recordsController.provisionalRepRecordsList) {
      RepRecordsModel repRecordsModel = RepRecordsModel(
        recordDay: el.recordDay,
        sessionId: newSessionFinished.sessionId,
        exerciseId: el.exerciseId,
        trainingId: newSessionFinished.trainingId,
        repRecordsId: el.repRecordsId,
        repRecord: el.repRecord,
      );
      recordsController.finalRepRecordsList.add(repRecordsModel);
      //Adding the GapPerformanceModel

      String currentRepRecord = repRecordsModel.repRecord.toString();
      currentRepRecord.length < 2
          ? currentRepRecord = '0$currentRepRecord'
          : currentRepRecord = currentRepRecord;

      String lastRepRecord = recordsController.getRepFormat(
          repRecord: recordsController
              .findLastRepModelBeforeDate(
                currentRecordDate: repRecordsModel.recordDay,
                exerciseId: repRecordsModel.exerciseId,
              )
              .repRecord);

      double repGap = recordsController.calculateRepRecordsGap(
          currentRecord: currentRepRecord, lastRecord: lastRepRecord);
      int repGapInt = 999888777666;

      lastRepRecord == '9999' ? repGap = 0.01 : repGap = repGap;
      repGapInt = repGap.toInt();

      GapPerformanceModel newGapPerformanceModelRep = GapPerformanceModel(
          gapId: UniqueKey().toString(),
          gapCreationDate: repRecordsModel.recordDay,
          gapSessionId: repRecordsModel.sessionId,
          gapTrainingId: repRecordsModel.trainingId,
          gapExerciseId: repRecordsModel.exerciseId,
          gapPerformance: currentRepRecord,
          gapExerciseName:
              getExerciseName(exerciseId: repRecordsModel.exerciseId),
          gapPercentagePerformance: repGapInt);

      performanceController.gapPerformanceList.add(newGapPerformanceModelRep);
    }

    update();
  }

//To deploy bottomSheet: save session
  void confirmSaveSession(
      {required BuildContext context,
      required ProvisionalExercisesSession provisionalExercisesSession,
      required TrainingModel trainingModel}) {
    TextEditingController commentController =
        TextEditingController(); // Controlador para el campo de entrada de texto
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
                  //Main text
                  const SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          tTextCloseConfirmationSession,
                          softWrap: true,
                          style: tStyleBottomSheetSmaller,
                        ),
                        Text(
                          softWrap: true,
                          tTextCloseConfirmationSessionAd,
                          style: tStyleBottomSheetHighlighted,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //Session Comment
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: tColorBottomSheetG,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: tStyleBottomSheetComment,
                      controller: commentController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        // filled: true,
                        // fillColor: tColorBottomSheetG1,
                        hintText: 'Add any final comment here.',
                        hintStyle: tStyleBottomSheetCommentHint,

                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Buttons
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonBottomCancel(
                            heigh: 40,
                            width: 160,
                            text: tTextCancel,
                            onPressed: () {
                              Get.back();
                            }),
                        CustomButtonBottomSheet(
                            heigh: 40,
                            width: 160,
                            text: tButtonSaveSession,
                            onPressed: () {
                              String comment = commentController.text;

                              comment.isEmpty
                                  ? comment = ' - '
                                  : comment = comment;
                              saveTrainingSession(
                                  trainingModel: trainingModel,
                                  exercisesSession: provisionalExercisesSession,
                                  comment: comment);
                              removeExercisesSessionProvisional(
                                  trainingModel: trainingModel,
                                  exercisesSession:
                                      provisionalExercisesSession);
                              Get.to(() => ExercisesScreen(
                                    trainingModel: trainingModel,
                                  ));
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
}
