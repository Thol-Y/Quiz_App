import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: QuizApp()));
}

// Model Classes
class Answer {
  final bool correct;

  Answer(this.correct);

  bool isCorrect() {
    return correct;
  }
}

class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;

  Question(this.text, this.options, this.correctAnswer);
}

class Quiz {
  final String title;
  final List<Question> questions;

  Quiz(this.title, this.questions);
}

class Submission {
  final Map<Question, String> _answers = {};

  int getScore() {
  int score = 0;
  _answers.forEach((question, answer) {
    if (question.correctAnswer == answer) {
      score++;
    }
  });
  return score;
}


  Answer? getAnswerFor(Question question) {
    if (_answers.containsKey(question)) {
      return Answer(question.correctAnswer == _answers[question]);
    }
    return null;
  }

  void addAnswer(Question question, String answer) {
    _answers[question] = answer;
  }

  void removeAnswers() {
    _answers.clear();
  }
}

// QuizState Enum
enum QuizState { notStarted, started, finished }

// App Widget
class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted;
  final Submission submission = Submission();
  final Quiz quiz = Quiz(
    "General Knowledge Quiz",
    [
      Question("What's 2+2?", ["3", "4", "5"], "4"),
      Question("What's the capital of France?", ["Berlin", "Paris", "Rome"], "Paris"),
    ],
  );
  int currentQuestionIndex = 0;

  void restartQuiz() {
    setState(() {
      quizState = QuizState.notStarted;
      currentQuestionIndex = 0;
      submission.removeAnswers();
    });
  }

  void nextQuestion(String answer) {
    setState(() {
      submission.addAnswer(quiz.questions[currentQuestionIndex], answer);
      if (currentQuestionIndex < quiz.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        quizState = QuizState.finished;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (quizState) {
      case QuizState.notStarted:
        return WelcomeScreen(onStart: () {
          setState(() {
            quizState = QuizState.started;
          });
        });
      case QuizState.started:
        return QuestionScreen(
          question: quiz.questions[currentQuestionIndex],
          onTap: nextQuestion,
        );
      case QuizState.finished:
        return ResultScreen(
          onRestart: restartQuiz,
          submission: submission,
          quiz: quiz,
        );
      default:
        return Container();
    }
  }
}

// Welcome Screen
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeScreen({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Quiz!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onStart,
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

// Question Screen
class QuestionScreen extends StatelessWidget {
  final Question question;
  final Function(String) onTap;

  const QuestionScreen({required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question.text,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ...question.options.map((option) {
            return ElevatedButton(
              onPressed: () => onTap(option),
              child: Text(option),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Result Screen
class ResultScreen extends StatelessWidget {
  final VoidCallback onRestart;
  final Submission submission;
  final Quiz quiz;

  const ResultScreen(
      {required this.onRestart, required this.submission, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Score: ${submission.getScore()} / ${quiz.questions.length}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
