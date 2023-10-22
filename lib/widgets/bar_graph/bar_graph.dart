import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';
import 'package:gorilla_grab/controllers/stats_controller.dart';
import 'package:gorilla_grab/widgets/bar_graph/individual_bar.dart';

class PerformancesBarGraph extends StatelessWidget {
  const PerformancesBarGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Initialize BarData
    final StatsController statsController = Get.find<StatsController>();
    final PerformanceController performanceController =
        Get.find<PerformanceController>();
    Map<String, int> myBarData2 = statsController.performanceRecordsToMap();
    var performancesList = performanceController.getPerformancesForChart();
    List<IndividualBar> bardata2 = [];

    void initializerBarData2({required Map barMap}) {
      int xAxis = 0;

      barMap.forEach((x, y) {
        bardata2.add(IndividualBar(
          x: xAxis,
          y: y,
        ));
        xAxis += 1;
      });
      for (var el in bardata2) {
        print('${el.x} - ${el.y}');
      }
    }

    initializerBarData2(barMap: myBarData2);

    bool negativePerformanceFound =
        performancesList.any((model) => model.gapPercentagePerformance < 0);

    return BarChart(BarChartData(
      // maxY: 100,
      minY: negativePerformanceFound ? -100 : 0,

      gridData: const FlGridData(
          //show: false,
          drawHorizontalLine: true,
          drawVerticalLine: false),
      borderData: FlBorderData(show: false),
      titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles))),
      barGroups: bardata2
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                    color: data.y < 0 ? tColorPrimary_8 : tColorPrimary_4,
                    toY: data.y.toDouble(),
                    width: 10,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData())
              ]))
          .toList(),
    ));
  }
}

Widget getBottomTitlesList(
    {required List indexValueList, required int valueKey}) {
  final StatsController statsController = Get.find<StatsController>();
  String textForText = 'M1';
  Widget text = Text(textForText, style: tStyleStatsBarChart);

  Map indexValueMap = {};

  for (var el in indexValueList) {
    for (var x in el) {
      indexValueMap[el[0]] = el[1];
    }
  }

  textForText = indexValueMap[valueKey];
  int texForTextLength = textForText.length;
  text =
      Text('      ${textForText.substring(9, 14)}', style: tStyleStatsBarChart);

  return text;
}

Widget getBottomTitles(
  double value,
  TitleMeta meta,
) {
  final StatsController statsController = Get.find<StatsController>();
  final PerformanceController performanceController =
      Get.find<PerformanceController>();

  var performancesList = performanceController.getPerformancesForChart();
  bool negativePerformanceFound =
      performancesList.any((model) => model.gapPercentagePerformance < 0);
  List indexValueList = [];
  int index = 0;
  statsController.performanceRecordsToMap().forEach((key, value) {
    indexValueList.add([index, key]);

    index += 1;
  });

  int valueInt = value.toInt();
  //print(indexValueList);
  return SideTitleWidget(
      space: negativePerformanceFound ? 0 : 10,
      angle: 0,
      axisSide: meta.axisSide,
      child: getBottomTitlesList(
          indexValueList: indexValueList, valueKey: valueInt));
}
