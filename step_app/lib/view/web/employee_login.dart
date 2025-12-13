import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/util/scolor.dart';

class EmployeeLogin extends StatefulWidget {
  const EmployeeLogin({super.key});

  @override
  State<EmployeeLogin> createState() =>
      _EmployeeLoginState();
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
            colors: [
              Color(0xFF1C1F26),
              Color(0xFF2A2D36),
            ],
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
                  width: 300,
                  height: 500,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        243,
                        243,
                        243,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
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
                          controller:
                              employeeIdController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                    12,
                                  ),
                            ),
                            labelText: '사번을 입력 하세요',
                            labelStyle: TextStyle(
                              color: const Color(
                                0xB81A1A1A,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(
                                0,
                                12,
                                0,
                                0,
                              ),
                          child: TextField(
                            controller:
                                employeePwController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                      12,
                                    ),
                              ),
                              labelText: '비밀번호를 입력하세요',
                              labelStyle: TextStyle(
                                color: const Color(
                                  0xB81A1A1A,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (errorText != null)
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                            ),
                            child: Text(
                              errorText!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                            ),
                          ),

                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,

                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              checkEmployeeLogin();
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  PColor.buttonPrimary,
                              foregroundColor:
                                  PColor.buttonTextColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.circular(
                                      12,
                                    ),
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
    // ID와 PW가 비어 있을 경우
    // ID나 PW가 정해진 값과 틀릴 경우.
    // 정상적인 경우.
    if (employeeIdController.text.trim().isEmpty ||
        employeePwController.text.trim().isEmpty) {
      setState(() {
        errorText = emptyText;
      });
    } else if (employeeIdController.text.trim() ==
            'root' &&
        employeePwController.text.trim() == '1234') {
      setState(() {
        errorText = wrongText;
      });
    } else {
      setState(() {
        errorText = null; // 에러 제거
      });
      // 정상적인 경우 alert 출력
      Get.defaultDialog(
        title: '알림',
        middleText: '로그인에 성공 하셨습니다.',
        backgroundColor: const Color.fromARGB(
          225,
          135,
          201,
          255,
        ),
        barrierDismissible: false,

        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(
                206,
                1,
                21,
                37,
              ),
              backgroundColor: const Color.fromARGB(
                204,
                255,
                255,
                255,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadiusGeometry.circular(12),
              ),
            ),

            child: Text('OK'),
          ),
        ],
      );
    }
  }
} // class
