import 'package:flutter/material.dart';
import '../widgets/app_button.dart'; 

class WelcomeScreen extends StatelessWidget {
  final String title;
  final VoidCallback onStartQuiz;

  const WelcomeScreen({
    required this.title,
    required this.onStartQuiz,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            AppButton(
              label: "Start Quiz",
              icon: Icons.play_arrow,
              onTap: onStartQuiz,
            ),
          ],
        ),
      ),
    );
  }
}
