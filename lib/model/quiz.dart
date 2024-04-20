import 'package:realtime_quiz_app/model/problem.dart';

class QuizManger {
  List<ProblemManager>? problems;
  String? title;

  ProblemManager? answer;

  QuizManger({
    this.problems,
    this.title,
    this.answer,
  });
}
