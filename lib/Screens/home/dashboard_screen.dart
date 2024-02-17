import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/my_trainings/session/training_session_independent.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';
import 'package:gorilla_grab/controllers/profile_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';
import 'package:line_icons/line_icons.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  final SessionsController sessionsController = Get.put(SessionsController());
  final TrainingController trainingController = Get.put(TrainingController());
  final ProfileController profileController = Get.put(ProfileController());
  final PerformanceController performanceController =
      Get.put(PerformanceController());

  @override
  Widget build(BuildContext context) {
    final user = profileController.profile['name'].toString();
    //Size screenSize = MediaQuery.of(context).size;

    double heighLastTrainingContainer = 80;

    return Scaffold(
      backgroundColor: allAppBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(tSizesHeighBigTitle),
        child: CustomAppBarBigTitleDash(
          appBarTitle: "Hi $user,",
          avatar: Padding(
            padding: const EdgeInsets.only(right: 26),
            child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 15.50,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(tImgAvatar),
                      fit: BoxFit.contain, // Ajuste de la imagen
                    ),
                  ),
                )),
          ),
        ),
      ),
      body: sessionsController.allSessions.isEmpty
          ? const Stack(
              children: [WelcomeToGorillaPanel()],
            )
          : Stack(
              children: [
                //Days filter
                const DaysFilter(),

                //Dashboard stats Panel
                Positioned(
                  left: 0,
                  right: 0,
                  top: 50,
                  bottom: 0,
                  child: GetBuilder<SessionsController>(
                    builder: (dashBoardController) {
                      //days filter
                      int filter = 7;
                      return Stack(
                        children: [
                          //Title trainings hours
                          const TitleTrainingHours(),

                          //Training hours
                          DbTrainingHoursPanel(
                              sessionsController: sessionsController,
                              filter: filter),

                          //Title last trainings
                          const TitleLastTrainings(),

                          //Last trainings
                          DbLastTrainingsPanel(
                              sessionsController: sessionsController,
                              heighLastTrainingContainer:
                                  heighLastTrainingContainer,
                              filter: filter,
                              performanceController: performanceController,
                              trainingController: trainingController),

                          //Title 3rd container
                          const TitleExercisePerformances(),

                          //Top exercise performances
                          DbTopExercisePerformancesPanel(
                              performanceController: performanceController,
                              filter: filter)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class WelcomeToGorillaPanel extends StatelessWidget {
  const WelcomeToGorillaPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 50,
        left: 50,
        top: 0,
        bottom: 200,
        // ignore: avoid_unnecessary_containers
        child: Container(
          //color: tColorGreeny,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  tImgIsoGorilla,
                ),
                width: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Welcome to Gorilla Grab', style: tStyleBottomSheet),
            ],
          ),
        ));
  }
}

class DbTopExercisePerformancesPanel extends StatelessWidget {
  const DbTopExercisePerformancesPanel({
    super.key,
    required this.performanceController,
    required this.filter,
  });

  final PerformanceController performanceController;
  final int filter;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 395,
      left: 10,
      right: 10,
      height: 140,
      child: Container(
          //height: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(allBoxRadius),
              color: performanceController.gapPerformanceList.isEmpty
                  ? Colors.transparent
                  : Colors.transparent),
          child: performanceController.gapPerformanceList.isEmpty
              ? const Text(
                  'N/R',
                  textAlign: TextAlign.center,
                  style: tStyleDashBoardBigRecord,
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: performanceController
                        .getTopGapPerformanceModel(lastDaysFilter: filter)
                        .length,
                    itemBuilder: (context, index) {
                      var top3 = performanceController
                          .getTopGapPerformanceModel(lastDaysFilter: filter);

                      int performance = top3[index].gapPercentagePerformance;

                      String record = top3[index].gapPerformance;

                      // String date = '$day/$month/$year';
                      return Column(
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                //color: tColorBottomSheetG1,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        LineIcons.medal,
                                        size: 30.0,
                                        color: tColorPinky,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      //Exercise name
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        //color: tColorBlue,
                                        width: 90,
                                        height: 50,
                                        child: Text(
                                          top3[index].gapExerciseName,
                                          overflow: TextOverflow.ellipsis,
                                          //softWrap: true,
                                          style: tStyleDashBoardSmallRecordText,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),

                                      //Record
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        //color: tColorBlue,
                                        width: 80,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            record.length > 2
                                                ? const Icon(
                                                    timerIcon,
                                                    color: tColorWhite,
                                                  )
                                                : const Icon(
                                                    repIcon,
                                                    color: tColorWhite,
                                                  ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              record.length > 2
                                                  ? record
                                                  : '$record rp',
                                              softWrap: true,
                                              style:
                                                  tStyleDashBoardSmallRecordTextM,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),

                                  //%Performance
                                  Container(
                                    alignment: Alignment.centerRight,
                                    //color: tColorBlue,
                                    width: 80,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        performance >= 0
                                            ? const Icon(
                                                Icons.arrow_drop_up_rounded,
                                                color: tColorGreeny,
                                              )
                                            : const Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: tColorPrimary_8,
                                              ),
                                        Text('$performance%',
                                            style:
                                                tStyleDashBoardSmallRecordTextM),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      );
                    },
                  ),
                )),
    );
  }
}

