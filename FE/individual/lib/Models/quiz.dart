class Quiz {
  final int id;
  final String tutorUsername;
  int points;
  int questionCount;
  final int studyMaterialId;

  Quiz(
      {required this.id,
      required this.tutorUsername,
      required this.studyMaterialId,
      required this.points,
      required this.questionCount});
}
