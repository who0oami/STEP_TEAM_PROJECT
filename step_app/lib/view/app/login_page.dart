import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/forgot_email_page.dart';
import 'package:step_app/view/app/forgot_password_page.dart';
import 'package:step_app/view/app/home.dart';
import 'package:step_app/view/app/sign_up_page.dart';
import 'package:step_app/vm/database_handler_customer.dart';
import 'package:step_app/vm/seeds/seed_customer.dart'
    hide SeedCustomer;

class PColor {
  static const Color buttonPrimary = Color(
    0xFF1E88E5,
  ); // Blue
  static const Color buttonTextColor = Colors.white;
  static const Color appBarBackgroundColor = Colors.black;
}

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

    // 초기 데이터베이스 시딩 (로그인 테스트 데이터 삽입)
    SeedCustomer.insertSeed();

    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    customerHandler = DatabaseHandlerCustomer();

    emailcontroller.addListener(_updateButtonState);
    pwcontroller.addListener(_updateButtonState);
  }

  // 텍스트 필드 내용에 따라 로그인 버튼 활성화 상태 업데이트
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
    // Scaffold는 기본적으로 resizeToAvoidBottomInset: true 이므로,
    // 키보드가 올라올 때 화면이 자동으로 조정됩니다.
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        250,
        248,
        248,
      ),
      body: Center(
        // SingleChildScrollView를 사용하여 키보드가 올라올 때 콘텐츠를 스크롤 가능하게 합니다.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // STEP 로고
              const Text(
                'STEP',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // 슬로건
              const Text(
                'SMART TERMINAL FOR EVERY PURCHASE',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 20, 20, 20),
                ),
              ),
              const SizedBox(height: 30),

              // 이메일 입력 필드
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: '이메일주소',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // 비밀번호 입력 필드
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: TextField(
                  controller: pwcontroller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

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
                    ? () {
                        checkLogin(); // 로그인 시도
                      }
                    : null,
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 하단 링크: 회원가입, 이메일/비밀번호 찾기
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.to(SignUpPage()),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          PColor.appBarBackgroundColor,
                    ),
                    child: const Text('회원가입'),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.to(ForgotEmailPage()),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          PColor.appBarBackgroundColor,
                    ),
                    child: const Text('이메일 찾기'),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(
                        ForgotPasswordPage(),
                      ); // 비밀번호 찾기 페이지로 이동
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                          PColor.appBarBackgroundColor,
                    ),
                    child: const Text('비밀번호 찾기'),
                  ),
                ],
              ),

              const SizedBox(height: 150),

              // 약관 링크
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor:
                          PColor.appBarBackgroundColor,
                    ),
                    child: const Text('이용약관'),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor:
                          PColor.appBarBackgroundColor,
                    ),
                    child: const Text('개인정보 처리방침'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 로그인 유효성 검사 및 처리 함수
  checkLogin() async {
    // 1. 키보드 숨기기 (사용자 경험 개선)
    FocusScope.of(context).unfocus();

    final email = emailcontroller.text.trim();
    final password = pwcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "로그인 실패",
        "ID와 Password를 입력해주세요.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // 2. 데이터베이스를 통해 고객 정보 확인
    // DatabaseHandlerCustomer의 hasCustomer 메서드가 DB 연결 및 검증을 수행함
    final result = await customerHandler.hasCustomer(
      email,
      password,
    );

    if (result == null) {
      // 3. 로그인 실패 처리
      Get.snackbar(
        "로그인 실패",
        "ID와 Password를 확인해주세요.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      // 4. 로그인 성공 처리
      Get.defaultDialog(
        title: '로그인 성공',
        middleText: '${result.customer_name}님 환영합니다.',
        barrierDismissible: false,
        actions: [
          TextButton(
            // Get.offAll을 사용하여 이전 화면 기록을 모두 지우고 Home으로 이동
            onPressed: () => Get.offAll(const Home()),
            child: const Text("확인"),
          ),
        ],
      );
    }
  }
}
