import 'package:flutter/material.dart';
import 'model/quiz.dart';
import 'model/submission.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';
import 'screens/welcome_screen.dart';

class QuizApp extends StatefulWidget {
  final Quiz quiz;

  const QuizApp(this.quiz, {super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentQuestionIndex = -1; // -1 indicates the welcome screen
  final Submission _submission = Submission();

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = -1;
      _submission.clearAnswers();
    });
  }

  void _answerQuestion(String answer) {
    final question = widget.quiz.questions[_currentQuestionIndex];
    _submission.addAnswer(question, answer);

    setState(() {
      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _currentQuestionIndex = widget.quiz.questions.length; // Move to results
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex == -1) {
      return WelcomeScreen(
        title: widget.quiz.title,
        onStartQuiz: () {
          setState(() {
            _currentQuestionIndex = 0;
          });
        },
      );
    } else if (_currentQuestionIndex < widget.quiz.questions.length) {
      return QuestionScreen(
        question: widget.quiz.questions[_currentQuestionIndex],
        onAnswerSelected: _answerQuestion,
      );
    } else {
      return ResultScreen(
        score: _submission.getScore(widget.quiz.questions),
        questions: widget.quiz.questions,
        userAnswers: _submission,
        onRestartQuiz: _restartQuiz,
      );
    }
  }
}
