import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final List<Question> questions;
  final Submission userAnswers;
  final VoidCallback onRestartQuiz;

  const ResultScreen({
    required this.score,
    required this.questions,
    required this.userAnswers,
    required this.onRestartQuiz,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildScoreDisplay(),
            Expanded(child: _buildQuestionResults()),
            _buildRestartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        'You answered $score on ${questions.length}!',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuestionResults() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final userAnswer = userAnswers.getAnswerFor(question);
        final isCorrect = userAnswer == question.goodAnswer;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              _buildQuestionHeader(index, question.title, isCorrect),
              _buildAnswerOptions(question, userAnswer!),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionHeader(int index, String title, bool isCorrect) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          radius: 18,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerOptions(Question question, String userAnswer) {
    return Column(
      children: question.possibleAnswers.map((answer) {
        final isCorrectAnswer = answer == question.goodAnswer;
        final isUserAnswer = answer == userAnswer;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCorrectAnswer)
                const Icon(Icons.check, color: Color.fromARGB(255, 16, 87, 21)),
              const SizedBox(width: 8),
              Text(
                answer,
                style: TextStyle(
                  color: isCorrectAnswer
                      ? const Color.fromARGB(255, 16, 87, 21)
                      : (isUserAnswer ? Colors.red : Colors.black),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRestartButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton.icon(
        onPressed: onRestartQuiz,
        icon: const Icon(Icons.restart_alt),
        label: const Text('Restart Quiz'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
