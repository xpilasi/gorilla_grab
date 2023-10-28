import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorilla_grab/constants/colors.dart';
import 'package:gorilla_grab/constants/text_styles.dart';
import 'package:gorilla_grab/models/exercise_model.dart';
import 'package:gorilla_grab/models/rep_provisional_records_model.dart';
import 'package:gorilla_grab/models/rep_records_model.dart';
import 'package:gorilla_grab/models/timer_provisional_records_model.dart';
import 'package:gorilla_grab/models/timer_records_model.dart';
import 'package:gorilla_grab/controllers/performance_controller.dart';
import 'package:gorilla_grab/controllers/sessions_controller.dart';

class RecordsController extends GetxController {
  final SessionsController sessionsController = Get.put(SessionsController());
  final PerformanceController performanceController =
      Get.put(PerformanceController());

  //Here we add all the timerRecords:
  List<TimerRecordsModel> finalTimerRecordsList = [];
  List<ProvisionalTimerRecordsModel> provisionalTimerRecordsList = [];

  //Here we add all the repRecords:
  List<RepRecordsModel> finalRepRecordsList = [];
  List<ProvisionalRepRecordsModel> provisionalRepRecordsList = [];

  //To get the provisional TimerRecord corresponding to the session and exercise
  //If the prov Timer is not founded it creates one for the session and exercise
  ProvisionalTimerRecordsModel getProvisionalTimerRecord(
      {required String sessionId, required ExerciseModel exerciseModel}) {
    //var provisionalTimerRecord;

    ProvisionalTimerRecordsModel foundItem =
        provisionalTimerRecordsList.firstWhere(
      (item) =>
          item.sessionId == sessionId &&
          item.exerciseId == exerciseModel.exerciseId,
      orElse: () => ProvisionalTimerRecordsModel(
          exerciseId: exerciseModel.exerciseId,
          sessionId: sessionId,
          trainingId: exerciseModel.trainingId,
          timerRecordsId: UniqueKey().toString(),
          recordDay: DateTime.now(),
          timerRecordsList: []),
    );

    return foundItem;
  }

