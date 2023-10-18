class GapAverageModel {
  final String gapId;
  final DateTime gapCreationDate;
  final String gapSessionId;
  final String gapTrainingId;
  //final String gapPerformance;
  //final String gapExerciseId;
  //final String gapExerciseName;
  final int gapPercentageAverage;

  GapAverageModel(
      {required this.gapId,
      required this.gapSessionId,
      required this.gapTrainingId,
      //required this.gapPerformance,
      //required this.gapExerciseId,
      //required this.gapExerciseName,
      required this.gapPercentageAverage,
      required this.gapCreationDate});
}
