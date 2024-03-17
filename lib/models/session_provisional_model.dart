import 'exercise_model.dart';

class ProvisionalExercisesSession {
  final String trainingId;
  final String exercisesSessionId;
  final DateTime exercisesSessionDate;
  bool isClosed = false;
  final List<ExerciseModel> exercisesSessionExercises;

  ProvisionalExercisesSession({
    required this.trainingId,
    required this.exercisesSessionId,
    required this.exercisesSessionDate,
    required this.exercisesSessionExercises,
  });
}
