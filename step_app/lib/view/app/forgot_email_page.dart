import 'package:flutter/material.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/vm/database_handler_customer.dart';
//import 'package:flutter/material.dart' as msg;

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
    controller = TextEditingController();
    customerHandler = DatabaseHandlerCustomer();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  updateButtonState() {
    isButtonEnabled = controller.text.trim().length >= 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.appBarBackgroundColor,

      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,

        title: Text(
          '이메일 찾기  |  STEP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '   이메일 찾기',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  updateButtonState();
                },
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '010-1234-5678',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PColor.buttonPrimary,
                foregroundColor: PColor.buttonTextColor,
              ),
              onPressed: isButtonEnabled ? _findEmail : null,
              child: Text('이메일 주소 발송하기'),
            ),
          ],
        ),
      ),
    );
  } //function

  _findEmail() async {
    String phone = controller.text.trim().replaceAll('-', '');

    if (phone.length < 10) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('전화번호 10자리 이상을 입력해주세요.')));
      return;
    }

    String? foundEmail = await customerHandler.findEmailByPhone(phone);

    if (foundEmail != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('이메일 발송 완료'),
          content: Text('등록된 이메일 주소 $foundEmail 로 발송되었습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('이메일 발송 실패'),
          content: Text('등록된 이메일 주소가 없습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  //이메일(ID) 조회
  //SELECT customer_email FROM customer
  //WHERE customer_phone = ?
}
