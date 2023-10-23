import 'package:get/get.dart';
import 'package:gorilla_grab/models/session_provisional_model.dart';
import 'package:gorilla_grab/models/session_finished_model.dart';
import 'package:gorilla_grab/models/training_model.dart';

class SessionsController extends GetxController {
//Sessions Backlog:

  List<SessionFinished> allSessions = [];

  List<ProvisionalExercisesSession> provisionalSessions = [];

//Get the provisional session
  ProvisionalExercisesSession getProvisionalSession(
      {required String trainingId}) {
    int provSessionIndex = provisionalSessions.indexWhere(
        (id) => id.trainingId == trainingId && id.isClosed == false);

    ProvisionalExercisesSession provSession = ProvisionalExercisesSession(
        exercisesSessionDate: DateTime.now(),
        exercisesSessionExercises: [],
        exercisesSessionId: 'Dummy session Id',
        trainingId: 'Dummy training Id');

    provSessionIndex != -1
        ? provSession = provisionalSessions[provSessionIndex]
        : provSession = provSession;

    return provSession;
  }

// To check if the session is active
  bool trainingSessionActive({required String trainingId}) {
    bool isActive = false;
    int provSessionIndex = provisionalSessions.indexWhere(
        (id) => id.trainingId == trainingId && id.isClosed == false);

    provSessionIndex != -1 ? isActive = true : isActive = false;
    return isActive;
  }

//Calculate session time:
  String calculateSessionTime(
      {required String startTime, required String endTime}) {
    String sessionDuration = '';

    int minuteUnitStartTime = int.parse(startTime[4]);
    int minuteTenStartTime = int.parse(startTime[3]);
    int hourUnitStartTime = int.parse(startTime[1]);
    int hourTenStartTime = int.parse(startTime[0]);

    int minuteUnitEndTime = int.parse(endTime[4]);
    int minuteTenEndTime = int.parse(endTime[3]);
    int hourUnitEndTime = int.parse(endTime[1]);
    int hourTenEndTime = int.parse(endTime[0]);

    int totalMinutesStartTime = minuteUnitStartTime + (minuteTenStartTime * 10);
    int totalHoursStartTime = hourUnitStartTime + (hourTenStartTime * 10);
    int totalTimeStartTime = totalHoursStartTime * 60 + totalMinutesStartTime;

    int startTimeIntMinutes = totalTimeStartTime;

    int totalMinutesEndTime = minuteUnitEndTime + (minuteTenEndTime * 10);
    int totalHoursEndTime = hourUnitEndTime + (hourTenEndTime * 10);
    int totalTimeEndTime = totalHoursEndTime * 60 + totalMinutesEndTime;

    int endTimeIntMinutes = totalTimeEndTime;

    int duration = endTimeIntMinutes - startTimeIntMinutes;

    int minutes = duration % 60;
    int hours = (duration / 60).toInt();

    String hoursString = '';
    hours > 9 ? hoursString = '$hours' : hoursString = '0$hours';
    String minutesString = '';
    minutes > 9 ? minutesString = '$minutes' : minutesString = '0$minutes';

    sessionDuration = '$hoursString:$minutesString';

    return sessionDuration;
  }

//Get total Timer exercises in session:
  String totalTimerExercisesInSession(
      {required SessionFinished exerciseSession}) {
    int totalTimerExercises = 0;

    for (var el in exerciseSession.exercisesListFinished) {
      if (el.timer) {
        totalTimerExercises += 1;
      }
    }
    return totalTimerExercises.toString();
  }

//Get total Rep exercises in session:
  String totalRepExercisesInSession(
      {required SessionFinished exerciseSession}) {
    int totalRepExercises = 0;

    for (var el in exerciseSession.exercisesListFinished) {
      if (el.timer == false) {
        totalRepExercises += 1;
      }
    }
    return totalRepExercises.toString();
  }

//Get provisionalSessionList filtered by training:
  List<ProvisionalExercisesSession> getTrainingProvisionalSessionsList(
      {required String trainingId}) {
    List<ProvisionalExercisesSession> filteredSessionsByTrainingId = [];

    for (var el in provisionalSessions) {
      if (trainingId == el.trainingId) {
        filteredSessionsByTrainingId.add(el);
      }
    }

    return filteredSessionsByTrainingId;
  }

//pending provisional session?
  bool pendingSession({required TrainingModel trainingModel}) {
    bool pendingSession = false;

    getTrainingProvisionalSessionsList(trainingId: trainingModel.trainingId)
            .isEmpty
        ? pendingSession = false
        : pendingSession = true;

    return pendingSession;
  }

//Get all the complete training list
  List<SessionFinished> getTrainingSessionsList({required String trainingId}) {
    List<SessionFinished> filteredSessionsByTrainingId = [];

    for (var el in allSessions) {
      if (trainingId == el.trainingId) {
        filteredSessionsByTrainingId.add(el);
      }
    }

    return filteredSessionsByTrainingId;
  }

//Get total training hours
  String getTotalTrainingHours({required int lastDaysFilter}) {
    List<SessionFinished> filteredFinisedSessionsList =
        getLastDaysTraining(lastDaysFilter: lastDaysFilter);
    String trainingHoursString = '0';

    int durationTensHours = 0;
    int durationUnitHours = 0;
    int durationTensMinutes = 0;
    int durationUnitMinutes = 0;

    for (var el in filteredFinisedSessionsList) {
      durationTensHours += int.parse(el.sessionDuration[0]);
      durationUnitHours += int.parse(el.sessionDuration[1]);
      durationTensMinutes += int.parse(el.sessionDuration[3]);
      durationUnitMinutes += int.parse(el.sessionDuration[4]);
    }

    int totalMinutes = durationTensMinutes * 10 + durationUnitMinutes;
    int totalHoursInMinutes = (durationTensHours * 10 + durationUnitHours) * 60;

    int totalTrainingInMinutes = totalMinutes + totalHoursInMinutes;

    double totalHours = totalTrainingInMinutes /
        60.0; // Ahora esto debería funcionar correctamente

    trainingHoursString =
        totalHours.toStringAsFixed(1); // Para mostrar un decimal

    return trainingHoursString;
  }

//Get a list with the Sessions according to the filter
  List<SessionFinished> getLastDaysTraining({required int lastDaysFilter}) {
    final now = DateTime.now();
    final limitDays = now.subtract(Duration(days: lastDaysFilter));

    return allSessions.where((sessionFinished) {
      // Filtrar modelos que se crearon en los últimos 7 días
      return sessionFinished.createdAt.isAfter(limitDays);
    }).toList();
  }

//Get the average hours training per session according to the filter
  String getAverageTrainingHours({required int lastDaysFilter}) {
    double averageTrainingHours = 0.0;

    double filteredFinishedSessionsNumber =
        getLastDaysTraining(lastDaysFilter: lastDaysFilter).length.toDouble();

    double totalHoursFiltered =
        double.parse(getTotalTrainingHours(lastDaysFilter: lastDaysFilter));

    averageTrainingHours = totalHoursFiltered / filteredFinishedSessionsNumber;
    return averageTrainingHours.toString().substring(0, 3);
  }

//Get a list with the previous Sessions according to the filter in order
//to equaly compare the gap
  List<SessionFinished> getLastDaysTrainingBefore(
      {required int lastDaysFilter}) {
    final now = DateTime.now();
    final limitDays = now.subtract(Duration(days: lastDaysFilter));
    final beforeLimitDays = limitDays.subtract(Duration(days: lastDaysFilter));

    return allSessions.where((sessionFinished) {
      return sessionFinished.createdAt.isAfter(beforeLimitDays);
    }).toList();
  }

//Get total training hours from the previous period of time
  String getTotalTrainingHoursBefore({required int lastDaysFilter}) {
    List<SessionFinished> filteredFinisedSessionsList =
        getLastDaysTrainingBefore(lastDaysFilter: lastDaysFilter);
    String trainingHoursString = '0';

    int durationTensHours = 0;
    int durationUnitHours = 0;
    int durationTensMinutes = 0;
    int durationUnitMinutes = 0;

    for (var el in filteredFinisedSessionsList) {
      durationTensHours += int.parse(el.sessionDuration[0]);
      durationUnitHours += int.parse(el.sessionDuration[1]);
      durationTensMinutes += int.parse(el.sessionDuration[3]);
      durationUnitMinutes += int.parse(el.sessionDuration[4]);
    }

    int totalMinutes = durationTensMinutes * 10 + durationUnitMinutes;
    int totalHoursInMinutes = (durationTensHours * 10 + durationUnitHours) * 60;

    int totalTrainingInMinutes = totalMinutes + totalHoursInMinutes;

    double totalHours = totalTrainingInMinutes /
        60.0; // Ahora esto debería funcionar correctamente

    trainingHoursString =
        totalHours.toStringAsFixed(1); // Para mostrar un decimal

    return trainingHoursString;
  }

