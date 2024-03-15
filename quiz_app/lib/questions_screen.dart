import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer-button.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({super.key});
  final QuizController _quizController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                questions[_quizController.currentQuestionIndex.value].text,
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 201, 153, 251),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...questions[_quizController.currentQuestionIndex.value]
                  .getShuffledAnswers()
                  .map(
                (answer) {
                  return AnswerButton(
                      answerText: answer,
                      onTap: () {
                        _quizController.answerQuestion(answer);
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
