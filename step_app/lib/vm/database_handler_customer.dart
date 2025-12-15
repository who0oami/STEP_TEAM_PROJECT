import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/app/forgot_email_page.dart';
import 'package:step_app/view/app/forgot_password_page.dart';
import 'package:step_app/view/app/home.dart';
import 'package:step_app/view/app/sign_up_page.dart'
    hide PColor;

// ⭐️ DatabaseHandlerCustomer는 이 파일에서 import 되었다고 가정합니다.
import 'package:step_app/vm/database_handler_customer.dart';
// ⭐️ [수정] SeedCustomer 클래스 import 추가 (데이터 삽입을 위해 필수)
import 'package:step_app/vm/seeds/seed_customer.dart'
    hide SeedCustomer;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailcontroller;
  late TextEditingController pwcontroller;

  late DatabaseHandlerCustomer customerHandler;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // ⭐️ [필수] DB 초기 데이터 삽입
    SeedCustomer.insertSeed();

    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    customerHandler =
        DatabaseHandlerCustomer(); // DB 핸들러 초기화

    emailcontroller.addListener(_updateButtonState);
    pwcontroller.addListener(_updateButtonState);
  }

  _updateButtonState() {
    isButtonEnabled =
        emailcontroller.text.trim().isNotEmpty &&
        pwcontroller.text.trim().isNotEmpty;
    setState(() {});
  }

  @override
  void dispose() {
    emailcontroller.removeListener(_updateButtonState);
    pwcontroller.removeListener(_updateButtonState);

    emailcontroller.dispose();
    pwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.appBarBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'STEP',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: PColor.appBarForegroundColor,
                ),
              ),
              Text(
                'SMART TERMINAL FOR EVERY PURCHASE',
                style: TextStyle(
                  fontSize: 15,
                  color: PColor.appBarForegroundColor,
                ),
              ),
              SizedBox(height: 30),

              // 이메일 입력
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: PColor.appBarForegroundColor,
                  ), // 텍스트 색상
                  decoration: InputDecoration(
                    labelText: '이메일주소',
                    labelStyle: TextStyle(
                      color: PColor.appBarForegroundColor,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              // 비밀번호 입력
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: TextField(
                  controller: pwcontroller,
                  obscureText: true,
                  style: TextStyle(
                    color: PColor.appBarForegroundColor,
                  ), // 텍스트 색상
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(
                      color: PColor.appBarForegroundColor,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // 로그인 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    MediaQuery.of(context).size.width *
                        0.85,
                    50,
                  ),
                  backgroundColor: isButtonEnabled
                      ? PColor.buttonPrimary
                      : PColor.buttonPrimary.withOpacity(
                          0.5,
                        ),
                  foregroundColor: PColor.buttonTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: isButtonEnabled
                    ? checkLogin
                    : null,
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // 하단 메뉴 (회원가입, 이메일/비밀번호 찾기)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () =>
                        Get.to(() => SignUpPage()),
                    child: Text('회원가입'),
                    style: TextButton.styleFrom(
                      foregroundColor: PColor.buttonPrimary,
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.to(() => ForgotEmailPage()),
                    child: Text('이메일 찾기'),
                    style: TextButton.styleFrom(
                      foregroundColor: PColor.buttonPrimary,
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.to(() => ForgotPasswordPage()),
                    child: Text('비밀번호 찾기'),
                    style: TextButton.styleFrom(
                      foregroundColor: PColor.buttonPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),

              // 하단 이용약관
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('이용약관'),
                    style: TextButton.styleFrom(
                      foregroundColor: PColor.buttonPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('개인정보 처리방침'),
                    style: TextButton.styleFrom(
                      foregroundColor: PColor.buttonPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    final email = emailcontroller.text.trim();
    final password = pwcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "로그인 실패",
        "ID와 Password를 입력해주세요.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
      return;
    }

    // ⭐️ DatabaseHandlerCustomer.hasCustomer 호출
    final result = await customerHandler.hasCustomer(
      email,
      password,
    );

    if (result == null) {
      // 로그인 실패 시
      Get.snackbar(
        "로그인 실패",
        "ID와 Password를 확인해주세요.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    } else {
      // 로그인 성공 시
      Get.defaultDialog(
        title: '로그인 성공',
        middleText: '${result.customer_name}님 환영합니다.',
        barrierDismissible: false,
        actions: [
          TextButton(
            // ⭐️ [수정] Get.offAll()을 함수 형태로 호출합니다.
            onPressed: () => Get.offAll(() => Home()),
            child: Text("확인"),
          ),
        ],
      );
    }
  }
}
