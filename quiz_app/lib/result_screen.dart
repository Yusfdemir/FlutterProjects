import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/question_summary.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({
    super.key,
  });
  final QuizController _quizController = Get.find();

  @override
  Widget build(BuildContext context) {
    final summaryData = _quizController.getSummaryData();
    final numTotalQuestions = questions.length;
    // where ile filtreleme yapıp doğru işaretlenen soruları bil listeye aldık
    final numCorrectQuestions = summaryData.where(
      (data) {
        return data['user_answer'] == data["correct_answer"];
      },
    ).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            QuestionSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
                onPressed: () => _quizController.restartQuiz(),
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                icon: const Icon(Icons.refresh),
                label: const Text("Restart Quiz!"))
          ],
        ),
      ),
    );
  }
}
