import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/vm/database_handler_customer.dart';

class PColor {
  static const Color appBarBackgroundColor = Colors.black;
  static const Color appBarForegroundColor = Colors.white;
  static const Color buttonPrimary = Colors.blue;
  static const Color buttonTextColor = Colors.white;
}

class Message {
  void snackBar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  void showDialog(String title, String message, {VoidCallback? onConfirm}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      onConfirm: onConfirm,
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool all = false;
  bool fourteen = false;
  bool use = false;
  bool collect = false;
  bool marketing = false;
  bool isButtonEnabled = false; 
  
  late TextEditingController emailcontroller;
  late TextEditingController pwcontroller;
  late TextEditingController pwcheckcontroller;
  late TextEditingController namecontroller;
  late TextEditingController phonecontroller;

  late DatabaseHandlerCustomer customerHandler;
  final Message msg = Message();

  @override
  void initState() {
    super.initState();
    customerHandler = DatabaseHandlerCustomer();
    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    pwcheckcontroller = TextEditingController();
    namecontroller = TextEditingController();
    phonecontroller = TextEditingController();
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

  void _updateButtonState() {
    setState(() {

      bool fieldsFilled = emailcontroller.text.trim().isNotEmpty &&
          pwcontroller.text.trim().isNotEmpty &&
          pwcheckcontroller.text.trim().isNotEmpty &&
          namecontroller.text.trim().isNotEmpty &&
          phonecontroller.text.trim().isNotEmpty;


      bool requiredAgreementsChecked = fourteen && use && collect;

  
      isButtonEnabled = fieldsFilled && requiredAgreementsChecked;
    });
  }


  void _updateAllCheck() {
    all = fourteen && use && collect && marketing;
    _updateButtonState(); 
  }


  void _toggleAll(bool? value) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: 10),
            
            _buildInputField('이메일 주소', emailcontroller, TextInputType.emailAddress),
            _buildInputField('비밀번호', pwcontroller, TextInputType.text, isObscure: true),
            _buildInputField('비밀번호 확인', pwcheckcontroller, TextInputType.text, isObscure: true),
            _buildInputField('이름', namecontroller, TextInputType.text),
            _buildInputField('전화번호', phonecontroller, TextInputType.phone),

          SizedBox(height: 30),
           Text('약관 동의', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             SizedBox(height: 10),
            
            _buildAgreementRow(
              text: '전체 동의하기',
              value: all,
              isAll: true,
              onChanged: _toggleAll,
            ),
            const Divider(),
            _buildAgreementRow(
              text: '[필수] 만 14세 이상입니다',
              value: fourteen,
              onChanged: (value) {
                setState(() { fourteen = value ?? false; _updateAllCheck(); });
              },
            ),
            _buildAgreementRow(
              text: '[필수] 이용 약관 동의',
              value: use,
              onChanged: (value) {
                setState(() { use = value ?? false; _updateAllCheck(); });
              },
            ),
            _buildAgreementRow(
              text: '[필수] 개인정보 수집 및 이용 동의',
              value: collect,
              onChanged: (value) {
                setState(() { collect = value ?? false; _updateAllCheck(); });
              },
            ),
            _buildAgreementRow(
              text: '[선택] 마케팅 수신 동의',
              value: marketing,
              onChanged: (value) {
                setState(() { marketing = value ?? false; _updateAllCheck(); });
              },
            ),

      SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: isButtonEnabled ? PColor.buttonPrimary : Colors.grey.shade300,
                foregroundColor: isButtonEnabled ? PColor.buttonTextColor : Colors.grey.shade500,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
             
              onPressed: isButtonEnabled ? _signUp : null,
              child: const Text('가입하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, TextInputType keyboardType, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
            onChanged: (_) => _updateButtonState(),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementRow({required String text, required bool value, required ValueChanged<bool?> onChanged, bool isAll = false}) {
    return Row(
      children: [
        Checkbox(
          value: value, 
          onChanged: onChanged,
          activeColor: PColor.buttonPrimary,
        ),
        Text(text, style: TextStyle(
          fontSize: isAll ? 16 : 14, 
          fontWeight: isAll ? FontWeight.bold : FontWeight.normal
        )),
      ],
    );
  }

  Future<void> _signUp() async {
    if (pwcontroller.text.trim() != pwcheckcontroller.text.trim()) {
      msg.snackBar('비밀번호 불일치', '비밀번호와 확인이 다릅니다.');
      return;
    }

    if (!GetUtils.isEmail(emailcontroller.text.trim())) {
      msg.snackBar('형식 오류', '유효한 이메일을 입력해주세요.');
      return;
    }

    Customer customer = Customer(
      customer_email: emailcontroller.text.trim(),
      customer_pw: pwcontroller.text.trim(),
      customer_name: namecontroller.text.trim(),
      customer_phone: phonecontroller.text.trim().replaceAll('-', ''),
      customer_address: '',
      customer_image: null,
      customer_lat: null,
      customer_lng: null,
    );

    final result = await customerHandler.insertCustomer(customer);
    if (result > 0) {
      msg.showDialog('가입 완료', '축하합니다! 확인을 누르면 로그인 페이지로 이동합니다.', onConfirm: () {
        Get.back();
        Get.back(); 
      });
    } else {
      msg.snackBar('오류', '가입 중 문제가 발생했습니다.');
    }
  }
}
