import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:step_app/util/message.dart';
import 'package:step_app/vm/database_handler_customer.dart';

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
    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    pwcheckcontroller = TextEditingController();
    namecontroller = TextEditingController();
    phonecontroller = TextEditingController();
    customerHandler = DatabaseHandlerCustomer();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('이메일 주소'),
              TextField(controller: emailcontroller),
              Text('비밀번호'),
              TextField(controller: pwcontroller),
              Text('비밀번호 확인'),
              TextField(controller: pwcheckcontroller),
              Text('이름'),
              TextField(controller: namecontroller),
              Text('전화번호'),
              TextField(controller: phonecontroller),
              SizedBox(height: 50),
              //Checkbox(value: value, onChanged: onChanged)
              Row(
                children: [
                  Checkbox(
                    value: all,
                    onChanged: _toggleAll,
                  ),
                  Text('모두 동의합니다'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: fourteen,
                    onChanged: (value) {
                      fourteen = value!;
                      setState(() {});
                    },
                  ),
                  Text('[필수]만 14세 이상입니다'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: use,
                    onChanged: (value) {
                      use = value!;
                      setState(() {});
                    },
                  ),
                  Text('[필수]이용 약관 동의'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: collect,
                    onChanged: (value) {
                      collect = value!;
                      setState(() {});
                    },
                  ),
                  Text('[필수]개인정보 수집 및 이용 동의'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: marketing,
                    onChanged: (value) {
                      marketing = value!;
                      setState(() {});
                    },
                  ),
                  Text('[동의]마케팅 수신 동의'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _signUp();
                    },
                    child: Text('가입하기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } //function

  _toggleAll(bool? value) {
    if (value != null) {
      setState(() {
        all = value;
        fourteen = value;
        use = value;
        collect = value;
        marketing = value;
      });
    }
  }

  // _toggleIndividual(bool? value, String type) {
  //   if (value != null) {
  //     setState(() {
  //       if (type == 'fourteen') fourteen = value;
  //       if (type == 'use') use = value;
  //       if (type == 'collect') collect = value;
  //       if (type == 'marketing') marketing = value;

  //       if (!value) {
  //         all = false;
  //       } else if (fourteen &&
  //           use &&
  //           collect &&
  //           marketing) {
  //         all = true;
  //       }
  //     });
  //   }
  // }

  _signUp() {
    if (emailcontroller.text.isEmpty ||
        pwcontroller.text.isEmpty ||
        pwcheckcontroller.text.isEmpty ||
        namecontroller.text.isEmpty ||
        phonecontroller.text.isEmpty) {
      msg.snackBar('필수 입력', '모든 입력란을 채워주세요.');
      return;
    }

    if (!GetUtils.isEmail(emailcontroller.text)) {
      msg.snackBar('이메일 형식 오류', '유효한 이메일 주소를 입력해주세요.');
      return;
    }

    if (pwcontroller.text != pwcheckcontroller.text) {
      msg.snackBar('비밀번호 오류', '비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      return;
    }

    // final exists = await customerHandler.checkEmailExists(emailcontroller.text.trim());
    // if (exists) {
    //   msg.showDialog('가입 실패', '이미 존재하는 이메일 주소입니다.');
    //   return;
    // }

    if (!fourteen || !use || !collect) {
      msg.showDialog(
        '필수 약관 동의 필요',
        '만 14세 이상, 이용 약관, 개인정보 수집 및 이용 동의는 필수입니다.',
      );
      return;
    }

    /*
    //
    Customer customer = Customer(
      CustomerEmail: emailcontroller.text.trim(),
      CustomerPw: pwcontroller.text.trim(),
      CustomerName: namecontroller.text.trim(),
      CustomerPhone: phonecontroller.text.trim(),
    );
    
    final result = await customerHandler.insertCustomer(customer);
    
    if (result > 0) {
      msg.showDialog(
        '회원가입 완료',
        '${namecontroller.text}님, 회원가입을 축하드립니다!',
      );
    } else {
      msg.showDialog('오류 발생', '회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.');
    }
    */

    msg.showDialog(
      '회원가입 완료',
      '${namecontroller.text}님, 회원가입을 축하드립니다!',
    );
  }

  /*
Future insertAction() async {
    Customer customer = Customer(
      CustomerEmail: _emailTextEditingController.text.trim(),
      CustomerPw: _pwTextEditingController.text.trim(),
      CustomerName: _nameTextEditingController.text.trim(),
      CustomerPhone: _phoneTextEditingController.text.trim(),
      //CustomerAddress: _addressData,
      //CustomerImage: _imageData,
      //CustomerLat: _latData,
      //CustomerLng: _lngData,
      //initDate: DateTime.now().toString(),
    );
   */

  /*
  //가입
  INSERTINSERT INTO customer 
  (customer_email, customer_pw, customer_name, customer_phone) 
  VALUES (?, ?, ?, ?)

  //중복 이메일 확인
  SELECTSELECT customer_id FROM customer 
  WHERE customer_email = ?
   */
}
