import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/home/dashboard_home_screen.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/new_exercise_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/buttons.dart';
import 'package:gorilla_grab/widgets/swiper_builder.dart';

import '../../../constants/sizes.dart';
import '../../../constants/texts.dart';
import '../../../constants/variables.dart';
import '../../../widgets/headers.dart';
import '../../../widgets/titles.dart';
import '../../../models/training_model.dart';

class ExercisesScreen extends StatelessWidget {
  final ExercisesController exercisesController =
      Get.put(ExercisesController());
  final SessionsController sessionsController = Get.put(SessionsController());
  final TrainingController trainingController = Get.put(TrainingController());

  ExercisesScreen({Key? key, required this.trainingModel}) : super(key: key);

  final TrainingModel trainingModel;

  @override
  Widget build(BuildContext context) {
    bool sessionActive = sessionsController.trainingSessionActive(
        trainingId: trainingModel.trainingId);
    return Scaffold(
      backgroundColor: allAppBackground,
      body: GetBuilder<ExercisesController>(builder: (controller) {
        var exercisesList =
            exercisesController.getExercises(trainingModel: trainingModel);
        var sessionsList = sessionsController.getTrainingSessionsList(
            trainingId: trainingModel.trainingId);
        return Container(
          child: Stack(children: [
            //Header
            HeaderWithClear(
              trainingModel: trainingModel,
              onPressed: () => Get.to(DashBoardHomeScreen()),
            ),

            //Container completo exercises
            Positioned(
              top: 110,
              left: 0,
              right: 0,
              child: Container(
                height: 355,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [tColorBottomSheet, tColorBottomSheet],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Stack(
                  children: [
                    //Titulo my exercises

                    TitleWithAddButton(
                      totalNumber: exercisesList.length,
                      trainingModel: trainingModel,
                      title: tTextTitleExercises,
                      subtitle: tTextSubTitleExercises,
                      onPressed: () {
                        Get.to(() => NewExerciseScreen(
                              trainingModel: trainingModel,
                            ));
                      },
                    ),

                    //Lista exercises
                    Positioned(
                      top: 55,
                      right: 0,
                      left: 0,
                      bottom: 35,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0,
                            right: 0,
                            bottom: tSizesMargin,
                            top: tSizesMargin),
                        child:

                            //Container donde están la lita de ejercicios
                            Container(
                                //color: tColorGreeny,
                                child: exercisesList.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0,
                                            left: tSizesMargin,
                                            right: 0,
                                            bottom: 10),
                                        child: Container(
                                            child: Stack(children: [
                                          Positioned(
                                              top: 0,
                                              bottom: 100,
                                              left: 30,
                                              right: 30,
                                              child: Container(
                                                //color: tColorPink,
                                                child: const Image(
                                                  image: AssetImage(
                                                      tImgEmptyExercisesList),
                                                ),
                                              )),
                                          Positioned(
                                            right: 10,
                                            left: 10,
                                            bottom: 0,
                                            child: Container(
                                              width: 50,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Add your first Exercise',
                                                    style: tStyleEmptyTitle,
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  GoButton(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          NewExerciseScreen(
                                                            trainingModel:
                                                                trainingModel,
                                                          ));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          //Banana
                                        ])))
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SingleChildScrollView(
                                          child: Wrap(
                                            spacing: 5.0,
                                            runSpacing: 5.0,
                                            children: List.generate(
                                              exercisesList.length,
                                              (index) => Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    gradient:
                                                        const LinearGradient(
                                                            stops: [
                                                          0.01,
                                                          0.7
                                                        ],
                                                            colors: [
                                                          tColorBottomSheetG1,
                                                          tColorBottomSheetG1,
                                                        ])),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        exercisesList[index]
                                                                .timer
                                                            ? const Icon(
                                                                timerIcon,
                                                                color:
                                                                    tColorWhite,
                                                              )
                                                            : const Icon(
                                                                repIcon,
                                                                color:
                                                                    tColorWhite,
                                                              ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          exercisesList[index]
                                                              .name,
                                                          style:
                                                              tStyleSubTitles,
                                                        ),
                                                        IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          icon: const Icon(
                                                            CupertinoIcons
                                                                .ellipsis_vertical,
                                                            color: tColorWhite,
                                                            size: 15,
                                                          ),
                                                          onPressed: () {
                                                            sessionActive !=
                                                                    true
                                                                ? exercisesController
                                                                    .confirmRemoveMenu(
                                                                    context:
                                                                        context,
                                                                    exerciseModel:
                                                                        exercisesList[
                                                                            index],
                                                                    trainingModel:
                                                                        trainingModel,
                                                                  )
                                                                : null;
                                                          },
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //Container completo sessions
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 380,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [tColorBottomSheetG, tColorBottomSheet],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Stack(children: [
                  //Titulo My sessions
                  TitleWithAddButtonSession(
                    exercisesList: exercisesList,
                    totalNumber: sessionsList.length,
                    trainingModel: trainingModel,
                    title: tTextTitleSessions,
                    subtitle: tTextSubTitleSessions,
                    onPressed: () {
                      exercisesController.addNewExercisesSession(
                          trainingModel: trainingModel);
                    },
                  ),

                  //LISTA SESSIONS
                  Positioned(
                      top: 70,
                      right: 0,
                      left: 0,
                      bottom: 20,
                      child: Container(
                        //height: 400,
                        //color: tColorPink,
                        child: sessionsList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 10,
                                    left: tSizesMargin,
                                    right: 0,
                                    bottom: 10),
                                child: Container(
                                    child: Stack(children: [
                                  Positioned(
                                      top: 0,
                                      bottom: 100,
                                      left: 70,
                                      right: 70,
                                      child: Container(
                                        //color: tColorPink,
                                        child: Image(
                                          image:
                                              AssetImage(tImgEmptySessionsList),
                                        ),
                                      )),
                                  Positioned(
                                    right: 0,
                                    left: 0,
                                    bottom: 30,
                                    child: Container(
                                      //color: tColorGreen,
                                      width: 50,
                                      child: Column(
                                        children: [
                                          Text(
                                            'No saved sessions yet',
                                            style: tStyleEmptyTitle,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'Add at least 1 exercise to initiate a session :)',
                                            style: tStyleEmptySubtitle,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Banana
                                ])))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: tSizesMargin),
                                child: SwipeBuilder(
                                  contextSwiper: context,
                                  exercisesController: exercisesController,
                                  sessionsList: sessionsList,
                                  trainingModel: trainingModel,
                                ),
                              ),
                      )),
                ]),
              ),
            ),
          ]),
        );
      }),
    );
  }
}

class CardTileSession extends StatelessWidget {
  const CardTileSession({
    super.key,
    required this.title,
    required this.titleData,
  });

  final String title;
  final String titleData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: tStyleCardSession,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            titleData,
            softWrap: true,
            maxLines: 2,
            style: tStyleCardNumberSession,
          )
        ],
      ),
    );
  }
}

class ClearCard extends StatelessWidget {
  const ClearCard({
    super.key,
    required this.exercisesController,
    required this.exercisesList,
    required this.trainingModel,
    this.onPressed,
    required this.color,
  });

  final ExercisesController exercisesController;
  final List<ExerciseModel> exercisesList;
  final TrainingModel trainingModel;
  final void Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
          icon: Icon(
            CupertinoIcons.clear,
            size: 15,
            color: color,
          ),
          onPressed: onPressed),
    );
  }
}
