import 'package:gorilla_grab/Screens/models/exercise_model.dart';

class SessionFinished {
  final String sessionId;
  final DateTime createdAt;
  final String startTime;
  final String endTime;
  final String sessionDuration;
  final String trainingId;
  final String trainingName;
  final List<ExerciseModel> exercisesListFinished;
  final String sessionComment;

  SessionFinished(
      {required this.createdAt,
      required this.sessionId,
      required this.startTime,
      required this.endTime,
      required this.sessionDuration,
      required this.exercisesListFinished,
      required this.trainingId,
      required this.trainingName,
      required this.sessionComment});
}
