import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/session_finished_model.dart';
import 'package:gorilla_grab/models/training_model.dart';
import 'package:gorilla_grab/Screens/my_trainings/exercises/exercises_screen.dart';
import 'package:gorilla_grab/Screens/my_trainings/session/training_session_finished_screen.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/exercises_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';

class SwipeBuilder extends StatelessWidget {
  SwipeBuilder({
    super.key,
    required this.trainingModel,
    required this.contextSwiper,
    required this.exercisesController,
    required this.sessionsList,
  });

  final TrainingModel trainingModel;
  final BuildContext contextSwiper;
  final ExercisesController exercisesController;
  final List<SessionFinished> sessionsList;
  final SessionsController sessionsController = Get.put(SessionsController());

  @override
  Widget build(BuildContext context) {
    var savedTrainingSessionsList = sessionsController.getTrainingSessionsList(
        trainingId: trainingModel.trainingId);

    savedTrainingSessionsList = savedTrainingSessionsList.reversed.toList();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Swiper(
          itemHeight: 250,
          itemWidth: 400,
          loop: true,
          duration: 200,
          scrollDirection: Axis.vertical,
          itemCount: savedTrainingSessionsList.length,
          layout: SwiperLayout.STACK,
          itemBuilder: (contextSwiper, index) {
            String time = savedTrainingSessionsList[index].startTime;
            String fullDate = savedTrainingSessionsList[index]
                .createdAt
                .toString()
                .substring(0, 10);
            SessionFinished exercisesSession = savedTrainingSessionsList[index];

            int sessionNumber = sessionsController.getSessionFinishedNumber(
                sessionFinished: exercisesSession);
            String endTime = exercisesSession.endTime;

            String totalTimer = exercisesSession.sessionDuration;
            return Container(
              height: 250,
              width: 250,

              //Card decoration
              decoration: index % 2 == 0
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [tColorPink, tColorPrimary]))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [tColorBlue, tColorBlue])),
              child:

                  //All the Card content
                  Stack(children: [
                Container(
                  child: Positioned.fill(
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: index % 2 == 0
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const RadialGradient(
                                  colors: [tColorPinky, Colors.transparent],
                                  center: Alignment(-1.2, -0.9),
                                  radius: 1.3,
                                ),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const RadialGradient(
                                  colors: [tColorPrimary_4, Colors.transparent],
                                  center: Alignment(-1.2, -0.9),
                                  radius: 1.3,
                                ),
                              )),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const RadialGradient(
                        colors: [tColorPrimary_3, Colors.transparent],
                        center: Alignment(1.2, 0.7),
                        radius: 1.5,
                      ),
                    ),
                  ),
                ),

                //Session Card arrow to access saved data
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      color: tColorWhite,
                      size: 40,
                    ),
                    onPressed: () {
                      Get.to(() => TrainingSessionFinishedScreen(
                            trainingModel: trainingModel,
                            exercisesSession: exercisesSession,
                            //sessionNumber: sessionNumber,
                          ));
                    },
                  ),
                ),

                //Session Card title
                Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      'Session # ${sessionNumber.toString()}',
                      style: tStyleBigTitle,
                      textAlign: TextAlign.center,
                    )),

                //Session Card subtitle
                Positioned(
                    top: 55,
                    left: 20,
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.calendar_today,
                          color: tColorWhite,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          fullDate,
                          style: tStyleBigSubTitle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),

                //Session Card times
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    //height: 100,
                    //color: tColorGreen,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CardTileSession(
                          title: "Start",
                          titleData: time,
                        ),
                        CardTileSession(
                          title: "End",
                          titleData: endTime,
                        ),
                        CardTileSession(
                            title: "Total Timer", titleData: totalTimer),
                      ],
                    ),
                  ),
                ),

                //Session card exercises icons
                Positioned(
                  top: 85,
                  right: 40,
                  left: 40,
                  child: Container(
                    //width: 200,
                    //color: tColorGreen,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: tSizesMargin,
                            ),
                            const Icon(
                              timerIcon,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              sessionsController.totalTimerExercisesInSession(
                                  exerciseSession: exercisesSession),
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
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              sessionsController.totalRepExercisesInSession(
                                  exerciseSession: exercisesSession),
                              style: tStyleCardIcons,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
