import 'package:flutter/material.dart';
import '../model/quiz.dart';

class QuestionScreen extends StatefulWidget {
  final Question question; // Model for the question
  final void Function(String answer) onAnswerSelected; // Callback when an answer is selected

  const QuestionScreen({
    required this.question,
    required this.onAnswerSelected,
    super.key,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the question title
            Text(
              widget.question.title,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Display the answer buttons
            for (final answer in widget.question.possibleAnswers)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // Button width: 80% of screen
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onAnswerSelected(answer); // Handle answer selection
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.lightBlue[200],
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      answer,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
