import 'package:flutter/material.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/vm/database_handler_customer.dart';

void showSimpleSnackBar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));
}

Future<void> showSimpleDialog(
  BuildContext context,
  String title,
  String content,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(content)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class ForgotEmailPage extends StatefulWidget {
  const ForgotEmailPage({super.key});

  @override
  State<ForgotEmailPage> createState() =>
      _ForgotEmailPageState();
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
    controller.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    controller.removeListener(_updateButtonState);
    controller.dispose();
    super.dispose();
  }

  _updateButtonState() {
    final rawPhone = controller.text.trim().replaceAll(
      '-',
      '',
    );
    final bool isPhoneValid = rawPhone.length >= 10;

    if (isButtonEnabled != isPhoneValid) {
      setState(() {
        isButtonEnabled = isPhoneValid;
      });
    }
  }

  _findEmail() async {
    String phone = controller.text.trim().replaceAll(
      '-',
      '',
    );

    if (phone.length < 10) {
      showSimpleSnackBar(context, '전화번호 10자리 이상을 입력해주세요.');
      return;
    }

    String? foundEmail = await customerHandler
        .findEmailByPhone(phone);

    if (foundEmail != null) {
      await showSimpleDialog(
        context,
        '이메일 발송 완료',
        '등록된 이메일 주소 **${_maskEmail(foundEmail)}** 로 이메일 발송이 완료되었습니다.\n로그인 페이지로 이동해주세요.',
      );

      Navigator.of(context).pop();
    } else {
      await showSimpleDialog(
        context,
        '정보 없음',
        '입력하신 전화번호로 등록된 계정을 찾을 수 없습니다.',
      );
    }
  }

  String _maskEmail(String email) {
    if (email.isEmpty) return '';
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final localPart = parts[0];
    final domainPart = parts[1];

    if (localPart.length <= 4) {
      final visibleLength = (localPart.length / 2).ceil();
      final masked =
          '*' * (localPart.length - visibleLength);
      return localPart.substring(0, visibleLength) +
          masked +
          '@' +
          domainPart;
    } else {
      return localPart.substring(0, 4) +
          '****@' +
          domainPart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,

        title: Text(
          '이메일 찾기 | STEP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              '이메일 찾기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('본인 인증 완료 후, 휴대폰으로 등록된 이메일을 발송해드립니다.'),
            Text('이메일을 찾을 전화번호를 입력해주세요.'),
            SizedBox(height: 40),
            Text(
              '전화번호',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                _updateButtonState();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '010-1234-5678',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled
                    ? PColor.buttonPrimary
                    : PColor.buttonPrimary.withOpacity(
                        0.5,
                      ), // 버튼 활성화/비활성화 시 색상 변경
                foregroundColor: PColor.buttonTextColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: isButtonEnabled
                  ? _findEmail
                  : null,
              child: Text(
                '이메일 주소 발송하기',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
class DatabaseHandlerCustomer {
  final List<Customer> _mockCustomers = [
    // 기존 데이터
    Customer(
      customer_email: 'hong@naver.com',
      customer_name: '황만수',
      customer_phone: '01043243443', // 하이픈 없이 저장되어야 함
      customer_pw: 'password123',
      customer_address: '서울시 강남구',
    ),
    Customer(
      customer_email: 'kim@test.com',
      customer_name: '김나라',
      customer_phone: '01098765432', // 하이픈 없이 저장되어야 함
      customer_pw: '1234abcd',
      customer_address: '서울시 마포구 홍익로',
    ),
    
  ];



  Future<String?> findEmailByPhone(String phone) async {
    
    await Future.delayed(Duration(milliseconds: 500));
    

    final customer = _mockCustomers.firstWhereOrNull(
      (c) => c.customer_phone == phone,
    );
    

    /*
    Customer? foundCustomer;
    for (var c in _mockCustomers) {
        if (c.customer_phone == phone) {
            foundCustomer = c;
            break;
        }
    }
    return foundCustomer?.customer_email;
    */
    
    return customer?.customer_email; 
  }
}
   */
}
