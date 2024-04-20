import 'package:flutter/material.dart';
import 'package:realtime_quiz_app/model/quiz.dart';

import '../model/problem.dart';

class QuizBottomSheetWidget extends StatefulWidget {
  const QuizBottomSheetWidget({super.key});

  @override
  State<QuizBottomSheetWidget> createState() => _QuizBottomSheetWidgetState();
}

class _QuizBottomSheetWidgetState extends State<QuizBottomSheetWidget> {
  List<ProblemManager> problemItems = [];

  ProblemManager? selectedAnswer;

  TextEditingController titleTec = TextEditingController();

  addOptions() {
    problemItems.add(
      ProblemManager(
        index: problemItems.length,
        textEditingController: TextEditingController(),
      ),
    );
    setState(() {
      print(selectedAnswer == null);
      print(problemItems.length);
    });
  }

  removeOption(int index) {
    problemItems.removeAt(index);

    setState(() {});
  }

  @override
  void dispose() {
    titleTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("퀴즈 (문제) 출제하기"),
          TextField(
            decoration: InputDecoration(
              hintText: "문제를 입력해주세요",
            ),
            controller: titleTec,
          ),
          Text("문제에 대한 선택지 출제"),
          Expanded(
            child: ListView.builder(
              itemCount: problemItems.length,
              itemBuilder: (context, index) {
                final item = problemItems[index];
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: item.textEditingController,
                        decoration: InputDecoration(
                          hintText: "선택지 입력",
                        ),
                        onSubmitted: (s) {
                          setState(() {});
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => removeOption(index),
                      icon: const Icon(Icons.clear),
                    )
                  ],
                );
              },
            ),
          ),
          Text("정답 선택"),
          DropdownButton<ProblemManager>(
              value: selectedAnswer,
              items: problemItems
                      .map(
                        (e) => DropdownMenuItem<ProblemManager>(
                          value: e,
                          child: Text(e.textEditingController.text),
                        ),
                      )
                      .toList() ??
                  [],
              onChanged: (value) {
                setState(() {
                  print(value);
                  selectedAnswer = value;
                });
              }),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () => addOptions(),
                child: Text("선택지 추가"),
              ),
              TextButton(
                onPressed: () {
                  //문제에 정답이 없는 경우
                  if (titleTec.text.isEmpty) {
                    return;
                  }
                  print('문제에 정답이 없는 경우');
                  //선택지가 없는 경우
                  if (problemItems.isEmpty) {
                    return;
                  }
                  print('선택지가 없는 경우');
                  //정답지가 없는 경우
                  if (selectedAnswer == null) {
                    return;
                  }
                  print('정답지가 없는 경우');

                  final quiz = QuizManger(
                    problems: [
                      ...problemItems,
                    ],
                    title: titleTec.text.trim(),
                    answer: selectedAnswer,
                  );

                  Navigator.of(context).pop<QuizManger>(quiz);
                },
                child: Text("완료"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
