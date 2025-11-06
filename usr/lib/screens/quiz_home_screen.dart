import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade800],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.school,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Olimpiade Matematika SD',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Bilangan Pecahan dan Operasinya',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.quiz, color: Colors.blue),
                              const SizedBox(width: 10),
                              Text(
                                '25 Soal Pilihan Ganda',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.timer, color: Colors.blue),
                              const SizedBox(width: 10),
                              Text(
                                'Tanpa Batas Waktu',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Mulai Latihan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnswerKeyScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.key),
                    label: const Text(
                      'Lihat Kunci Jawaban',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerKeyScreen extends StatelessWidget {
  const AnswerKeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = [
      '1. 1/2 + 1/4 = 3/4',
      '2. 3/5 - 1/5 = 2/5',
      '3. 2/3 × 3/4 = 1/2',
      '4. 1/2 ÷ 1/4 = 2',
      '5. Bentuk desimal dari 3/4 = 0,75',
      '6. 2 1/2 + 1 1/4 = 3 3/4',
      '7. 5/6 - 1/3 = 1/2',
      '8. Pecahan senilai 2/5 = 4/10',
      '9. 3/4 × 8 = 6',
      '10. 4 ÷ 1/2 = 8',
      '11. Urutan: 2/5, 1/2, 3/4',
      '12. 1 1/3 × 2 1/4 = 3',
      '13. 7/8 - 3/4 + 1/2 = 5/8',
      '14. 3/5 dalam persen = 60%',
      '15. 2/3 ÷ 4/5 = 5/6',
      '16. 4/6 dan 6/9 disederhanakan = 2/3',
      '17. 0,25 + 1/2 = 0,75',
      '18. 5/6 × 3/5 ÷ 1/2 = 1',
      '19. 15/20 disederhanakan = 3/4',
      '20. 3 3/4 - 1 1/2 = 2 1/4',
      '21. 2/5 dari bilangan = 12, bilangan = 30',
      '22. 1/2 + 1/3 + 1/6 = 1',
      '23. (2/3)² = 4/9',
      '24. 3 1/2 - 1 3/4 kg = 1 3/4 kg',
      '25. 3/4 = 75%',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kunci Jawaban'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade700,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                questions[index].substring(questions[index].indexOf('.') + 2),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
