class Question {
  final int number;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.number,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}
