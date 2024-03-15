import 'package:get/get.dart';
import 'package:quiz_app/data/questions.dart';

class QuizController extends GetxController {
  var activeScreen = "start-screen".obs;
  var selectedAnswers = [].obs;
  var currentQuestionIndex = 0.obs;

  void switchScreen() {
    activeScreen.value = "question-screen";
  }

  void chooseAnswer(String answer) {
    selectedAnswers.value.add(answer);
    if (selectedAnswers.value.length == questions.length) {
      activeScreen.value = "result-screen";
    }
  }

  void restartQuiz() {
    selectedAnswers.value = [];
    currentQuestionIndex.value = 0;
    activeScreen.value = "question-screen";
  }

  void answerQuestion(String selectedAnswer) {
    chooseAnswer(selectedAnswer);
    currentQuestionIndex.value++;
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswers.value.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].text,
        "correct_answer": questions[i].answers[0],
        "user_answer": selectedAnswers.value[i]
      });
    }
    return summary;
  }
}
