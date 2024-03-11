import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = "question-screen";
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        selectedAnswers = [];
        activeScreen = "start-screen";
      });
    }
  }

  /* Bu Ekran değiştirmek için bir yöntem init state and lifting state up
  Widget? activeScreen;
  @override
  void initState() {
    // TODO: implement initState
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }
  void switchScreen() {
    setState(() {
      activeScreen = const QuestionScreen();
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    // if statement ile ekran değiştirme
    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == "question-screen") {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // initState and lifting state up
          //child: activeScreen,

          // ternary
          // child: activeScreen == "start-screen"
          //     ? StartScreen(switchScreen)
          //     : const QuestionScreen(),

          // if statement
          child: screenWidget,
        ),
      ),
    );
  }
}
