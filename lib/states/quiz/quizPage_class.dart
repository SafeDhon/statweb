// ignore_for_file: file_names

class QuizQuestion {
  int unit;
  int id;
  String question;
  List<dynamic> choice;
  int answer;
  int choose;
  List<dynamic> solution;
  String table;
  QuizQuestion({
    required this.unit,
    required this.id,
    required this.question,
    required this.choice,
    required this.answer,
    required this.choose,
    required this.solution,
    required this.table,
  });
}
