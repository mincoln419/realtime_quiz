import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_quiz_app/quiz_app/quiz_app.dart';

import '../main.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController pinTec = TextEditingController();
  TextEditingController nickNameTec = TextEditingController();

  String? uid;

  final codeItems = [];

  singInAnonymously() {
    auth.signInAnonymously().then((value) {
      uid = value.user?.uid;
    });
  }

  Future<bool> findPinCode(String code) async {
    final quizRef = database?.ref('quiz');
    final result = await quizRef?.get();

    codeItems.clear();
    for (var element in result!.children) {
      final data =
          jsonDecode(jsonEncode(element.value)) as Map<String, dynamic>;

      DateTime nowDateTime = DateTime.now();
      DateTime generateTime = DateTime.parse(data['generateTime']);
      if (nowDateTime.difference(generateTime).inDays < 1) {
        if (data.containsValue(code)) {
          codeItems.add(data['quizDetailRef']);
        }
      }
    }

    return codeItems.isNotEmpty;
  }

  @override
  void initState() {
    singInAnonymously();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("입장 코드 입력"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "입장 코드 입력",
                labelText: "Pin Code",
              ),
              controller: pinTec,
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '닉네임 입력',
                labelText: '플레이어 명칭',
              ),
              controller: nickNameTec,
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              height: 72,
              color: Colors.indigo,
              child: Text(
                '입장하기',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                final pinCode = pinTec.text;
                if (pinCode.isEmpty) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("핀코드를 입력해주세요"),
                      ),
                    );
                  }
                  return;
                }
                if (nickNameTec.text.isEmpty) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("닉네임을 입력해주세요"),
                      ),
                    );
                  }
                  return;
                }
                final isExistCode = await findPinCode(pinCode.trim());
                if (isExistCode) {
                  if (context.mounted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizApp(
                            quizRef: codeItems.first,
                            name: nickNameTec.text,
                            uid: uid ?? "Unknown User",
                            code: pinCode)));
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("code Not Exist")));
                  }
                }
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
