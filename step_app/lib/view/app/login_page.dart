import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/forgot_email_page.dart';
import 'package:step_app/view/app/home.dart';
import 'package:step_app/view/app/sign_up_page.dart';
import 'package:step_app/vm/database_handler_customer.dart';
import 'package:step_app/vm/seeds/seed_customer.dart';

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

    SeedCustomer.insertSeed();

    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    customerHandler = DatabaseHandlerCustomer();

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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '이메일주소',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: TextField(
                  controller: pwcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        checkLogin();
                      }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(SignUpPage());
                    },
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
                    onPressed: () {
                      Get.to(ForgotEmailPage());
                    },
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
                    onPressed: () {
                      //Get.to(ForgotPasswordPage());
                    },
                    child: Text('비밀번호 찾기'),
                    style: TextButton.styleFrom(
                      foregroundColor: PColor.buttonPrimary,
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
  } //function

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

    final result = await customerHandler.hasCustomer(
      email,
      password,
    );

    if (result == null) {
      Get.snackbar(
        "로그인 실패",
        "ID와 Password를 확인해주세요.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.defaultDialog(
        title: '로그인 성공',
        middleText: '${result.customer_name}님 환영합니다.',
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () => Get.offAll(Home()),
            child: Text("확인"),
          ),
        ],
      );
    }
  }
}
