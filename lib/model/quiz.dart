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

class QuizDetail {
  String? code;
  List<Problem>? problems;

  QuizDetail(this.code, this.problems);

  QuizDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['problems'] != null) {
      problems = [];
      json['problems'].forEach((v) {
        problems!.add(Problem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['code'] = code;

    if (problems != null) {
      data['problems'] = problems!.map((e) => e.toString()).toList();
    }
    return data;
  }
}

class Quiz {
  String? code;
  String? generateTime;

  String? quizDetailRef;

  int? timestamp;
  String? uid;

  Quiz(this.code, this.generateTime, this.quizDetailRef, this.timestamp,
      this.uid);

  Quiz.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    generateTime = json['generateTime'];
    quizDetailRef = json['quizDetailRef'];
    timestamp = json['timestamp'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['code'] = code;
    data['generateTime'] = generateTime;
    data['quizDetailRef'] = quizDetailRef;
    data['timestamp'] = timestamp;
    data['uid'] = uid;

    return data;
  }
}
