import 'package:flutter/material.dart';

class ForgotEmailPage extends StatefulWidget {
  const ForgotEmailPage({super.key});

  @override
  State<ForgotEmailPage> createState() =>
      _ForgotEmailPageState();
}

class _ForgotEmailPageState extends State<ForgotEmailPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('이메일 찾기  |  STEP'),
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
                '   이메일 찾기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('본인 인증 완료 후, 휴대폰으로 이메일를 발송해드립니다.'),
            Text('이메일을 확인할 전화번호를 입력해주세요.'),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('전화번호', style: TextStyle()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '010-1234-5678',
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
              child: Text('이메일 주소 발송하기'),
            ),
          ],
        ),
      ),
    );
  }
}
