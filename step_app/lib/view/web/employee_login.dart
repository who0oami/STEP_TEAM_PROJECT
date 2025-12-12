import 'package:flutter/material.dart';

class EmployeeLogin extends StatefulWidget {
  const EmployeeLogin({super.key});

  @override
  State<EmployeeLogin> createState() => _EmployeeLoginState();
}

class _EmployeeLoginState extends State<EmployeeLogin> {
  int selectedIndex = 0;

  final List<String> menuTitles = [
    '매출 현황',
    '발주',
    '입고',
    '재고 현황',
    '결재',
    '반품 / 환불 / 불량',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 헤더
          // buildTopHeader(),
        ],
      ),
    );
  }
}
