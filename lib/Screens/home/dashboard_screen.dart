import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/Screens/my_trainings/session/training_session_independent.dart';
import 'package:gorilla_grab/constants/images.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/texts.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bars.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/variables.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  final SessionsController sessionsController = Get.put(SessionsController());
  final TrainingController trainingController = Get.put(TrainingController());
  final PerformanceController performanceController =
      Get.put(PerformanceController());
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;

    double heighLastTrainingContainer = 80;

    return Scaffold(
      backgroundColor: allAppBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(tSizesHeighBigTitle),
        child: CustomAppBarBigTitleDash(
          appBarTitle: "Hi $tProfileName,",
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
      body: Stack(
        children: [
          //Days filter
          Positioned(
            top: 0,
            right: 20,
            left: 20,
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
          ),

          //Dashboard stats
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
                    const Positioned(
                      top: 0,
                      left: 20,
                      child: Text(
                        'Training hours',
                        style: tStyleDashBoardTitles,
                      ),
                    ),

                    //Training hours
                    Positioned(
                      top: 40,
                      right: 20,
                      left: 20,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: tColorBottomSheetG1,
                            borderRadius: BorderRadius.all(
                                Radius.circular(allBoxRadius))),
                        height: 140,
                        child: Stack(children: [
                          //hours training
                          Positioned(
                            top: 0,
                            left: 20,
                            child: TotalTrainingHours(
                                sessionsController: sessionsController,
                                filter: filter),
                          ),

                          //Avg number
                          Positioned(
                            bottom: 35,
                            right: 20,
                            child: Container(
                              //color: tColorGreen,
                              child: Text(
                                sessionsController.allSessions.isNotEmpty
                                    ? sessionsController
                                        .getAverageTrainingHours(
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
                            bottom: 20,
                            left: 20,
                            child: Container(
                              //color: tColorBottomSheet,
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
                                sessionsController: sessionsController,
                                filter: filter),
                          ),
                        ]),
                      ),
                    ),

                    //Title last trainings
                    const Positioned(
                      top: 210,
                      left: 20,
                      child: Text(
                        'Last trainings',
                        style: tStyleDashBoardTitles,
                      ),
                    ),

                    //Last trainings
                    Positioned(
                      top: 250,
                      right: sessionsController.allSessions.isEmpty ? 20 : 0,
                      left: 20,
                      child: Container(
                          decoration: BoxDecoration(
                              color: sessionsController.allSessions.isEmpty
                                  ? tColorBottomSheetG
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(allBoxRadius))),
                          height: heighLastTrainingContainer,
                          child: sessionsController.allSessions.isEmpty
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      'EMPTY',
                                      style: tStyleBigTitleTraining,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, right: 0, bottom: 0),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: sessionsController
                                          .getLastDaysTraining(
                                              lastDaysFilter: filter)
                                          .length,
                                      itemBuilder: (context, index) {
                                        var sessionsList = sessionsController
                                            .getLastDaysTraining(
                                                lastDaysFilter: filter)
                                            .reversed
                                            .toList();
                                        String sessionId =
                                            sessionsList[index].sessionId;
                                        String averagePerformance =
                                            performanceController
                                                .getPerformanceAveragePerSession(
                                                    sessionId: sessionId);
                                        String trainingName =
                                            sessionsList[index].trainingName;
                                        String trainingId =
                                            sessionsList[index].trainingId;
                                        Color trainingColor = trainingController
                                            .getColor(trainingId: trainingId);
                                        String trainingYear =
                                            sessionsList[index]
                                                .createdAt
                                                .toString()
                                                .substring(0, 4);
                                        String trainingMonth =
                                            sessionsList[index]
                                                .createdAt
                                                .toString()
                                                .substring(5, 7);
                                        String trainingDay = sessionsList[index]
                                            .createdAt
                                            .toString()
                                            .substring(8, 10);
                                        String trainingFullDate =
                                            '$trainingDay/$trainingMonth';
                                        String sessionDuration =
                                            sessionsList[index].sessionDuration;
                                        String sessionHours =
                                            sessionDuration[0] == '0'
                                                ? sessionDuration[1]
                                                : sessionDuration.substring(
                                                    0, 1);
                                        String sessionMinutes =
                                            sessionDuration[3] == '0'
                                                ? sessionDuration[4]
                                                : sessionDuration.substring(
                                                    3, 5);
                                        String sessionDurationFinal =
                                            '${sessionHours}h ${sessionMinutes}m';
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child:

                                              //Container clickeable que lleva a la sesión correspondiente
                                              InkWell(
                                            onTap: () => (Get.to(() =>
                                                TrainingSessionIndependentScreen(
                                                  exercisesSession:
                                                      sessionsList[index],
                                                  trainingModel:
                                                      trainingController
                                                          .getTrainingModel(
                                                              trainingId:
                                                                  trainingId),
                                                ))),
                                            child: Container(
                                              height: 70,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                  color: tColorBottomSheetG1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          allBoxRadius)),
                                              child: Stack(
                                                children: [
                                                  //Date
                                                  Positioned(
                                                    bottom: 15,
                                                    right: 15,
                                                    child: Text(
                                                      trainingFullDate,
                                                      style:
                                                          tStyleDashBoardDate,
                                                    ),
                                                  ),

                                                  //Training name
                                                  Positioned(
                                                    top: 15,
                                                    left: 15,
                                                    child: Container(
                                                      width: 85,
                                                      //color: tColorBlue,
                                                      child: Text(
                                                        trainingName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            tStyleDashBoardTraining,
                                                      ),
                                                    ),
                                                  ),

                                                  //Performance
                                                  Positioned(
                                                      top: 15,
                                                      right: 15,
                                                      child: averagePerformance[
                                                                  0] !=
                                                              '-'
                                                          ? Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .arrow_drop_up_rounded,
                                                                  color:
                                                                      tColorGreeny,
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
                                                                  Icons
                                                                      .arrow_drop_down_rounded,
                                                                  color:
                                                                      tColorPrimary_8,
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
                                                      sessionDurationFinal[0] !=
                                                              '0'
                                                          ? sessionDurationFinal
                                                          : sessionDurationFinal
                                                              .substring(3),
                                                      style:
                                                          tStyleDashBoardDuration,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )),
                    ),

                    //Title 3rd container
                    const Positioned(
                      top: 360,
                      left: 20,
                      child: Text(
                        'Top exercise performances',
                        style: tStyleDashBoardTitles,
                      ),
                    ),

                    //3rd container
                    Positioned(
                      top: 395,
                      left: 10,
                      right: 10,
                      height: 140,
                      child: Container(
                          //height: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(allBoxRadius),
                              color: performanceController
                                      .gapPerformanceList.isEmpty
                                  ? Colors.transparent
                                  : Colors.transparent),
                          child: performanceController
                                  .gapPerformanceList.isEmpty
                              ? const Text(
                                  'N/R',
                                  textAlign: TextAlign.center,
                                  style: tStyleDashBoardBigRecord,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListView.builder(
                                    itemCount: performanceController
                                        .getTopGapPerformanceModel(
                                            lastDaysFilter: filter)
                                        .length,
                                    itemBuilder: (context, index) {
                                      var top3 = performanceController
                                          .getTopGapPerformanceModel(
                                              lastDaysFilter: filter);
                                      String trainingName =
                                          trainingController.getTrainingName(
                                              trainingId:
                                                  top3[index].gapTrainingId);
                                      int performance =
                                          top3[index].gapPercentagePerformance;

                                      String year = top3[index]
                                          .gapCreationDate
                                          .toString()
                                          .substring(0, 4);
                                      String day = top3[index]
                                          .gapCreationDate
                                          .toString()
                                          .substring(8, 10);
                                      String month = top3[index]
                                          .gapCreationDate
                                          .toString()
                                          .substring(5, 7);

                                      String record =
                                          top3[index].gapPerformance;

                                      String date = '$day/$month/$year';
                                      return Column(
                                        children: [
                                          Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                                //color: tColorBottomSheetG1,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        //color: tColorBlue,
                                                        width: 90,
                                                        height: 50,
                                                        child: Text(
                                                          top3[index]
                                                              .gapExerciseName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          //softWrap: true,
                                                          style:
                                                              tStyleDashBoardSmallRecordText,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),

                                                      //Record
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        //color: tColorBlue,
                                                        width: 80,
                                                        height: 50,
                                                        child: Row(
                                                          children: [
                                                            record.length > 2
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
                                                    alignment:
                                                        Alignment.centerRight,
                                                    //color: tColorBlue,
                                                    width: 80,
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        performance >= 0
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_drop_up_rounded,
                                                                color:
                                                                    tColorGreeny,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_down_rounded,
                                                                color:
                                                                    tColorPrimary_8,
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
                    )
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
    return Container(
      //color: tColorGreen,
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
    return Container(
        //color: tColorBlue,
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
