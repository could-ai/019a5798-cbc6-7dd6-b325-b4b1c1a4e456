import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  Map<int, String> userAnswers = {};
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    questions = QuestionsData.getQuestions();
  }

  void selectAnswer(String answer) {
    setState(() {
      userAnswers[currentQuestionIndex] = answer;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void submitQuiz() {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswer) {
        correctAnswers++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          correctAnswers: correctAnswers,
          totalQuestions: questions.length,
          userAnswers: userAnswers,
          questions: questions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];
    String? selectedAnswer = userAnswers[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Soal ${currentQuestionIndex + 1} dari ${questions.length}'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / questions.length,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        currentQuestion.question,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ...currentQuestion.options.map((option) {
                    bool isSelected = selectedAnswer == option;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => selectAnswer(option),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.shade100
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue.shade700
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue.shade700
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? Colors.blue.shade700
                                      : Colors.white,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.blue.shade700
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestionIndex > 0)
                  ElevatedButton.icon(
                    onPressed: previousQuestion,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Sebelumnya'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                if (currentQuestionIndex < questions.length - 1)
                  ElevatedButton.icon(
                    onPressed: nextQuestion,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Selanjutnya'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {
                      if (userAnswers.length < questions.length) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Peringatan'),
                            content: Text(
                              'Anda belum menjawab ${questions.length - userAnswers.length} soal. Yakin ingin menyelesaikan?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  submitQuiz();
                                },
                                child: const Text('Ya, Selesai'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        submitQuiz();
                      }
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Selesai'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
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