  ProvisionalRepRecordsModel getProvisionalRepRecord(
      {required String sessionId, required ExerciseModel exerciseModel}) {
    ProvisionalRepRecordsModel foundItem = provisionalRepRecordsList.firstWhere(
        (item) =>
            item.sessionId == sessionId &&
            item.exerciseId == exerciseModel.exerciseId,
        orElse: () => ProvisionalRepRecordsModel(
            repRecordsId: UniqueKey().toString(),
            sessionId: sessionId,
            trainingId: exerciseModel.trainingId,
            exerciseId: exerciseModel.exerciseId,
            recordDay: DateTime.now(),
            repRecord: 0));

    return foundItem;
  }

//To get the current TimerRecordsModel
  TimerRecordsModel getCurrentTimerRecordsModel(
      {required String sessionId, required String exerciseId}) {
    TimerRecordsModel? timerRecordsModel = null;
    try {
      //if (checkIfExerciseIsTimer(exerciseId: exerciseId)) {
      timerRecordsModel = finalTimerRecordsList.firstWhere(
        (element) =>
            element.sessionId == sessionId && element.exerciseId == exerciseId,
      );
      //}
    } catch (e) {
      timerRecordsModel = TimerRecordsModel(
        exerciseId: 'dummy',
        sessionId: 'dummy',
        timerRecordsId: 'dummy',
        timerRecordsList: [],
        recordDay: DateTime.now(),
        trainingId: 'dummy',
      );
    }

    return timerRecordsModel!;
  }

//To get the Last TimerRecordsModel before the current model
  TimerRecordsModel findLastModelBeforeDate(
      {required DateTime currentRecordDate, required String exerciseId}) {
    DateTime? closestDate;
    TimerRecordsModel? lastTimerRecord;
    lastTimerRecord = null;

    //Find all the same TimerRecords corresponding to same exercise
    //and with a date before the given one

    for (var model in finalTimerRecordsList) {
      if (model.exerciseId == exerciseId &&
          model.recordDay.isBefore(currentRecordDate)) {
        //Find the closest date
        if (closestDate == null || model.recordDay.isAfter(closestDate)) {
          closestDate = model.recordDay;
          lastTimerRecord = model;
        }
      }
    }

    return lastTimerRecord!;
  }

//To get the Last RepRecordsModel before the current model
  RepRecordsModel findLastRepModelBeforeDate(
      {required DateTime currentRecordDate, required String exerciseId}) {
    DateTime? closestDate;
    RepRecordsModel? lastRepRecord;
    lastRepRecord = null;

    //Find all the same RepRecords corresponding to same exercise
    //and with a date before the given one

    for (var model in finalRepRecordsList) {
      if (model.exerciseId == exerciseId &&
          model.recordDay.isBefore(currentRecordDate)) {
        //Find the closest date
        if (closestDate == null || model.recordDay.isAfter(closestDate)) {
          closestDate = model.recordDay;
          lastRepRecord = model;
        }
      }
    }
    lastRepRecord == null
        ? lastRepRecord = RepRecordsModel(
            exerciseId: 'dummy',
            sessionId: 'dummy',
            repRecordsId: 'dummy',
            repRecord: 9999,
            recordDay: DateTime.now(),
            trainingId: 'dummy',
          )
        : lastRepRecord = lastRepRecord;

    return lastRepRecord;
  }

//To adjust de repRecords format
  String getRepFormat({required int repRecord}) {
    String repString = '';

    repRecord >= 10 ? repString = '$repRecord' : repString = '0$repRecord';

    return repString;
  }

//To find the current Rep RecordsModel
  RepRecordsModel getCurrentRepRecordsModel(
      {required String sessionId, required String exerciseId}) {
    RepRecordsModel? repRecordsModel = null;
    try {
      //if (checkIfExerciseIsTimer(exerciseId: exerciseId)) {
      repRecordsModel = finalRepRecordsList.firstWhere(
        (element) =>
            element.sessionId == sessionId && element.exerciseId == exerciseId,
      );
      //}
    } catch (e) {
      repRecordsModel = RepRecordsModel(
        exerciseId: 'dummy',
        sessionId: 'dummy',
        repRecordsId: 'dummy',
        repRecord: 0,
        recordDay: DateTime.now(),
        trainingId: 'dummy',
      );
    }

    return repRecordsModel!;
  }

//To get the formatted '00:00' sum of the last record before the current record
  String getLastTimerRecordSum(
      {required DateTime currentRecordDate, required String exerciseId}) {
    String formattedLastTimerRecordSum = 'ALMOST';
    List<String> lastRecordsList = ['00:00.00'];

    try {
      lastRecordsList = findLastModelBeforeDate(
        currentRecordDate: currentRecordDate,
        exerciseId: exerciseId,
      ).timerRecordsList;
    } catch (e) {}

    formattedLastTimerRecordSum = getRecordsSum(recordsList: lastRecordsList);
    return formattedLastTimerRecordSum;
  }

//List with only the TimerRecordsModel of the user in a specific exercise
  List<String> getFilteredTimerRecordsList(
      {required String sessionId, required String exerciseId}) {
    List<String> filteredTimerRecordsList = [];

    for (var el in finalTimerRecordsList) {
      if (el.sessionId == sessionId && el.exerciseId == exerciseId) {
        filteredTimerRecordsList = el.timerRecordsList;
      }
    }

    return filteredTimerRecordsList;
  }

//List with only the repRecordsModel of the user in a specific exercise
  String getFilteredRepRecord(
      {required String sessionId, required String exerciseId}) {
    int repRecord = 9;

    for (var el in finalRepRecordsList) {
      if (el.sessionId == sessionId && el.exerciseId == exerciseId) {
        repRecord = el.repRecord;
      }
    }

    int repRecordIndex = finalRepRecordsList.indexWhere((element) =>
        element.sessionId == sessionId && element.exerciseId == exerciseId);

    int reppRecord = repRecordIndex != -1
        ? finalRepRecordsList[repRecordIndex].repRecord
        : 9;

    String reppRecordString = reppRecord.toString();

    reppRecord >= 10 ? reppRecordString : reppRecordString = '0$reppRecord';

    return reppRecordString;
  }

// --
//Stopwatch con Timer:

//Contador regresivo de 5 segundos:

