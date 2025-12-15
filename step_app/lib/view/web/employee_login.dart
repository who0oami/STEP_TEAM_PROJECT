import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/web/employee_find_info.dart';
import 'package:step_app/view/web/stock.dart';

class EmployeeLogin extends StatefulWidget {
  const EmployeeLogin({super.key});

  @override
  State<EmployeeLogin> createState() => _EmployeeLoginState();
}

class _EmployeeLoginState extends State<EmployeeLogin> {
  late TextEditingController employeeIdController;
  late TextEditingController employeePwController;
  late String emptyText;
  late String wrongText;
  late String? errorText;

  @override
  void initState() {
    super.initState();
    employeeIdController = TextEditingController();
    employeePwController = TextEditingController();
    emptyText = '정보를 입력하세요';
    wrongText = '정보가 틀렸습니다.';
    errorText = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
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
              child: Center(
                child: SizedBox(
                  width: 290,
                  height: 500,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 243, 243),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          'Log-in',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: employeeIdController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: '사번을 입력 하세요',
                            labelStyle: TextStyle(
                              color: const Color(0xB81A1A1A),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: TextField(
                            controller: employeePwController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: '비밀번호를 입력하세요',
                              labelStyle: TextStyle(
                                color: const Color(0xB81A1A1A),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextButton(
                                onPressed: () => Get.to(EmployeeFindInfo()),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (errorText != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              errorText!,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),

                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,

                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              checkEmployeeLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PColor.buttonPrimary,
                              foregroundColor: PColor.buttonTextColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(12),
                              ),
                            ),
                            child: Text('로그인'),
                          ),
                        ),
                      ],
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
    final id = employeeIdController.text.trim();
    final pw = employeePwController.text.trim();

    // 1️⃣ 비어 있음
    if (id.isEmpty || pw.isEmpty) {
      setState(() {
        errorText = emptyText;
      });
      return;
    }

    // 2️⃣ 틀림
    if (id != '52091485' || pw != '1234') {
      setState(() {
        errorText = wrongText;
      });
      return;
    }

    // 3️⃣ 정상 로그인
    setState(() {
      errorText = null;
    });

    Get.defaultDialog(
      title: '알림',
      middleText: '로그인에 성공 하셨습니다.',
      backgroundColor: const Color.fromARGB(190, 255, 255, 255),
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            // Get.to();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
} // class