class TitleExercisePerformances extends StatelessWidget {
  const TitleExercisePerformances({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 360,
      left: 20,
      child: Text(
        'Top exercise performances',
        style: tStyleDashBoardTitles,
      ),
    );
  }
}

class DbLastTrainingsPanel extends StatelessWidget {
  DbLastTrainingsPanel({
    super.key,
    required this.sessionsController,
    required this.heighLastTrainingContainer,
    required this.filter,
    required this.performanceController,
    required this.trainingController,
  });

  final SessionsController sessionsController;
  final double heighLastTrainingContainer;
  final int filter;
  final PerformanceController performanceController;
  final TrainingController trainingController;
  final String userApp = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: sessionsController.allSessions.isEmpty ? 20 : 0,
      left: 20,
      child: Container(
          decoration: BoxDecoration(
              color: sessionsController.allSessions.isEmpty
                  ? tColorBottomSheetG
                  : Colors.transparent,
              borderRadius:
                  const BorderRadius.all(Radius.circular(allBoxRadius))),
          height: heighLastTrainingContainer,
          child: sessionsController.allSessions.isEmpty
              // ignore: avoid_unnecessary_containers
              ? Container(
                  child: Center(
                    child: Text(
                      'EMPTY',
                      style: tStyleBigTitleTraining,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 0, right: 0, bottom: 0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sessionsController
                          .getLastDaysTraining(lastDaysFilter: filter)
                          .length,
                      itemBuilder: (context, index) {
                        var sessionsList = sessionsController
                            .getLastDaysTraining(lastDaysFilter: filter)
                            .reversed
                            .toList();
                        String sessionId = sessionsList[index].sessionId;
                        String averagePerformance = performanceController
                            .getPerformanceAveragePerSession(
                                sessionId: sessionId);
                        String trainingName = sessionsList[index].trainingName;
                        String trainingId = sessionsList[index].trainingId;

                        String trainingMonth = sessionsList[index]
                            .createdAt
                            .toString()
                            .substring(5, 7);
                        String trainingDay = sessionsList[index]
                            .createdAt
                            .toString()
                            .substring(8, 10);
                        String trainingFullDate = '$trainingDay/$trainingMonth';
                        String sessionDuration =
                            sessionsList[index].sessionDuration;
                        String sessionHours = sessionDuration[0] == '0'
                            ? sessionDuration[1]
                            : sessionDuration.substring(0, 1);
                        String sessionMinutes = sessionDuration[3] == '0'
                            ? sessionDuration[4]
                            : sessionDuration.substring(3, 5);
                        String sessionDurationFinal =
                            '${sessionHours}h ${sessionMinutes}m';
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child:

                              //Container clickeable que lleva a la sesión correspondiente
                              InkWell(
                            onTap: () =>
                                (Get.to(() => TrainingSessionIndependentScreen(
                                      exercisesSession: sessionsList[index],
                                      trainingModel:
                                          trainingController.getTrainingModel(
                                              user: userApp,
                                              trainingId: trainingId),
                                    ))),
                            child: Container(
                              height: 70,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: tColorBottomSheetG1,
                                  borderRadius:
                                      BorderRadius.circular(allBoxRadius)),
                              child: Stack(
                                children: [
                                  //Date
                                  Positioned(
                                    bottom: 15,
                                    right: 15,
                                    child: Text(
                                      trainingFullDate,
                                      style: tStyleDashBoardDate,
                                    ),
                                  ),

                                  //Training name
                                  Positioned(
                                    top: 15,
                                    left: 15,
                                    // ignore: sized_box_for_whitespace
                                    child: Container(
                                      width: 85,
                                      //color: tColorBlue,
                                      child: Text(
                                        trainingName,
                                        overflow: TextOverflow.ellipsis,
                                        style: tStyleDashBoardTraining,
                                      ),
                                    ),
                                  ),

                                  //Performance
                                  Positioned(
                                      top: 15,
                                      right: 15,
                                      child: averagePerformance[0] != '-'
                                          ? Row(
                                              children: [
                                                const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: tColorGreeny,
                                                ),
                                                Text(
                                                  '$averagePerformance%',
                                                  style:
                                                      tStyleDashBoardSmallRecordTextM,
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: tColorPrimary_8,
                                                ),
                                                Text(
                                                  '${averagePerformance.substring(1)}%',
                                                  style:
                                                      tStyleDashBoardSmallRecordTextM,
                                                )
                                              ],
                                            )),

                                  //Duration
                                  Positioned(
                                    bottom: 15,
                                    left: 15,
                                    child: Text(
                                      sessionDurationFinal[0] != '0'
                                          ? sessionDurationFinal
                                          : sessionDurationFinal.substring(3),
                                      style: tStyleDashBoardDuration,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )),
    );
  }
}

class TitleLastTrainings extends StatelessWidget {
  const TitleLastTrainings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 210,
      left: 20,
      child: Text(
        'Last trainings',
        style: tStyleDashBoardTitles,
      ),
    );
  }
}

class DbTrainingHoursPanel extends StatelessWidget {
  const DbTrainingHoursPanel({
    super.key,
    required this.sessionsController,
    required this.filter,
  });

  final SessionsController sessionsController;
  final int filter;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 20,
      left: 20,
      child: Container(
        decoration: const BoxDecoration(
            gradient: gradient1,
            borderRadius: BorderRadius.all(Radius.circular(allBoxRadius))),
        height: 140,
        child: Stack(children: [
          //hours training
          Positioned(
            top: 0,
            left: 20,
            child: TotalTrainingHours(
                sessionsController: sessionsController, filter: filter),
          ),

          //Avg number
          Positioned(
            bottom: 35,
            right: 20,
            // ignore: avoid_unnecessary_containers
            child: Container(
              //color: tColorGreeny,
              child: Text(
                sessionsController.allSessions.isNotEmpty
                    ? sessionsController.getAverageTrainingHours(
                        lastDaysFilter: filter)
                    : 'N/S',
                style: tStyleDashBoardSmallRecord,
              ),
            ),
          ),

          //Avg
          const Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              'AVG',
              style: tStyleDashBoardSmallRecordText,
            ),
          ),

          //total training hours
          Positioned(
            bottom: 10,
            left: 20,
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 80,
              child: const Text(
                'TOTAL',
                softWrap: true,
                style: tStyleDashBoardExercise,
              ),
            ),
          ),

          //% gap
          Positioned(
            right: 20,
            top: 10,
            child: GapLastDays(
                sessionsController: sessionsController, filter: filter),
          ),
        ]),
      ),
    );
  }
}

