import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_quiz_app/web/quiz_bottom_sheet_widget.dart';

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

  //익명로그인 정보
  signInAnonymously() {
    FirebaseAuth.instance.signInAnonymously().then((value) {
      setState(() {
        uid = value.user?.uid ?? "";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    signInAnonymously();
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
                      itemCount: quizItems.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(quizItems[index].title ?? '문제 타이틀 없음'),
                          children: quizItems[index]
                                  .problems
                                  ?.map((e) => ListTile(
                                        title:
                                            Text(e.textEditingController.text),
                                      ))
                                  .toList() ??
                              [],
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      //TODO : 퀴즈 생성 및 핀코드 생성 로직
                    },
                    height: 72,
                    color: Colors.indigo,
                    child: Text(
                      "제출 및 핀코드 생성",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          //TODO: 문제 출제를 위한 모달 띄우기
          final quiz = await showModalBottomSheet(
            context: context,
            builder: (context) => QuizBottomSheetWidget(),
          );
          setState(() {
            quizItems.add(quiz);
          });
        },
      ),
    );
  }
}
