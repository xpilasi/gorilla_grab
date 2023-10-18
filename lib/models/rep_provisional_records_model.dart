class ProvisionalRepRecordsModel {
  late String repRecordsId;
  late String sessionId;
  late String trainingId;
  late String exerciseId;
  late DateTime recordDay;
  late int repRecord;

  ProvisionalRepRecordsModel(
      {required this.repRecordsId,
      required this.sessionId,
      required this.trainingId,
      required this.exerciseId,
      required this.recordDay,
      required this.repRecord});
}