  int countdownSeconds = 5;
  String countdownText = '5';
  bool showCountdownText = false;

  late Timer countdownTimer;
  late Timer timer;
  RxInt centiseconds = 0.obs;
  RxInt seconds = 0.obs;
  RxInt minutes = 0.obs;
  bool countdownShouldRun = true;

  bool isRunning = false;
  DateTime lastUpdateTime = DateTime.now();

  void startCountdown() {
    if (countdownShouldRun) {
      showCountdownText = true;
      print('showCountdownText: $showCountdownText');
      countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
        countdownSeconds--;
        countdownText = '$countdownSeconds';
        update();

        if (countdownSeconds > 0) {
        } else {
          countdownTimer.cancel();
          countdownText = 'Go!';

          update();
        }
      });
    }
  }

  Duration delayDuration = const Duration(seconds: 0);
  Duration delayGo = const Duration(milliseconds: 500);
  void start() {
    startCountdown();

    //VERSIÓN ORIGINAL QUE FUNCIONA:
    if (!isRunning) {
      // INICIO DE LA CUENTA REGRESIVA
      countdownShouldRun
          ? delayDuration = const Duration(seconds: 5)
          : delayDuration = const Duration(seconds: 0);
      Future.delayed(delayDuration, () {
        countdownShouldRun = false;
        Future.delayed(delayGo, () {
          showCountdownText = false;
        });
        timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
          _updateTime();

          update();
        });
      });
      isRunning = true;
      update();
    }
  }

  void stop() {
    timer.cancel();
    isRunning = false;

    update();
  }

  void reset() {
    countdownTimer.cancel();
    countdownSeconds = 5;
    countdownText = '5';

    centiseconds.value = 0;
    seconds.value = 0;
    minutes.value = 0;
    countdownShouldRun = true;

    update();
  }

  void _updateTime() {
    DateTime now = DateTime.now();
    int centisecondsElapsed =
        now.difference(lastUpdateTime).inMilliseconds ~/ 10;
    lastUpdateTime = now;
    centiseconds.value += centisecondsElapsed;

    if (centiseconds.value >= 100) {
      centiseconds.value = 0;
      seconds.value++;
      if (seconds.value >= 60) {
        seconds.value = 0;
        minutes.value++;
      }
    }
  }

  void addLap(
      {required ProvisionalTimerRecordsModel provisionalTimerRecordsModel}) {
    provisionalTimerRecordsModel.timerRecordsList.add(getFormattedTime());

    int provisionalRecords =
        provisionalTimerRecordsModel.timerRecordsList.length;
    update();
  }

  String getFormattedTime() {
    return '${minutes.value.toString().padLeft(2, '0')}:${seconds.value.toString().padLeft(2, '0')}.${centiseconds.value.toString().padLeft(2, '0')}';
  }

  void saveProvisionalTimerRecordsModel(
      {required ProvisionalTimerRecordsModel provisionalTimerRecordsModel}) {
    int existingIndex = provisionalTimerRecordsList.indexWhere((id) =>
        id.timerRecordsId == provisionalTimerRecordsModel.timerRecordsId);

    if (existingIndex != -1) {
      // Si se encontró el modelo en la lista, reemplazarlo con el modelo actualizado
      provisionalTimerRecordsList[existingIndex] = provisionalTimerRecordsModel;
    } else {
      // Si el modelo no se encontró en la lista, agrégalo
      provisionalTimerRecordsList.add(provisionalTimerRecordsModel);
    }
  }

  void saveProvisionalRepRecordsModel(
      {required ProvisionalRepRecordsModel provisionalRepRecordsModel}) {
    int existingIndex = provisionalRepRecordsList.indexWhere(
        (id) => id.repRecordsId == provisionalRepRecordsModel.repRecordsId);

    if (existingIndex != -1) {
      // Si se encontró el modelo en la lista, reemplazarlo con el modelo actualizado
      provisionalRepRecordsList[existingIndex] = provisionalRepRecordsModel;
    } else {
      // Si el modelo no se encontró en la lista, agrégalo
      provisionalRepRecordsList.add(provisionalRepRecordsModel);
    }
  }

  void removeLap(
      {required int indexToRemove,
      required ProvisionalTimerRecordsModel provisionalTimerRecordsModel}) {
    provisionalTimerRecordsModel.timerRecordsList.removeAt(indexToRemove);
    update();
  }