  String getGapLastDays({required int lastDaysFilter}) {
    String gapLastDays = '';
    double totalTrainingHoursBefore = 0.01;

    double totalTrainingHoursLast =
        double.parse(getTotalTrainingHours(lastDaysFilter: lastDaysFilter));

    getLastDaysTrainingBefore(lastDaysFilter: lastDaysFilter).isNotEmpty
        ? totalTrainingHoursBefore = double.parse(
                getTotalTrainingHoursBefore(lastDaysFilter: lastDaysFilter)) -
            totalTrainingHoursLast
        : totalTrainingHoursBefore = 0.01;

    double gap = 0;
    totalTrainingHoursBefore != 0
        ? gap = ((totalTrainingHoursLast / totalTrainingHoursBefore) - 1) * 100
        : gap = ((totalTrainingHoursLast / 0.1) - 1) * 100;
    int gapInt = gap.toInt();
    gapLastDays = gapInt.toString();

    totalTrainingHoursBefore == 0
        ? gapLastDays = '0'
        : gapLastDays = gapLastDays;
    return '$gapLastDays%';
  }

  int getSessionFinishedNumber({required SessionFinished sessionFinished}) {
    List<SessionFinished> sessionFinishedFiltered = [];

    //Create a list with all sessions from the same training
    for (var el in allSessions) {
      if (el.trainingId == sessionFinished.trainingId) {
        sessionFinishedFiltered.add(el);
      }
    }

    int sessionIndex = sessionFinishedFiltered.indexWhere(
      (element) => element.sessionId == sessionFinished.sessionId,
    );

    int sessionNumber = sessionIndex + 1;

    return sessionNumber;
  }
}
