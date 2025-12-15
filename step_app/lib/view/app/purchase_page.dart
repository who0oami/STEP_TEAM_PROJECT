import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/app/profile_view_page.dart';
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
  late bool isBranchSelected; // 픽업 장소 선택 여부
  @override
  void initState() {
    super.initState();
    branchName = TextEditingController();
    isBranchSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        title: Text('결제'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "픽업 지정 및 조회",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                color: PColor.appBarBackgroundColor,
                borderRadius: BorderRadius.circular(16), // ← 동그랗게
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '지점',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          Text(
                          branchName.text.isEmpty ? '미지정' : branchName.text,
                          style: TextStyle(
                            color: branchName.text.isEmpty ? Colors.grey : Colors.black,
                          ),
                        ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 194, 194, 194),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 12,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final result = await Get.to(() => StoreFinderPage(), arguments: {
                                    'branchName': branchName.text,
                                  });
                                  if (result != null && result['branchName'] != null) {
                                    setState(() {
                                      branchName.text = result['branchName'];
                                      isBranchSelected = true; // 버튼 활성화
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: PColor.appBarBackgroundColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "주문 상품",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                color: PColor.appBarBackgroundColor,
                borderRadius: BorderRadius.circular(16), 
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'images/AIR+FORCE+1.png',
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "869V (남성,4E) (안전화)",
                          style: TextStyle(
                          fontWeight: FontWeight.bold),),
                          Text('new balence'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "280 SIZE",
                              style: TextStyle(
                              fontWeight: FontWeight.bold),),
                              Text(
                                " / ",
                              style: TextStyle(
                              fontWeight: FontWeight.bold),),
                              Text(
                                "191,000 원",
                              style: TextStyle(
                              fontWeight: FontWeight.bold),),
                              Text(
                                " / ",
                              style: TextStyle(
                              fontWeight: FontWeight.bold),),
                              Text(
                                "1 개",
                              style: TextStyle(
                              fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                  color: PColor.appBarBackgroundColor,
                  borderRadius: BorderRadius.circular(16), 
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/AIR+FORCE+1.png',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "869V (남성,4E) (안전화)",
                            style: TextStyle(
                            fontWeight: FontWeight.bold),),
                            Text('new balence'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "265 SIZE",
                                style: TextStyle(
                                fontWeight: FontWeight.bold),),
                                Text(
                                  " / ",
                                style: TextStyle(
                                fontWeight: FontWeight.bold),),
                                Text(
                                  "191,000 원",
                                style: TextStyle(
                                fontWeight: FontWeight.bold),),
                                Text(
                                  " / ",
                                style: TextStyle(
                                fontWeight: FontWeight.bold),),
                                Text(
                                  "1 개",
                                style: TextStyle(
                                fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        ),
                    ],
                  ),
                ),
            ),
            Text(
              "최종 주문 정보",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                color: PColor.appBarBackgroundColor,
                borderRadius: BorderRadius.circular(16), 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('구매가 합계'),
                              Text("382,000 원"), 
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('수수료'),
                              Text('6,000 원'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('총 결제금액'),
                              Text('388,000 원'), 
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                       Text(
                        '총 결제금액',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                       Text(
                        '388,000원',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: isBranchSelected
                ? () {
                    buttonDialog();
                  }
                : null, // null이면 버튼 비활성화
        style: ElevatedButton.styleFrom(
        backgroundColor: isBranchSelected ? Colors.red : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        ),
        child: Text(
          '결제하기',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  ),
    );
  } // build
  // ----Functions ----
  buttonDialog(){
    Get.defaultDialog(
      title: '결제 확인',
      middleText: '결제 하시겠습니까?',
      backgroundColor: PColor.appBarBackgroundColor,
      barrierDismissible: false,
      actions: [
        ElevatedButton(
          onPressed: () => Get.offAll(ProfileViewPage()),
          style: ElevatedButton.styleFrom(
                backgroundColor: PColor.buttonPoint,
                foregroundColor: PColor.buttonTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
          ),
          child: Text('결제하기')
        ),
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
                backgroundColor: PColor.buttonGray,
                foregroundColor: PColor.buttonTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
          ),
          child: Text('취소')
        )
      ]
    );

  }



} // class