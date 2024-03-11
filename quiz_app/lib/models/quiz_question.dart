class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    // List.of() listeyi kopyalar
    final shuffledList = List.of(answers);
    // shuffle metodu void döner yani return shuffledList.shuffle kullanamayız
    shuffledList.shuffle();
    return shuffledList;
  }
}
