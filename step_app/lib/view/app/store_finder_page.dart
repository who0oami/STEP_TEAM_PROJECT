import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/util/scolor.dart';

class StoreFinderPage extends StatefulWidget {
  const StoreFinderPage({super.key});

  @override
  State<StoreFinderPage> createState() => _StoreFinderPageState();
}

class _StoreFinderPageState extends State<StoreFinderPage> {
  // Property
  late TextEditingController branchName;


  @override
  void initState() {
    super.initState();
    branchName = TextEditingController();
  }

  @override
  void dispose() {
    branchName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        title: Text(
          '매장 조회',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '매장 위치',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: branchName,
              decoration: InputDecoration(
                hintText: '매장명을 입력하세요 (예: 강남)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search),
              ),
            ),

            SizedBox(height: 20),
            // 데이기넣기(현재느 ㄴ임의데이터)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    '지도 영역',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // ✅ 확정 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: branchName.text.isEmpty
                ? null
                : () {
                    // PurchasePage로 값 전달
                    Get.back(
                      result: {
                        'branchName': branchName.text,
                        'address': '서울시 강남구 테헤란로 47',
                      },
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              '확정하기',
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
  }
}
