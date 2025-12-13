import 'package:flutter/material.dart';
import 'package:step_app/vm/database_handler_customer.dart';

class ForgotEmailPage extends StatefulWidget {
  const ForgotEmailPage({super.key});

  @override
  State<ForgotEmailPage> createState() =>
      _ForgotEmailPageState();
}

class _ForgotEmailPageState extends State<ForgotEmailPage> {
  late TextEditingController controller;
  late DatabaseHandlerCustomer customerHandler;
  //bool isButtonEnabled = false;

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

  /*updateButtonState(){
  isButtonEnabled = controller.text.trim().length>=10;
  setState(() {});
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: PColor.appBarBackgroundColor,
      appBar: AppBar(
        title: Text('이메일 찾기  |  STEP'),
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
                keyboardType: TextInputType.phone,
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
              //isButtonEnabled ? _findEmail : null,,
              child: Text('이메일 주소 발송하기'),
            ),
          ],
        ),
      ),
    );
  } //function

  /*
 _findEmail() async {
    String phone = controller.text.trim().replaceAll('-', ''); 

    if (phone.length < 10) {
      msg.snackBar('필수 입력 오류', '전화번호 10자리 이상을 입력해주세요.');
      return;
    }

    String? foundEmail = await customerHandler.findEmailByPhone(phone);

    if (foundEmail != null) {
 
      msg.showDialog(
        '이메일 발송 완료',
        '등록된 이메일 주소 ${foundEmail}로 발송되었습니다.',
      );
    } else {

      msg.showDialog(
        '정보 없음',
        '입력하신 전화번호로 등록된 계정을 찾을 수 없습니다.',
      );
    }
  }*/

  //이메일(ID) 조회
  //SELECT customer_email FROM customer
  //WHERE customer_phone = ?
}