class TitleTrainingHours extends StatelessWidget {
  const TitleTrainingHours({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 0,
      left: 20,
      child: Text(
        'Training hours',
        style: tStyleDashBoardTitles,
      ),
    );
  }
}

class DaysFilter extends StatelessWidget {
  const DaysFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 20,
      left: 20,
      // ignore: sized_box_for_whitespace
      child: Container(
        height: 40,
        //color: tColorGreeny,
        child: Stack(
          children: [
            //days filter
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: tColorBottomSheetG1,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "14 days",
                        style: tStyleSubTitles,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: tColorWhite,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalTrainingHours extends StatelessWidget {
  const TotalTrainingHours({
    super.key,
    required this.sessionsController,
    required this.filter,
  });

  final SessionsController sessionsController;
  final int filter;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Text(
        sessionsController.allSessions.isNotEmpty
            ? sessionsController.getTotalTrainingHours(lastDaysFilter: filter)
            : 'N/S',
        style: tStyleDashBoardBigRecord,
      ),
    );
  }
}

class GapLastDays extends StatelessWidget {
  const GapLastDays({
    super.key,
    required this.sessionsController,
    required this.filter,
  });

  final SessionsController sessionsController;
  final int filter;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
        width: 140,
        child: sessionsController.allSessions.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  sessionsController.getGapLastDays(
                              lastDaysFilter: filter)[0] ==
                          '-'
                      ? const Icon(Icons.arrow_drop_down_rounded,
                          color: tColorPrimary_8)
                      : const Icon(Icons.arrow_drop_up_rounded,
                          color: tColorGreeny),
                  Text(
                      sessionsController.getGapLastDays(
                                  lastDaysFilter: filter)[0] ==
                              '-'
                          ? sessionsController
                              .getGapLastDays(lastDaysFilter: filter)
                              .substring(1, 4)
                          : sessionsController.getGapLastDays(
                              lastDaysFilter: filter),
                      softWrap: true,
                      style: sessionsController.getGapLastDays(
                                  lastDaysFilter: filter)[0] ==
                              '-'
                          ? tStyleDashBoardNegative
                          : tStyleDashBoardPositive),
                ],
              )
            : const Text(
                '',
                style: tStyleDashBoardSmallRecord,
              ));
  }
}
