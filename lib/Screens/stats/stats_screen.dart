import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/sizes.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/constants/variables.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';
import 'package:gorilla_grab/controllers/records_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';
import 'package:gorilla_grab/controllers/stats_controller.dart';
import 'package:gorilla_grab/controllers/trainings_controller.dart';
import 'package:gorilla_grab/widgets/bar_graph/bar_graph.dart';
import 'package:gorilla_grab/widgets/headers.dart';
import 'package:gorilla_grab/widgets/titles.dart';

class StatsScreen extends StatelessWidget {
  final StatsController statsController = Get.put(StatsController());
  StatsScreen({Key? key}) : super(key: key);
  final SessionsController sessionsController = Get.put(SessionsController());
  final RecordsController recordsController = Get.put(RecordsController());
  final PerformanceController performanceController =
      Get.put(PerformanceController());
  final TrainingController trainingController = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: allAppBackground,
        body: GetBuilder<StatsController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: tSizesMargin, top: tSizesMargin, bottom: tSizesMargin),
              child: Stack(
                children: [
                  //Header
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                        //color: tColorGreen,
                        height: 100,
                        child: HeaderForMenu(title: 'Stats')),
                  ),

                  Positioned(
                      top: 100,
                      left: tSizesMargin,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            color: tColorBottomSheetG2,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          //color: tColorBottomSheetG),
                          height: 290,
                          child: const Padding(
                            padding: EdgeInsets.only(
                                bottom: 40.0, top: 90, left: 20, right: 20),
                            child: PerformancesBarGraph(),
                          ))),
                  //Chart title
                  // Positioned(
                  //   top: 80,
                  //   //right: 20,
                  //   left: 20,
                  //   child: Container(
                  //       //color: tColorGreen,
                  //       height: 100,
                  //       child: TitleLeft(
                  //         title: 'Last Performances',
                  //       )),
                  // ),
                  // Positioned(
                  //   top: 110,
                  //   right: 20,
                  //   //left: 20,
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //           color: tColorBottomSheet,
                  //           borderRadius: BorderRadius.circular(30)),
                  //       height: 40,
                  //       width: 40,
                  //       child: const Center(
                  //         child: Row(
                  //           children: [
                  //             TitleLeft(
                  //               title: 'Sharma',
                  //             ),
                  //             Icon(
                  //               Icons.arrow_drop_down_rounded,
                  //               color: tColorWhite,
                  //             ),
                  //             SizedBox(
                  //               width: 10,
                  //             )
                  //           ],
                  //         ),
                  //       )),
                  // ),

                  //All sessions list
                  Positioned(
                      top: 410,
                      left: tSizesMargin,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            color: tColorBottomSheetG2,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          //color: tColorBottomSheetG),
                          height: 290,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, top: 10, left: 20, right: 20),
                              child: ListView.builder(
                                itemCount:
                                    sessionsController.allSessions.length,
                                itemBuilder: (context, index) {
                                  var sessionsList =
                                      sessionsController.allSessions;

                                  var session = sessionsList[index];
                                  String sessionDurationFull = recordsController
                                      .getTimerRecordFormatHours(
                                          timerRecord: session.sessionDuration);
                                  String dateEu =
                                      recordsController.getEuFormatDate(
                                          dateTime: session.createdAt);
                                  String averagePerformance =
                                      performanceController
                                          .getPerformanceAveragePerSession(
                                              sessionId: session.sessionId);

                                  String trainingName =
                                      trainingController.getTrainingName(
                                          trainingId: session.trainingId);
                                  Color trainingColor = Color(trainingController
                                      .getTrainingModel(
                                          trainingId: session.trainingId)
                                      .color);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: Container(
                                      height: 70,
                                      width: 150,
                                      margin: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                          //color: tColorBottomSheetG1,
                                          borderRadius: BorderRadius.circular(
                                              allBoxRadius - 10)),
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: 0),
                                        contentPadding: EdgeInsets.zero,
                                        leading: Container(
                                          padding: EdgeInsets.zero,
                                          width: 50,
                                          height: 56,
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        allBoxRadius - 10),
                                                    bottomLeft: Radius.circular(
                                                        allBoxRadius - 10)),
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: trainingColor,
                                            child: Center(
                                              child: Text(
                                                trainingName.isNotEmpty
                                                    ? trainingName[0]
                                                    : trainingName,
                                                textAlign: TextAlign.center,
                                                style: tStyleBigTitle,
                                                //
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Container(
                                          width: 80,
                                          child: Text(
                                            '$trainingName | $dateEu',
                                            style: tStyleCardExercises,
                                          ),
                                        ),
                                        subtitle: Text(
                                          sessionDurationFull,
                                          style: tStyleListTileExerciseName,
                                        ),
                                        trailing: Container(
                                          width: 70,
                                          child: recordsController
                                              .getFullPerformance(
                                                  performance:
                                                      averagePerformance),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )))),

                  //All sessions title
                  // Positioned(
                  //   top: 390,
                  //   //right: 20,
                  //   left: 20,
                  //   child: Container(
                  //       //color: tColorGreen,
                  //       //height: 100,
                  //       child: TitleLeft(
                  //     title: 'All sessions',
                  //   )),
                  // ),
                ],
              ),
            );
          },
        ));
  }
}
