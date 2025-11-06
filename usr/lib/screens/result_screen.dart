import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final Map<int, String> userAnswers;
  final List<Question> questions;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.userAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (correctAnswers / totalQuestions) * 100;
    String grade = percentage >= 90
        ? 'A'
        : percentage >= 80
            ? 'B'
            : percentage >= 70
                ? 'C'
                : percentage >= 60
                    ? 'D'
                    : 'E';

    Color gradeColor = percentage >= 80
        ? Colors.green
        : percentage >= 60
            ? Colors.orange
            : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Latihan'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade700, Colors.blue.shade500],
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 80,
                  color: Colors.yellow,
                ),
                const SizedBox(height: 20),
                Text(
                  'Nilai: ${percentage.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Grade: $grade',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: gradeColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Benar: $correctAnswers dari $totalQuestions soal',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                Question question = questions[index];
                String? userAnswer = userAnswers[index];
                bool isCorrect = userAnswer == question.correctAnswer;
                bool isAnswered = userAnswer != null;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: !isAnswered
                          ? Colors.grey
                          : isCorrect
                              ? Colors.green
                              : Colors.red,
                      child: Icon(
                        !isAnswered
                            ? Icons.remove
                            : isCorrect
                                ? Icons.check
                                : Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Soal ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      question.question,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.question,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (isAnswered)
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? Colors.green.shade50
                                      : Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isCorrect
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isCorrect ? Icons.check : Icons.close,
                                      color: isCorrect
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Jawaban Anda: $userAnswer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isCorrect
                                              ? Colors.green.shade900
                                              : Colors.red.shade900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Tidak dijawab',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.lightbulb,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Jawaban Benar: ${question.correctAnswer}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Pembahasan: ${question.explanation}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizHomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Kembali ke Beranda'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
