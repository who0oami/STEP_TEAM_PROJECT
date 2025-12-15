import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/util/scolor.dart';

class EmployeeFindInfo extends StatefulWidget {
  const EmployeeFindInfo({super.key});

  @override
  State<EmployeeFindInfo> createState() => _EmployeeFindInfoState();
}

class _EmployeeFindInfoState extends State<EmployeeFindInfo> {
  late String emptyText;
  late String wrongText;
  late String? errorText;
  late List<String> items;
  late String dropDownValue;
  late String imageName;
  bool isCustomEmail = false;
  late TextEditingController employeeIdController;
  late TextEditingController emailIdController;
  late TextEditingController emailDomainController;

  @override
  void initState() {
    super.initState();

    employeeIdController = TextEditingController();
    emailIdController = TextEditingController();
    emailDomainController = TextEditingController();

    emptyText = '정보를 입력하세요';
    wrongText = '정보가 틀렸습니다.';
    errorText = null;

    items = ['@naver.com', '@gmail.com', '@kakao.com', '직접 입력'];
    dropDownValue = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1C1F26), Color(0xFF2A2D36)],
          ),
        ),
        child: Row(
          children: [
            // 왼쪽
            Expanded(
              child: Center(
                child: Text(
                  'STEP',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),

            // 오른쪽
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 400,

                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            'Find Password',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            '사번과 이메일주소를 입력하세요',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            width: 400,
                            child: TextField(
                              controller: employeeIdController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: '사번을 입력 하세요',
                                labelStyle: TextStyle(color: Color(0xB81A1A1A)),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          Row(
                            children: [
                              // 이메일 아이디
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: emailIdController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: '메일 주소',
                                    labelStyle: TextStyle(
                                      color: Color(0xB81A1A1A),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),

                              // 도메인 선택
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  initialValue: dropDownValue,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  items: items.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownValue = value!;
                                      isCustomEmail = value == '직접 입력';

                                      if (!isCustomEmail) {
                                        emailDomainController.text = value;
                                      } else {
                                        emailDomainController.clear();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (errorText != null)
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                errorText!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                          SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: checkEmployeeLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PColor.buttonPrimary,
                                foregroundColor: PColor.buttonTextColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('비밀번호 찾기'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // build

  // === functions====
  void checkEmployeeLogin() {
    final fullEmail = isCustomEmail
        ? '${emailIdController.text}${emailDomainController.text}'
        : '${emailIdController.text}$dropDownValue';

    // 1. 빈 값 체크
    if (employeeIdController.text.trim().isEmpty ||
        emailIdController.text.trim().isEmpty) {
      setState(() {
        errorText = emptyText;
      });
      return;
    }

    // 2. 임시 검증
    if (employeeIdController.text.trim() != '52091485' ||
        fullEmail != 'test@naver.com') {
      setState(() {
        errorText = wrongText;
      });
      return;
    }

    // 3. 성공
    setState(() {
      errorText = null;
    });

    Get.defaultDialog(
      title: '알림',
      middleText: '입력하신 이메일로\n임시 비밀번호가 발송되었습니다.',
      barrierDismissible: false,
      actions: [TextButton(onPressed: () => Get.back(), child: Text('확인'))],
    );
  }
} // class
