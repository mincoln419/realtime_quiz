import 'package:flutter/material.dart';

import '../model/quiz.dart';

class QuizMangerPage extends StatefulWidget {
  const QuizMangerPage({super.key});

  @override
  State<QuizMangerPage> createState() => _QuizMangerPageState();
}

class _QuizMangerPageState extends State<QuizMangerPage> {
  String? uid;

  // 퀴즈 문제 목록
  List<QuizManger> quizItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 퀴즈 출제 목록
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('퀴즈 출제하기(출제자용'),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  text: '출제하기',
                ),
                Tab(
                  text: '퀴즈목록',
                ),
              ]),
              Expanded(
                  child: TabBarView(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(quizItems[index].title ?? '문제 타이틀 없음'),
                          children: quizItems[index]
                              .problem!
                              .map((e) => ListTile(
                                    title: Text(e.textEditingController.text),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
