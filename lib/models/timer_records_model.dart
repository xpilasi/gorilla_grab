class TimerRecordsModel {
  late String timerRecordsId;
  late String sessionId;
  late String trainingId;
  late String exerciseId;
  late DateTime recordDay;
  late List<String> timerRecordsList;

  TimerRecordsModel(
      {required this.timerRecordsId,
      required this.sessionId,
      required this.trainingId,
      required this.exerciseId,
      required this.recordDay,
      required this.timerRecordsList});
}
