import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/util/message.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/vm/database_handler_customer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class PColor {
  static const Color appBarBackgroundColor = Colors.black;
  static const Color appBarForegroundColor = Colors.white;
  static const Color buttonPrimary = Colors.blue;
  static const Color buttonTextColor = Colors.white;
}

class Message {
  void snackBar(String title, String message) {
    Get.snackbar(title, message);
  }

  void showDialog(
    String title,
    String message, {
    VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      onConfirm: onConfirm,
    );
  }
}

class _SignUpPageState extends State<SignUpPage> {
  bool all = false;
  bool fourteen = false;
  bool use = false;
  bool collect = false;
  bool marketing = false;

  late TextEditingController emailcontroller;
  late TextEditingController pwcontroller;
  late TextEditingController pwcheckcontroller;
  late TextEditingController namecontroller;
  late TextEditingController phonecontroller;

  late DatabaseHandlerCustomer customerHandler;

  bool isButtonEnabled = false;

  final Message msg = Message();

  @override
  void initState() {
    super.initState();
    customerHandler = DatabaseHandlerCustomer();

    emailcontroller = TextEditingController()
      ..addListener(_updateButtonState);
    pwcontroller = TextEditingController()
      ..addListener(_updateButtonState);
    pwcheckcontroller = TextEditingController()
      ..addListener(_updateButtonState);
    namecontroller = TextEditingController()
      ..addListener(_updateButtonState);
    phonecontroller = TextEditingController()
      ..addListener(_updateButtonState);
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
    pwcheckcontroller.dispose();
    namecontroller.dispose();
    phonecontroller.dispose();
    super.dispose();
  }

  _updateAllCheck() {
    all = fourteen && use && collect && marketing;
    _updateButtonState();
  }

  _updateButtonState() {
    bool fieldsFilled =
        emailcontroller.text.trim().isNotEmpty &&
        pwcontroller.text.trim().isNotEmpty &&
        pwcheckcontroller.text.trim().isNotEmpty &&
        namecontroller.text.trim().isNotEmpty &&
        phonecontroller.text.trim().isNotEmpty;
    bool requiredAgreementsChecked =
        fourteen && use && collect;

    isButtonEnabled =
        fieldsFilled && requiredAgreementsChecked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              _buildInputField(
                '이메일 주소',
                emailcontroller,
                TextInputType.emailAddress,
              ),
              _buildInputField(
                '비밀번호',
                pwcontroller,
                TextInputType.text,
                isObscure: true,
              ),
              _buildInputField(
                '비밀번호 확인',
                pwcheckcontroller,
                TextInputType.text,
                isObscure: true,
              ),
              _buildInputField(
                '이름',
                namecontroller,
                TextInputType.text,
              ),
              _buildInputField(
                '전화번호',
                phonecontroller,
                TextInputType.phone,
              ),

              SizedBox(height: 30),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              SizedBox(height: 10),
              Text(
                '약관 동의',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColor.appBarForegroundColor,
                ),
              ),
              SizedBox(height: 10),

              _buildAgreementRow(
                text: '모두 동의합니다',
                value: all,
                onChanged: _toggleAll,
                isAll: true,
              ),
              Divider(color: Colors.grey.shade200),

              _buildAgreementRow(
                text: '[필수] 만 14세 이상입니다',
                value: fourteen,
                onChanged: (value) {
                  setState(() {
                    fourteen = value!;
                    _updateAllCheck();
                  });
                },
              ),

              _buildAgreementRow(
                text: '[필수] 이용 약관 동의',
                value: use,
                onChanged: (value) {
                  setState(() {
                    use = value!;
                    _updateAllCheck();
                  });
                },
              ),

              _buildAgreementRow(
                text: '[필수] 개인정보 수집 및 이용 동의',
                value: collect,
                onChanged: (value) {
                  setState(() {
                    collect = value!;
                    _updateAllCheck();
                  });
                },
              ),

              _buildAgreementRow(
                text: '[선택] 마케팅 수신 동의',
                value: marketing,
                onChanged: (value) {
                  setState(() {
                    marketing = value!;
                    _updateAllCheck();
                  });
                },
              ),

              SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: isButtonEnabled
                        ? PColor.buttonPrimary
                        : PColor.buttonPrimary.withOpacity(
                            0.5,
                          ),
                    foregroundColor: PColor.buttonTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  onPressed: isButtonEnabled
                      ? _signUp
                      : null,
                  child: Text(
                    '가입하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType, {
    bool isObscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isObscure,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: PColor.buttonPrimary,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementRow({
    required String text,
    required bool value,
    required ValueChanged<bool?> onChanged,
    bool isAll = false,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: PColor.buttonPrimary,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: isAll ? 16 : 14,
            fontWeight: isAll
                ? FontWeight.bold
                : FontWeight.normal,
            color: isAll
                ? PColor.appBarForegroundColor
                : Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  _toggleAll(bool? value) {
    if (value != null) {
      setState(() {
        all = value;
        fourteen = value;
        use = value;
        collect = value;
        marketing = value;
        _updateButtonState();
      });
    }
  }

  _signUp() async {
    if (emailcontroller.text.isEmpty ||
        pwcontroller.text.isEmpty ||
        pwcheckcontroller.text.isEmpty ||
        namecontroller.text.isEmpty ||
        phonecontroller.text.isEmpty) {
      msg.snackBar('필수 입력', '모든 입력란을 채워주세요.');
      return;
    }

    if (!GetUtils.isEmail(emailcontroller.text.trim())) {
      msg.snackBar('이메일 형식 오류', '유효한 이메일 주소를 입력해주세요.');
      return;
    }

    final exists = await customerHandler.checkEmailExists(
      emailcontroller.text.trim(),
    );
    if (exists) {
      msg.showDialog('가입 실패', '이미 존재하는 이메일 주소입니다.');
      return;
    }

    if (pwcontroller.text.trim() !=
        pwcheckcontroller.text.trim()) {
      msg.snackBar('비밀번호 오류', '비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      return;
    }

    if (!fourteen || !use || !collect) {
      msg.showDialog(
        '필수 약관 동의 필요',
        '만 14세 이상, 이용 약관, 개인정보 수집 및 이용 동의는 필수입니다.',
      );
      return;
    }

    Customer customer = Customer(
      customer_email: emailcontroller.text.trim(),
      customer_pw: pwcontroller.text.trim(),
      customer_name: namecontroller.text.trim(),
      customer_phone: phonecontroller.text.trim(),
      customer_address: '',
      customer_image: null,
      customer_lat: null,
      customer_lng: null,
    );

    final result = await customerHandler.insertCustomer(
      customer,
    );

    if (result > 0) {
      msg.showDialog(
        '회원가입 완료',
        '${namecontroller.text}님, 회원가입을 축하드립니다! 로그인 페이지로 이동합니다.',
        onConfirm: () {
          Get.back();

          Get.back();
        },
      );
    } else {
      msg.showDialog(
        '오류 발생',
        '회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.',
      );
    }
  }
}
