import 'package:flutter/material.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/util/scolor.dart';

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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {
  late TextEditingController controller;
  bool isButtonEnabled = false;
  final DatabaseHandlerCustomer customerHandler =
      DatabaseHandlerCustomer();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    controller.removeListener(_updateButtonState);
    controller.dispose();
    super.dispose();
  }

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  _updateButtonState() {
    final bool isEmailValid = _emailRegExp.hasMatch(
      controller.text.trim(),
    );
    if (isButtonEnabled != isEmailValid) {
      setState(() {
        isButtonEnabled = isEmailValid;
      });
    }
  }

  _findPassword() async {
    final email = controller.text.trim();
    if (!isButtonEnabled) {
      showSimpleSnackBar(context, '유효한 이메일 주소를 입력해주세요.');
      return;
    }

    await SeedCustomer.insertSeed();

    bool userExists = await customerHandler.findUserByEmail(
      email,
    );

    if (userExists) {
      await showSimpleDialog(
        context,
        '임시 비밀번호 발송 완료',
        '휴대폰으로 임시 비밀번호가 발송되었습니다. 로그인 후 비밀번호를 변경해주세요.',
      );
    } else {
      await showSimpleDialog(
        context,
        '정보 없음',
        '입력하신 이메일 주소로 등록된 계정을 찾을 수 없습니다.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('비밀번호 찾기 | STEP'),
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                '비밀번호 찾기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text('본인 인증 완료 후, 휴대폰으로 임시 비밀번호를 발송해드립니다.'),
              Text('비밀번호를 확인할 이메일 주소를 입력해주세요.'),
              SizedBox(height: 40),
              Text(
                '이메일 주소',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'step@step.com',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PColor.buttonPrimary,
                  foregroundColor: PColor.buttonTextColor,
                  minimumSize: Size(double.infinity, 50),
                ),

                onPressed: isButtonEnabled
                    ? _findPassword
                    : null,
                child: Text(
                  '임시 비밀번호 발송하기',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeedCustomer {
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = DatabaseHandlerCustomer();

    final List<Customer> customers = [
      Customer(
        customer_name: '황만수',
        customer_phone: '010-4324-3443',
        customer_pw: 'password123',
        customer_email: 'hong@naver.com',
        customer_address: '서울시 강남구',
        customer_image: null,
        customer_lat: 37.4979,
        customer_lng: 127.0276,
      ),
      Customer(
        customer_name: '김나라',
        customer_phone: '010-9876-5432',
        customer_pw: '1234abcd',
        customer_email: 'kim@test.com',
        customer_address: '서울시 마포구 홍익로',
        customer_image: null,
        customer_lat: 37.2343,
        customer_lng: 127.0090,
      ),
    ];

    for (final c in customers) {
      await handler.insertCustomer(c);
    }

    _inserted = true;
  }
}

// ⚠️ 필수 가정: 이 클래스는 데이터베이스 연동을 위한 기본적인 틀입니다.
// 실제 SQLite/Sqflite 등을 사용한다면 이 클래스 내부 구현이 필요합니다.
class DatabaseHandlerCustomer {
  final List<Customer> _mockCustomers = [
    Customer(
      customer_email: 'hong@naver.com',
      customer_name: '',
      customer_phone: '',
      customer_pw: '',
      customer_address: '',
    ),
    Customer(
      customer_email: 'kim@test.com',
      customer_name: '',
      customer_phone: '',
      customer_pw: '',
      customer_address: '',
    ),
  ];
  Future<int> insertCustomer(Customer customer) async {
    if (!_mockCustomers.any(
      (c) => c.customer_email == customer.customer_email,
    )) {
      _mockCustomers.add(customer);
    }
    return 1;
  }

  Future<bool> findUserByEmail(String email) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _mockCustomers.any(
      (c) => c.customer_email == email,
    );
  }

  Future<dynamic> hasCustomer(
    String email,
    String password,
  ) async {}

  Future<dynamic> checkEmailExists(String trim) async {}

  Future<String?> findEmailByPhone(String phone) async {}
}
