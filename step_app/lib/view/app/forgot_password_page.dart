import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as msg;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {
  late TextEditingController controller;
  //bool isButtonEnabled = false;
  //final Message msg = Message();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /*_updateButtonState() {
      isButtonEnabled = GetUtils.isEmail(controller.text.trim());
    setState(() {});
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('비밀번호 찾기  |  STEP'),
        //backgroundColor: PColor.appBarBackgroundColor,
        //foregroundColor: PColor.appBarForegroundColor,
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
                '   비밀번호 찾기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('본인 인증 완료 후, 휴대폰으로 임시 비밀번호를 발송해드립니다.'),
            Text('비밀번호를 확인할 이메일 주소를 입력해주세요.'),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('이메일 주소', style: TextStyle()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: 'step@step.com',
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
              //isButtonEnabled ? _findPassword : null,
              child: Text('임시 비밀번호 발송하기'),
            ),
          ],
        ),
      ),
    );
  } //function

  /* _findPassword() async {
    final email = controller.text.trim();
    if (!isButtonEnabled) {
      msg.snackBar('형식 오류', '유효한 이메일 주소를 입력해주세요.');
      return;
    }
    bool userExists = await customerHandler.findUserByEmail(email);
    if (userExists) {
      msg.showDialog(
        '임시 비밀번호 발송 완료',
        '휴대폰으로 임시 비밀번호가 발송되었습니다. 로그인 후 비밀번호를 변경해주세요.',
      );
    } else {
      msg.showDialog(
        '정보 없음',
        '입력하신 이메일 주소로 등록된 계정을 찾을 수 없습니다.',
      );
    }
  }*/

  /*
//사용자 존재 확인	
SELECT customer_id FROM customer 
WHERE customer_email = ?

//비밀번호 재설정
//UPDATE customer SET customer_pw = ? 
//WHERE customer_email = ?
*/
}
