import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import 'package:gorilla_grab/widgets/bottom_sheets.dart';
import 'package:gorilla_grab/widgets/buttons.dart';

class ExercisesController extends GetxController {
  final SessionsController sessionsController = Get.put(SessionsController());
  final RecordsController recordsController = Get.put(RecordsController());
  final PerformanceController performanceController =
      Get.put(PerformanceController());

  //Firebase data:
  late final db = FirebaseFirestore.instance;
  late final usersMap = db.collection('users');
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  late final userExercisesData = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('exercises');

  List<ExerciseModel> allExercises = [];

  // Reading data from Firebase:
  bool _dataLoaded = false;

  @override
  void onInit() {
    super.onInit();
    _loadExercises();
  }

  void _loadExercises() async {
    if (_dataLoaded) {
      return;
    }

    final userExercises = await userExercisesData.get();

    if (userExercises.docs.isNotEmpty) {
      for (var doc in userExercises.docs) {
        // Extraer los datos del documento

          String user = doc['user'];
          String trainingId = doc['trainingId'];
          String exerciseId = doc['exerciseId'];
          String sessionId = doc['sessionId'];
          String name = doc['name'];
          bool timer = doc['timer'];
          int color = doc['color'];
          bool closed = doc['closed'];
          DateTime creationDate = doc['creationDate'].toDate();
         

          // Crear un modelo ExerciseModel
          ExerciseModel exerciseModel = ExerciseModel(
            user:user,
            trainingId: trainingId,
            exerciseId: exerciseId,
            name:name,
            timer: timer,
            color: color,
            closed: closed,
            creationDate: creationDate
            );

          // Agregar el modelo a la lista
          allExercises.add(exerciseModel);
        

        _dataLoaded = true;

      }

       
      update();
    }
  }
  // End readind data from Firebase

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

//To create new exercise: FB OK
  void addNewExercise(
      {required String exerciseName,
      required bool isTimer,
      required TrainingModel trainingModel,
      required int exerciseColor,
      required String user}) {

    
    if (isTimer) {

      String exerciseUniqueIdTimer = UniqueKey().toString();
      ExerciseModel newExercise = ExerciseModel(
        user: user,
        trainingId: trainingModel.trainingId,
        exerciseId: exerciseUniqueIdTimer,
        
        name: exerciseName,
        timer: isTimer,
        color: exerciseColor,
        closed: false,
        creationDate: DateTime.now(),
      );

      allExercises.add(newExercise);
      
      //add training doc Firestore:

        final data = {
          "user": user, 
          "trainingId": trainingModel.trainingId,
          "exerciseId": exerciseUniqueIdTimer,
          "sessionId": '-',
          "name": exerciseName,
          "timer": isTimer,
          "color": exerciseColor,
          "closed": false,
          "creationDate": DateTime.now(),
          
          };

        userExercisesData.add(data);

    } else {
      String exerciseUniqueIdRep = UniqueKey().toString();
      ExerciseModel newExercise = ExerciseModel(
        user: user,
        trainingId: trainingModel.trainingId,
        exerciseId: exerciseUniqueIdRep,
        
        name: exerciseName,
        timer: isTimer,
        color: exerciseColor,
        closed: false,
        creationDate: DateTime.now(),
      );

      allExercises.add(newExercise);
      //add training doc Firestore:

        final data = {
          "user": user, 
          "trainingId": trainingModel.trainingId,
          "exerciseId": exerciseUniqueIdRep,
          "sessionId": '-',
          "name": exerciseName,
          "timer": isTimer,
          "color": exerciseColor,
          "closed": false,
          "creationDate": DateTime.now(),
          
          };

        userExercisesData.add(data);
    }

    update();
  }

//To remove exercise: FB OK
  void removeExercise({
    required ExerciseModel exerciseModel,
    //required TrainingModel trainingModel,
  }) async {
    int ejIndex = allExercises.indexWhere(
      (id) => id.exerciseId == exerciseModel.exerciseId,
    );

    allExercises.removeAt(ejIndex);

    String idExerciseCollection = exerciseModel.exerciseId;

    CollectionReference exercisesRef = FirebaseFirestore.instance
    .collection('users')
    .doc(userEmail)
    .collection('exercises');

    QuerySnapshot querySnapshot = await exercisesRef.get();

   for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
    
   }

