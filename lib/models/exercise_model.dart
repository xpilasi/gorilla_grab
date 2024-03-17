class ExerciseModel {
  final String user;
  final String trainingId;
  final String exerciseId;
  String sessionId = '-';
  final String name;
  final bool timer;
  final int color;
  final bool closed;
  final DateTime creationDate;

  ExerciseModel({
    required this.user,
    required this.trainingId,
    required this.exerciseId,
    required this.name,
    required this.timer,
    required this.closed,
    required this.creationDate,
    required this.color,
  });
}
