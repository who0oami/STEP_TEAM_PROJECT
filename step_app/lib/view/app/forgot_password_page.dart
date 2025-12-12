import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('비밀번호 찾기  |  STEP'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                '   비밀번호 찾기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('본인 인증 완료 후, 휴대폰으로 임시 비밀번호를 발송해드립니다.'),
            Text('비밀번호를 확인할 이메일 주소를 입력해주세요.'),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('이메일 주소', style: TextStyle()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: 'step@step.com',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Text('임시 비밀번호 발송하기'),
            ),
          ],
        ),
      ),
    );
  }
}
