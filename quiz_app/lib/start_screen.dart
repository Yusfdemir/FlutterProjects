import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "lib/assets/images/quiz-logo.png",
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
            // opacity için ARGB kullanılabilir
          ),
          //Opacity için genellikle bu önerilmez
          // Opacity(
          //   opacity: 0.4,
          //   child: Image.asset(
          //     "lib/assets/images/quiz-logo.png",
          //     width: 300,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Text(
              "Learn Flutter the fun way",
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: OutlinedButton.icon(
                icon: const Icon(Icons.arrow_right_alt),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                onPressed: startQuiz,
                label: const Text("Start Quiz")),
          )
        ],
      ),
    );
  }
}
