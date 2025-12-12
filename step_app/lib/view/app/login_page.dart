import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/forgot_email_page.dart';
import 'package:step_app/view/app/forgot_password_page.dart';
import 'package:step_app/view/app/home.dart';
import 'package:step_app/view/app/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailcontroller;
  late TextEditingController pwcontroller;

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'STEP',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'SMART TERMINAL FOR EVERY PURCHASE',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: '이메일주소',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: pwcontroller,
                //obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                checkLogin();
              },
              child: Text('로그인'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(SignUpPage());
                  },
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                Text('   |   '),
                TextButton(
                  onPressed: () {
                    Get.to((ForgotEmailPage));
                  },
                  child: Text('이메일 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                Text('   |   '),
                TextButton(
                  onPressed: () {
                    Get.to(ForgotPasswordPage());
                  },
                  child: Text('비밀번호 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('이용약관'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('개인정보 처리방침'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } //function

  checkLogin() {
    if (emailcontroller.text.trim().isEmpty ||
        pwcontroller.text.trim().isEmpty) {
      Get.snackbar(
        "로그인 실패",
        "ID와 Password를 입력해주세요.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    } else {
      if (emailcontroller.text.trim() == 'root@naver.com' &&
          pwcontroller.text.trim() == "1234") {
        Get.defaultDialog(
          title: '로그인 성공',
          middleText: '환영합니다.',
          barrierDismissible: false,
          actions: [
            TextButton(
              onPressed: () => Get.to(Home()),
              child: Text("확인"),
            ),
          ],
        );
      } else {
        Get.snackbar(
          "로그인 실패",
          "ID와 Password를 확인해주세요.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      }
    }
  }
}
