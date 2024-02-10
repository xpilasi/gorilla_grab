class TrainingModel {
  late String user;
  late String trainingId;
  late String name;
  late DateTime creationDate;
  late int color;

  TrainingModel(
      {required this.trainingId,
      required this.name,
      required this.user,
      required this.creationDate,
      required this.color});
}
