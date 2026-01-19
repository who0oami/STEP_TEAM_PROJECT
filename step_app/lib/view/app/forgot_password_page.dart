import 'package:flutter/material.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/vm/database_handler_customer.dart';

void showSimpleSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

Future<void> showSimpleDialog(BuildContext context, String title, String content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController controller;
  bool isButtonEnabled = false;
  late DatabaseHandlerCustomer customerHandler;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    customerHandler = DatabaseHandlerCustomer();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      String email = controller.text.trim();
  
      isButtonEnabled = email.contains('@') && email.contains('.');
    });
  }


  void _findPassword() async {
    final email = controller.text.trim();

    bool userExists = await customerHandler.findUserByEmail(email);

    if (userExists) {
      await showSimpleDialog(
        context,
        '임시 비밀번호 발송',
        '등록된 이메일 주소로 임시 비밀번호를 발송했습니다.\n로그인 후 비밀번호를 꼭 변경해주세요.',
      );
      Navigator.of(context).pop(); 
    } else {
      showSimpleSnackBar(context, '해당 이메일로 가입된 정보가 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('비밀번호 찾기', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
         SizedBox(height: 40),
           Text(
              '비밀번호 찾기',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 10),
            Text('가입하신 이메일 주소를 입력하시면\n임시 비밀번호를 보내드립니다.'),
           SizedBox(height: 40),
            
           Text('이메일 주소', style: TextStyle(fontWeight: FontWeight.bold)),
           SizedBox(height: 10),
            TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => _updateButtonState(), 
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'example@step.com',
                isDense: true,
              ),
            ),
             SizedBox(height: 30),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled 
                    ? PColor.buttonPrimary 
                    : Colors.grey.shade300,
                foregroundColor: isButtonEnabled 
                    ? PColor.buttonTextColor 
                    : Colors.grey.shade600,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: isButtonEnabled ? _findPassword : null,
              child:  Text(
                '임시 비밀번호 발송하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
