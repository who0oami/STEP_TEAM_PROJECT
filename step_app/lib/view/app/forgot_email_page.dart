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
            child:  Text('확인'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

class ForgotEmailPage extends StatefulWidget {
  const ForgotEmailPage({super.key});

  @override
  State<ForgotEmailPage> createState() => _ForgotEmailPageState();
}

class _ForgotEmailPageState extends State<ForgotEmailPage> {
  late TextEditingController controller;
  late DatabaseHandlerCustomer customerHandler;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    customerHandler = DatabaseHandlerCustomer();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  
  void _updateButtonState() {
    setState(() {
    
      String phone = controller.text.trim().replaceAll('-', '');
      isButtonEnabled = phone.length >= 10;
    });
  }

 
  void _findEmail() async {
    String phone = controller.text.trim().replaceAll('-', '');


    String? foundEmail = await customerHandler.findEmailByPhone(phone);

    if (foundEmail != null) {
      await showSimpleDialog(
        context,
        '이메일 찾기 성공',
        '등록된 이메일 주소는 ${_maskEmail(foundEmail)} 입니다.',
      );
      Navigator.of(context).pop(); 
    } else {
      showSimpleSnackBar(context, '등록된 정보가 없습니다.');
    }
  }

  String _maskEmail(String email) {
    if (!email.contains('@')) return email;
    List<String> parts = email.split('@');
    String id = parts[0];
    String domain = parts[1];

    if (id.length > 3) {
      return "${id.substring(0, 3)}****@$domain";
    } else {
      return "${id.substring(0, 1)}**@$domain";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        title:  Text('이메일 찾기', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
             Text(
              '이메일 찾기',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
           Text('가입 시 등록한 전화번호를 입력해주세요.'),
             SizedBox(height: 40),
            
          Text('전화번호', style: TextStyle(fontWeight: FontWeight.bold)),
           SizedBox(height: 10),
            TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              onChanged: (_) => _updateButtonState(), 
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                hintText: '01012345678',
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
              onPressed: isButtonEnabled ? _findEmail : null,
              child:  Text('이메일 찾기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
