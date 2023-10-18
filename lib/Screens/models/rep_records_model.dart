class RepRecordsModel {
  late String repRecordsId;
  late String sessionId;
  late String trainingId;
  late String exerciseId;
  late DateTime recordDay;
  late int repRecord;

  RepRecordsModel(
      {required this.repRecordsId,
      required this.sessionId,
      required this.trainingId,
      required this.exerciseId,
      required this.recordDay,
      required this.repRecord});
}
