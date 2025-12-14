import 'package:flutter/material.dart';
import 'package:step_app/view/app/sign_up_page.dart';
import 'package:step_app/view/web/purchase_order.dart';
import 'package:step_app/view/web/sales.dart';
import 'package:step_app/view/web/stock.dart';

/* 
Description : 직원 화면 구성 (왼쪽 탭바 고정) + 오른쪽 화면 이동
  - 1) 왼쪽에 탭바 구성
  - 2) 텍스트 누르면 탭바는 고정된 채 오른쪽에선 페이지 띄운다
Date : 2025-12-13
Author : 지현
*/



class EmployeeTabbar extends StatefulWidget {
  const EmployeeTabbar({super.key});

  @override
  State<EmployeeTabbar> createState() => _EmployeeTabbarState();
}

class _EmployeeTabbarState extends State<EmployeeTabbar> with SingleTickerProviderStateMixin{
  //Property

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 왼쪽 고정 탭바
          Container(
            width: 200,
            color: Colors.grey[200],
            child: ListView(
              children: [
                ListTile(
                  title: const Text('발주하기'),
                  onTap: () { controller.index = 0;}
                ),
                 ListTile(
                  title: const Text('매출 현황'),
                  onTap: () {
                    controller.index = 1; 
                  },
                 ),
                 ListTile(
                  title: const Text('재고 현황'),
                  onTap: () {
                    controller.index = 2; 
                  },
                 ),
                 ListTile(
                  title: const Text('결재'),
                  onTap: () {
                    controller.index = 3; 
                  },
                 ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                PurchaseOrder(), // 발주
                Sales(), // 매출
                Stock(), // 재고
                SignUpPage(), // 결재
              ],
              ),
            ),
        ],
      ),
    );
  }
}


