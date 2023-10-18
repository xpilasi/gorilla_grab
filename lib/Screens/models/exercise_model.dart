class ExerciseModel {
  final String trainingId;
  final String exerciseId;
  String sessionId = ' - ';
  final String name;
  final bool timer;
  final int color;
  final bool closed = false;
  final DateTime creationDate;

  ExerciseModel({
    required this.trainingId,
    required this.exerciseId,
    required this.name,
    required this.timer,
    required this.creationDate,
    required this.color,
  });
}
