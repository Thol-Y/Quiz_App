import 'package:flutter/material.dart';
import 'quiz_app.dart';
import 'model/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = [
      const Question(
        title: "Who is the cute boy?",
        possibleAnswers: ["Sithol", "Soksan", ],
        goodAnswer: "Sithol",
      ),
      const Question(
        title: "Who is king of smos?",
        possibleAnswers: ["Sithol", "Soksan",],
        goodAnswer: "Sithol",
      ),
      const Question(
        title: "who sl ke alone?",
        possibleAnswers: ["Sithol", "Soksan",],
        goodAnswer: "Sithol",
      ),
    ];

    final Quiz quiz = Quiz(title: " Wellcome To The Quiz From God!", questions: questions);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizApp(quiz),
    );
  }
}
