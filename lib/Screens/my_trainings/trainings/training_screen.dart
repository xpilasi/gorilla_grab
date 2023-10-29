// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/session_finished_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/exercises_screen.dart';
import 'package:gorilla_grab/Screens/my_trainings/trainings/new_training_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';
import 'package:gorilla_grab/widgets/headers.dart';

// ignore: must_be_immutable
class TrainingsScreen extends StatelessWidget {
  final SessionsController sessionsController = Get.put(SessionsController());

  TrainingsScreen({Key? key}) : super(key: key);
  TrainingController trainingController = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allAppBackground,
      body: GetBuilder<TrainingController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(
              right: tSizesMargin, top: tSizesMargin, bottom: tSizesMargin),
          child: trainingController.myTrainingsList.isEmpty
              ? Container(
                  child: Stack(
                    children: [
                      //Add your 1st training go!
                      Positioned(
                        bottom: 0,
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          //color: tColorBlue,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              const Image(
                                image: AssetImage(tImgMonstera),
                                width: 250,
                              ),
                              Text(
                                'Add your 1st training!',
                                style: tStyleEmptyTitle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GoButton(
                                onPressed: () {
                                  Get.to(() => NewTrainingScreen());
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                          //color: tColorGreen,
                          height: 100,
                          child: const HeaderForMenu(title: 'My trainings')),
                    ),
                    Positioned(
                      top: 80,
                      right: 0,
                      left: 0,
                      bottom: 50,
                      child: ListView.builder(
                        itemCount: trainingController.myTrainingsList.length,
                        itemBuilder: (context, index) {
                          final trainingModel =
                              trainingController.myTrainingsList[index];
                          final List<SessionFinished> sessionsFinished =
                              sessionsController.getTrainingSessionsList(
                                  trainingId: trainingModel.trainingId);
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, top: 8.0, bottom: 8.0, left: 20),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [
                                      tColorBottomSheetG1,
                                      tColorBottomSheetG1,

                                      //tColorBottomSheet
                                    ],
                                    stops: [
                                      0.001,
                                      0.5,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                              ),
                              child: Stack(
                                children: [
                                  //Iconos
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      //color: tColorGreen,
                                      width: 140,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: tSizesMargin,
                                              ),
                                              const Icon(
                                                timerIcon,
                                                color: tColorWhite,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                trainingController
                                                    .timerExercisesNumber(
                                                  trainingModel: trainingModel,
                                                ),
                                                style: tStyleCardIcons,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: tSizesMargin,
                                              ),
                                              const Icon(
                                                repIcon,
                                                color: tColorWhite,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                trainingController
                                                    .repExercisesNumber(
                                                  trainingModel: trainingModel,
                                                ),
                                                style: tStyleCardIcons,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Menu elipsis
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: tSizesMargin),
                                      child: PopupMenuButton<String>(
                                        icon: const Icon(
                                          CupertinoIcons.ellipsis_vertical,
                                          color: Colors.white,
                                        ),
                                        onSelected: (value) {
                                          trainingController
                                              .handleMenuOptionSelected(
                                                  value,
                                                  index,
                                                  context,
                                                  trainingModel);
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'Edit',
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Edit'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'Delete',
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Delete'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Contenedor de training
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 280,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          Get.to(() => ExercisesScreen(
                                                trainingModel: trainingModel,
                                              ));
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: tSizesMargin * 2,
                                                vertical: tSizesMargin),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  trainingModel.name,
                                                  style: tStyleCardTraining,
                                                ),
                                                sessionsFinished.isNotEmpty
                                                    ? Text(
                                                        'Sessions: ${sessionsFinished.length.toString()}',
                                                        style: tStyleSubTitles,
                                                      )
                                                    : Text(
                                                        'No sessions',
                                                        style: tStyleSubTitles,
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    //New training button
                    Positioned(
                      top: 47,
                      right: 10,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: tColorTurk,
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.add,
                            color: tColorWhite,
                          ),
                          onPressed: () {
                            Get.to(() => NewTrainingScreen());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