//To sum all the timerRecords within a list
  String getRecordsSum({required List<String> recordsList}) {
    String recordsSum = '';

    int totalCentecimas = 0;

    for (String tiempo in recordsList) {
      List<String> partes = tiempo.split(':');
      int minutos = int.parse(partes[0]);
      List<String> segundosCentecimas = partes[1].split('.');
      int segundos = int.parse(segundosCentecimas[0]);
      int centecimas = int.parse(segundosCentecimas[1]);

      totalCentecimas += (minutos * 6000) + (segundos * 100) + centecimas;
    }

    int totalMinutos = totalCentecimas ~/ 6000;
    totalCentecimas %= 6000;
    int totalSegundos = totalCentecimas ~/ 100;
    int totalCentecimasRestantes = totalCentecimas % 100;

    recordsList.length >= 1
        ? recordsSum =
            '${totalMinutos.toString().padLeft(2, '0')}:${totalSegundos.toString().padLeft(2, '0')}.${totalCentecimasRestantes.toString().padLeft(2, '0')}'
        : recordsSum = '00:00.00';

    return recordsSum.substring(0, 5);
  }

//Fin Stopwatch
//--

//To get currentTimerRecord for Provisional Session
  String getCurrentTimerRecord(
      {required ExerciseModel exerciseModel, required String sessionId}) {
    String currentRecord = '';

    List<String> recordsList = getProvisionalTimerRecord(
            exerciseModel: exerciseModel, sessionId: sessionId)
        .timerRecordsList;

    currentRecord = getRecordsSum(recordsList: recordsList);

    return currentRecord;
  }

//To get currentRepRecord for Provisional Session
  String getCurrentRepRecord(
      {required ExerciseModel exerciseModel, required String sessionId}) {
    String currentRecord = '';

    currentRecord = getProvisionalRepRecord(
            exerciseModel: exerciseModel, sessionId: sessionId)
        .repRecord
        .toString();

    currentRecord.length < 2
        ? currentRecord = '0$currentRecord'
        : currentRecord = currentRecord;

    return currentRecord;
  }

//To calculate the session Time
  String getTimerRecordDifference(
      {required String lastRecord, required String currentRecord}) {
    String recordDifference = sessionsController.calculateSessionTime(
        startTime: lastRecord, endTime: currentRecord);

    return recordDifference;
  }

  int increaseRepRecord(
      {required ProvisionalRepRecordsModel provisionalRepRecordsModel}) {
    int rep = provisionalRepRecordsModel.repRecord;
    rep < 99 ? rep += 1 : rep += 0;
    provisionalRepRecordsModel.repRecord = rep;

    int largoRecords = provisionalRepRecordsList.length;

    update();

    return rep;
  }

  int decreaseRepRecord(
      {required ProvisionalRepRecordsModel provisionalRepRecordsModel}) {
    int rep = provisionalRepRecordsModel.repRecord;
    rep != 0 ? rep -= 1 : rep -= 0;
    provisionalRepRecordsModel.repRecord = rep;

    update();
    return rep;
  }

//To turn fomat 01:43 to 1min 43sec
  String getTimerRecordFormat({required String timerRecord}) {
    String finalFormat = '';

    String minutesTen = timerRecord[0];
    String minutesUnits = timerRecord[1];

    String secondsTen = timerRecord[3];
    String secondsUnits = timerRecord[4];

    String minutesFull =
        minutesTen != '0' ? '$minutesTen$minutesUnits ' : minutesUnits;

    String secondsFull =
        secondsTen != '0' ? '$secondsTen$secondsUnits' : secondsUnits;

    finalFormat = minutesFull != '0'
        ? '$minutesFull min $secondsFull sec'
        : '$secondsFull sec';

    return finalFormat;
  }

