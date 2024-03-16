import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/trainings/edit_training_screen%20copy.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import 'package:gorilla_grab/widgets/bottom_sheets.dart';
import '../models/training_model.dart';


class TrainingController extends GetxController {
  final ExercisesController exercisesController =
      Get.put(ExercisesController());

  //Firebase data:  
  late final db = FirebaseFirestore.instance;
  late final usersMap = db.collection('users');
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  late final userTrainingsData = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('trainings');

  List<TrainingModel> myTrainingsList = [];

  // Reading data from Firebase:

  bool _dataLoaded = false;

  @override
  void onInit() {
    super.onInit();

    _loadTrainings();
  }

  void _loadTrainings() async {
    if (_dataLoaded) {
      return;
    }

    final userTrainings = await userTrainingsData.get();

    if (userTrainings.docs.isNotEmpty) {
      for (var doc in userTrainings.docs) {
        // Extraer los datos del documento

          String trainingId = doc['trainingId'];
          String name = doc['name'];
          String user = doc['user'];
          DateTime creationDate = doc['creationDate'].toDate();
          int color = doc['color'];

          // Crear un modelo TrainingModel
          TrainingModel trainingModel = TrainingModel(
            trainingId: trainingId,
            name: name,
            user: user,
            creationDate: creationDate,
            color: color,
          );

          // Agregar el modelo a la lista
          myTrainingsList.add(trainingModel);
        
        _dataLoaded = true;

      }   
      update();
    }
  }
  // End readind data from Firebase

  //To create new training:FB OK
  addNewTraining(
      {required String trainingName,
      required int trainingColor,
      required String user})  {

    String trainingkey = UniqueKey().toString();

    TrainingModel newTraining = TrainingModel(
        user: user,
        trainingId: trainingkey,
        name: trainingName,
        creationDate: DateTime.now(),
        color: trainingColor);
    
    myTrainingsList.add(newTraining);

    //add training doc Firestore:
    final data = {
      "user": user, 
      "trainingId": trainingkey,
      "name": trainingName,
      "creationDate": DateTime.now(),
      "color": trainingColor,
      };

    userTrainingsData.add(data).then((documentSnapshot) =>
    print("Added Data with ID: ${documentSnapshot.id}"));


    update();
  }

  //To update the training: FB OK
  updateTraining({
    required TrainingModel trainingModel,
    required String newName,
    required int newColor,
  })async {
    trainingModel.name = newName;
    trainingModel.color = newColor;

    String idTrainingCollection = trainingModel.trainingId;

    CollectionReference trainingsRef = FirebaseFirestore.instance
    .collection('users')
    .doc(userEmail)
    .collection('trainings');

    QuerySnapshot querySnapshot = await trainingsRef.get();

   for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
    String id = docSnapshot.id;
    String path = docSnapshot.reference.path;
    print('ID misterio: ${id.toString()}'); 
   }

    DocumentSnapshot? docSnapshotInside = null;
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      String idTrainingUnique = docSnapshot.id; // Assuming the ID is within the document
      docSnapshotInside = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userEmail)
                                .collection('trainings')
                                .doc(idTrainingUnique)
                                .get();

      final docSnapshotForUpdate = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userEmail)
                                .collection('trainings')
                                .doc(idTrainingUnique);
                                

    // Check and access data only after fetching
      if (docSnapshotInside!.exists) {
        Object? data = docSnapshotInside.data();
        String trainingIdData = (data as Map<String, dynamic>)['trainingId'];
        print('$trainingIdData - $idTrainingCollection');
        if (trainingIdData == idTrainingCollection) {

          //Update de datos training
          docSnapshotForUpdate.update({
            'name':newName,
            'color':newColor
          }).then(
                  (value) => print("DocumentSnapshot successfully updated!"),
                  onError: (e) => print("Error updating document $e"));


        }else{}
      } else {
        print('Document not found'); // Handle non-existent document
      }
    
    }
    update();
  }

  //To remove the training: FB OK
  removeTraining({required TrainingModel trainingModel})async {
    int trainingIndex = myTrainingsList.indexWhere(
      (training) => training.trainingId == trainingModel.trainingId,
    );

    myTrainingsList.removeAt(trainingIndex);

    String idTrainingCollection = trainingModel.trainingId;

    CollectionReference trainingsRef = FirebaseFirestore.instance
    .collection('users')
    .doc(userEmail)
    .collection('trainings');

    QuerySnapshot querySnapshot = await trainingsRef.get();

   for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
    
   }

    DocumentSnapshot? docSnapshotInside = null;
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      String idTrainingUnique = docSnapshot.id; // Assuming the ID is within the document
      docSnapshotInside = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userEmail)
                                .collection('trainings')
                                .doc(idTrainingUnique)
                                .get();

      final docSnapshotForDelete =  FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userEmail)
                                    .collection('trainings')
                                    .doc(idTrainingUnique);
                                
    // Check and access data only after fetching
      if (docSnapshotInside!.exists) {
        Object? data = docSnapshotInside.data();
        String trainingIdData = (data as Map<String, dynamic>)['trainingId'];
        
        if (trainingIdData == idTrainingCollection) {

          //Delete document Firebase
          try{
            docSnapshotForDelete.delete();
            print('Doc DELETED');
          }
          catch(e){print(e);}
        }else{}
      } else {
        print('Document not found'); // Handle non-existent document
      }
    
    }

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

//To deploy options menu
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

          return BottomSheetContentDelete(
            object: 'training' ,
            onPressedCancel: ()=>Get.back() ,
            onPressedOk: () {
                              removeTraining(trainingModel: trainingModel);
                              Get.to(() => DashBoardHomeScreen());
                              update();
        
            }
          );
        }
    );
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

  TrainingModel getTrainingModel(
      {required String trainingId, required String user}) {
    TrainingModel trainingModel = TrainingModel(
        user: user,
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
