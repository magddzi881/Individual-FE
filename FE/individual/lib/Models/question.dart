class Question {
  final int id;
  final int quizId;
  final String title;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;

  Question({
    required this.id,
    required this.quizId,
    required this.title,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });
}