//To turn fomat 01:43 to 1hr 43min
  String getTimerRecordFormatHours({required String timerRecord}) {
    String finalFormat = '';

    String hoursTen = timerRecord[0];
    String hoursUnits = timerRecord[1];

    String minutesTen = timerRecord[3];
    String minutesUnits = timerRecord[4];

    String hoursFull = hoursTen != '0' ? '$hoursTen$hoursUnits ' : hoursUnits;

    String minutesFull =
        minutesTen != '0' ? '$minutesTen$minutesUnits' : minutesUnits;

    finalFormat = hoursFull != '0'
        ? '$hoursFull hr $minutesFull min'
        : '$minutesFull min';

    return finalFormat;
  }

//To calculate the %GAP of to timerRecords
  double calculateTimerRecordsGap(
      {required String lastRecord, required String currentRecord}) {
    // ignore: unused_local_variable
    String timerGap = '';
    double gapInt = 0.0;

    if (lastRecord != '00:00' && lastRecord != '00') {
      //lastRecord
      int minutesTen = int.parse(lastRecord[0]);
      int minutesUnits = int.parse(lastRecord[1]);
      int secondsTen = int.parse(lastRecord[3]);
      int secondsUnits = int.parse(lastRecord[4]);

      int totalSecondsLastRecord = ((minutesTen * 10 + minutesUnits) * 60) +
          (secondsTen * 10 + secondsUnits);

      //currentRecord
      int minutesTenCR = int.parse(currentRecord[0]);
      int minutesUnitsCR = int.parse(currentRecord[1]);
      int secondsTenCR = int.parse(currentRecord[3]);
      int secondsUnitsCR = int.parse(currentRecord[4]);

      int totalSecondsCurrentRecord =
          ((minutesTenCR * 10 + minutesUnitsCR) * 60) +
              (secondsTenCR * 10 + secondsUnitsCR);

      gapInt =
          (((totalSecondsCurrentRecord / totalSecondsLastRecord) - 1) * 100);

      timerGap = gapInt.toString().substring(0, 2);
    } else {
      gapInt = 0.01;
    }

    return gapInt;
  }

  //To calculate the %GAP of to repRecords
  double calculateRepRecordsGap(
      {required String lastRecord, required String currentRecord}) {
    double gapInt = 0.0;

    if (lastRecord != '00' && lastRecord != '00:00') {
      //lastRecord
      int repTen = int.parse(lastRecord[0]);
      int repUnits = int.parse(lastRecord[1]);

      int totalRepLastRecord = (repTen * 10) + repUnits;

      //currentRecord
      int repTenCR = int.parse(currentRecord[0]);
      int repUnitsCR = int.parse(currentRecord[1]);

      int totalRepCurrentRecord = (repTenCR * 10) + repUnitsCR;

      gapInt = (((totalRepCurrentRecord / totalRepLastRecord) - 1) * 100);
    } else {
      gapInt = 0.01;
    }

    return gapInt;
  }

//To get the EU format date
  String getEuFormatDate({required DateTime dateTime}) {
    String year = dateTime.toString().substring(0, 4);
    String month = dateTime.toString().substring(5, 7);
    String day = dateTime.toString().substring(8, 10);
    String dateEu = '$day/$month/$year';

    return dateEu;
  }

  //To get the performancesformatted with arrow icon

  Widget getFullPerformance({required String performance}) {
    Widget row;
    performance[0] != '-'
        ? row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.arrow_drop_up_rounded,
                color: tColorGreeny,
              ),
              Text(
                '$performance%',
                style: tStyleDashBoardSmallRecordTextM,
              )
            ],
          )
        : row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.arrow_drop_down_rounded,
                color: tColorPrimary_8,
              ),
              Text(
                '${performance.substring(1)}%',
                style: tStyleDashBoardSmallRecordTextM,
              )
            ],
          );

    // ignore: sized_box_for_whitespace
    row = Container(
      height: 70,
      width: 50,
      //decoration: const BoxDecoration(color: tColorPink),
      child: row,
    );
    return row;
  }
}
