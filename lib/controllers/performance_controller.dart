import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/gap_performance_model.dart';

class PerformanceController extends GetxController {
//General performance list
  List<GapPerformanceModel> gapPerformanceList = [];

//To get average session performance

  String getPerformanceAveragePerSession({
    required String sessionId,
  }) {
    String performanceAverageSession = '';
    List<int> gapList = [];
    double average = 0;

    for (var el in gapPerformanceList) {
      if (el.gapSessionId == sessionId) {
        gapList.add(el.gapPercentagePerformance);
        average += el.gapPercentagePerformance;
      }
    }

    gapList.isNotEmpty ? average = average / gapList.length : average = 0;

    int averageInt = average.toInt();
    performanceAverageSession = averageInt.toString();

    return performanceAverageSession;
  }

  DateTime getSessionCreationDate({required gapSessionId}) {
    var sessionDate;
    for (var el in gapPerformanceList) {
      if (gapSessionId == el.gapSessionId) {
        sessionDate = el.gapCreationDate;
      }
    }
    return sessionDate;
  }

  String getSessionTrainingId({required gapSessionId}) {
    var trainingId;
    for (var el in gapPerformanceList) {
      if (gapSessionId == el.gapSessionId) {
        trainingId = el.gapTrainingId;
      }
    }
    return trainingId;
  }

  //To get average performances grouped by sessions - UNDER CONSTRUCTION
  List<GapPerformanceModel> getPerformancesForChart() {
    List<GapPerformanceModel> performancesForChart = [];
    List<String> keysList = [];

    for (var el in gapPerformanceList) {
      keysList.add(el.gapSessionId);
    }
    Set<String> setKeysList = Set<String>.from(keysList);
    List<String> keysListClean = setKeysList.toList();
    print('keysList-> $keysListClean');

    for (var el in keysListClean) {
      int keyAverage =
          int.parse(getPerformanceAveragePerSession(sessionId: el));
      GapPerformanceModel newGapPerformanceModel = GapPerformanceModel(
          gapCreationDate: getSessionCreationDate(gapSessionId: el),
          gapExerciseId: 'No need',
          gapExerciseName: 'No need',
          gapId: UniqueKey().toString(),
          gapPercentagePerformance: keyAverage,
          gapPerformance: keyAverage.toString(),
          gapSessionId: el,
          gapTrainingId: getSessionTrainingId(gapSessionId: el));

      performancesForChart.add(newGapPerformanceModel);
    }

    return performancesForChart;
  }
  // -- under construction

//ToGet a list with the previous Sessions according to the filter in order
//to equaly compare the gap
  List<GapPerformanceModel> getLastDaysGapPerformance(
      {required int lastDaysFilter}) {
    final now = DateTime.now();
    final limitDays = now.subtract(Duration(days: lastDaysFilter));

    return gapPerformanceList.where((element) {
      return element.gapCreationDate.isAfter(limitDays);
    }).toList();
  }

  //To show the Top 3 Gaps from x days
  List<GapPerformanceModel> getTopGapPerformanceModel(
      {required int lastDaysFilter}) {
    List<GapPerformanceModel> lastDaysGapPerformance =
        getLastDaysGapPerformance(lastDaysFilter: lastDaysFilter);

    lastDaysGapPerformance.sort((a, b) =>
        b.gapPercentagePerformance.compareTo(a.gapPercentagePerformance));

    List<GapPerformanceModel> top3 = [];
    int index = 1;
    for (var el in lastDaysGapPerformance) {
      top3.add(el);
      index += 1;
      if (index == 4) {
        break;
      }
    }
    return top3;
  }
}
