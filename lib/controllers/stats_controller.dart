import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/models/gap_performance_model.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';

class StatsController extends GetxController {
  final PerformanceController performanceController =
      Get.put(PerformanceController());

  List<BarChartGroupData> barGroups = [];

  List<GapPerformanceModel> performancesForChart = [];

// Lista de modelos
  List<GapPerformanceModel> performancesForChart2 = [];

/*
  This is the second version of the chart
*/

  Map performancesMap = {};

  //Map: key--> Date - value-->Performance
  Map<String, int> performanceRecordsToMap() {
    performancesForChart2 = performanceController.getPerformancesForChart();

    Map<String, int> performancesMap = {};
    int index = 0;
    for (var el in performancesForChart2) {
      String keyDate =
          '${el.gapId}-${el.gapCreationDate.toString().substring(8, 10)}/${el.gapCreationDate.toString().substring(5, 7)}/${el.gapCreationDate.toString().substring(0, 4)}';
      int valuePerformance = el.gapPercentagePerformance;

      index += 1;
      performancesMap[keyDate] = valuePerformance;
    }

    return performancesMap;
  }

/*
  END: This is the second version of the chart
*/
} //Fin Controller
