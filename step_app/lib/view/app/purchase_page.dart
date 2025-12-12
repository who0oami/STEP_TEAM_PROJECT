import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/store_finder_page.dart';
/* 
Description : 사용자 결제 화면
  - 1) 상세페이지에서 넘어온 상품 정보를 획득한다.
  - 2) 획득된 정보를 memory에 존재 함으로 snapshot으로 Data를 가져온다.
  - 3) TextEditingController에 입력한 게 있는 경우 검색으로 넘겨준다.
  - 4) 검색으로 이동후에 돌아왔을 경우 매장 정보를 가지고 와서 새로 텍스트필드에 넣어준다.
  - 5) 픽업장소 미 지정 시
      - 지점 하단 지점명 대신 "미지정"으로 입력, 텍스트 컬러 -> 회색
      - 결제하기 하단 버튼 컬러 회색 & 눌리지 않게
  - 5) 픽업 장소 정해진 상태에서 결제하기 누르면 결제 완료 페이지 띄워준다. 
Date : 2025-12-11
Author : 지현
*/

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  // Property
  late TextEditingController branchName; //  매장명

  @override
  void initState() {
    super.initState();
    branchName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결제'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "픽업 지정 및 조회",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            child: Row(
              children: [
                Text('지점'),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => Get.to(StoreFinderPage()),
                         icon: Icon(Icons.search)
                        ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}