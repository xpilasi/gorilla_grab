import 'package:gorilla_grab/widgets/bar_graph/individual_bar.dart';

class BarData {
  final int day1;
  final int day2;
  final int day3;
  final int day4;
  final int day5;

  BarData(
      {required this.day1,
      required this.day2,
      required this.day3,
      required this.day4,
      required this.day5});

  List<IndividualBar> barData = [];

  //Initializaer bar data

  void initializerBarData() {
    barData = [
      IndividualBar(x: 0, y: day1),
      IndividualBar(x: 1, y: day2),
      IndividualBar(x: 2, y: day3),
      IndividualBar(x: 3, y: day4),
      IndividualBar(x: 4, y: day5),
    ];
  }
}
