import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/forgot_email_page.dart';
import 'package:step_app/view/app/forgot_password_page.dart';
import 'package:step_app/view/app/home.dart';
import 'package:step_app/view/app/sign_up_page.dart';
import 'package:step_app/vm/database_handler_customer.dart';
import 'package:step_app/vm/seeds/seed_customer.dart' hide SeedCustomer;

class PColor {
  static const Color buttonPrimary = Color(0xFF1E88E5);
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
  bool _isObscured = true;      

  @override
  void initState() {
    super.initState();
    SeedCustomer.insertSeed();
    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    customerHandler = DatabaseHandlerCustomer();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = emailcontroller.text.trim().isNotEmpty &&
          pwcontroller.text.trim().isNotEmpty;
    });
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
      backgroundColor: const Color(0xFFFAF8F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'STEP',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
               Text(
                'SMART TERMINAL FOR EVERY PURCHASE',
                style: TextStyle(fontSize: 15, color: Color(0xFF141414)),
              ),
              SizedBox(height: 30),
              
        
              TextField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => _updateButtonState(), 
                decoration: const InputDecoration(
                  labelText: '이메일주소',
                  border: OutlineInputBorder(),
                ),
              ),
               SizedBox(height: 10),

              //<<<<<<<<<<<<<<<<<<<<<<<
              TextField(
                controller: pwcontroller,
                obscureText: _isObscured, 
                onChanged: (_) => _updateButtonState(),
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                    
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                ),
              ),
               SizedBox(height: 20),

        
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.85, 50),
                  backgroundColor: isButtonEnabled
                      ? PColor.buttonPrimary
                      : PColor.buttonPrimary.withOpacity(0.5),
                  foregroundColor: PColor.buttonTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: isButtonEnabled ? () => checkLogin() : null,
                child: Text(
                  '로그인',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
               SizedBox(height: 10),

        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _linkButton('회원가입', () => Get.to(const SignUpPage())),
                  _divider(),
                  _linkButton('이메일 찾기', () => Get.to(const ForgotEmailPage())),
                  _divider(),
                  _linkButton('비밀번호 찾기', () => Get.to(const ForgotPasswordPage())),
                ],
              ),
              SizedBox(height: 100),
              
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _linkButton('이용약관', () {}),
                  _linkButton('개인정보 처리방침', () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linkButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: PColor.appBarBackgroundColor),
      child: Text(text),
    );
  }


  Widget _divider() => Text('|', style: TextStyle(color: Colors.grey));

 
  void checkLogin() async {
    FocusScope.of(context).unfocus();

    final email = emailcontroller.text.trim();
    final password = pwcontroller.text.trim();

    final result = await customerHandler.hasCustomer(email, password);

    if (result == null) {
      Get.snackbar("로그인 실패", "ID와 Password를 확인해주세요.",
          snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 2));
    } else {
      Get.defaultDialog(
        title: '로그인 성공',
        middleText: '${result.customer_name}님 환영합니다.',
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () => Get.offAll(const Home()),
            child: Text("확인"),
          ),
        ],
      );
    }
  }
}
