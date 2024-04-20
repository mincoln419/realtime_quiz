import 'package:realtime_quiz_app/model/problem.dart';

class QuizManger {
  List<ProblemManager>? problem;
  String? title;

  ProblemManager? answer;

  QuizManger({this.problem, this.title, this.answer,});

}