    DocumentSnapshot? docSnapshotInside = null;
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      String idExerciseUnique = docSnapshot.id; // Assuming the ID is within the document
      docSnapshotInside = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userEmail)
                                .collection('exercises')
                                .doc(idExerciseUnique)
                                .get();

      final docSnapshotForDelete =  FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userEmail)
                                    .collection('exercises')
                                    .doc(idExerciseUnique);
                                

    // Check and access data only after fetching
      if (docSnapshotInside!.exists) {
        Object? data = docSnapshotInside.data();
        String exerciseIdData = (data as Map<String, dynamic>)['exerciseId'];

        
        if (exerciseIdData == idExerciseCollection) {

          //Delete document Firebase
          try{
            docSnapshotForDelete.delete();
            print(' Exercise DELETED');
          }
          catch(e){print(e);}
        }else{}
      } else {
        print('Document Exercise not found'); // Handle non-existent document
      }
    
    }


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

    //Link to add within Firestore
    sessionsController.addFirestoreProvisionalSessionData(
      trainingId: trainingModel.trainingId,
      exerciseSessionId: sessionId, 
      exercisesSessionDate: DateTime.now(), 
      exercisesSessionExercises: exercisesList);

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
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (BuildContext context) {

            return BottomSheetContentDelete(
              object: 'exercise',
              onPressedOk: (){
                removeExercise(exerciseModel: exerciseModel);
                Get.back();
              } ,
            );
        }
    );            
  }

//To deploy bottomSheet: session finished remove
  void confirmRemoveMenuSessionFinished(
      {required BuildContext context,
      required TrainingModel trainingModel,
      required SessionFinished sessionFinished}) {
    showModalBottomSheet(
        backgroundColor: tColorBottomSheet,
        showDragHandle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (BuildContext context) {

            return BottomSheetContentDelete(
              object: 'session',
              onPressedOk:() {
                  removeExercisesSessionFinished(sessionFinished: sessionFinished);
                  Get.to(() => ExercisesScreen(trainingModel: trainingModel)); 
              } ,
            );
        }
    );
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (BuildContext context) {

          return BottomSheetContentDelete(
            object: 'session',
            onPressedOk:() {
                removeExercisesSessionProvisional(
                  trainingModel: trainingModel,
                  exercisesSession: exercisesSession,
                );
                Get.to(() => ExercisesScreen(trainingModel: trainingModel,));
            } ,
          );
        }
    );
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
    String sessionId = UniqueKey().toString();
    DateTime createdAt = DateTime.now();
    String sessionDuration = sessionsController.calculateSessionTime(
                             startTime: startTime, endTime: endTime);

    SessionFinished newSessionFinished = SessionFinished(
        sessionId: sessionId,
        createdAt: createdAt,
        startTime: startTime,
        endTime: endTime,
        sessionDuration: sessionDuration,
        trainingId: trainingModel.trainingId,
        trainingName: trainingModel.name,
        exercisesListFinished: selectedSession.exercisesSessionExercises,
        sessionComment: comment);

    //Adds the finished session to the finished sessions list:
    sessionsController.allSessions.add(newSessionFinished);

    //Link to add the final Session within Firestore:
    sessionsController.addFirestoreFinalSessionData(
      sessionId: sessionId, 
      createdAt: createdAt, 
      startTime: startTime, 
      endTime: endTime, 
      sessionDuration: sessionDuration, 
      trainingId: trainingModel.trainingId, 
      trainingName: trainingModel.name, 
      exercisesSessionExercises: selectedSession.exercisesSessionExercises, 
      sessionComment: comment);

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
        isScrollControlled: true,
        backgroundColor: tColorBottomSheet,
        showDragHandle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: BottomSheetSaveSession(
              onPressed: () {

                  String comment = commentController.text;

                  comment.isEmpty
                      ? comment = ' - '
                      : comment = comment;

                  saveTrainingSession(
                      trainingModel: trainingModel,
                      exercisesSession:
                          provisionalExercisesSession,
                      comment: comment);

                  removeExercisesSessionProvisional(
                      trainingModel: trainingModel,
                      exercisesSession:
                          provisionalExercisesSession);

                  Get.to(() => ExercisesScreen(trainingModel: trainingModel));
              },
            )
            
          );
        });
  }
}
