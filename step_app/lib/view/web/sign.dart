import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

/* 
Description : 결재 페이지
  - 1) 결재 서식 미니 테이블 (사원/팀장/이사)
        -> 발주에서 데이터가 넘어오면 사원 컬럼에 도장 아이콘 표시
  - 2) 발주하기 버튼 클릭 시 모든 결재 완료되면 '발주 완료' 알러트 표시
  - 3) 각 컬럼 빈 칸에 도장 아이콘 직접 입력 가능
  - 4) approvalRows를 잠깐 저장 용도로 사용
Date : 2025-12-14
Author : 지현
*/

class Sign extends StatefulWidget {
  final List<Map<String, dynamic>> orderData;

  const Sign({super.key, required this.orderData});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  late List<PlutoColumn> approvalColumns;
  late List<PlutoRow> approvalRows;

  @override
  void initState() {
    super.initState();

    // 결재 서식 컬럼 정의
    approvalColumns = [
      PlutoColumn(title: '사원', field: 'staff', type: PlutoColumnType.text(), width: 80),
      PlutoColumn(title: '팀장', field: 'manager', type: PlutoColumnType.text(), width: 80),
      PlutoColumn(title: '이사', field: 'director', type: PlutoColumnType.text(), width: 80),
    ];

    // 초기 모든 컬럼 빈칸
    approvalRows = [
      PlutoRow(cells: {
        'staff': PlutoCell(value: ''),
        'manager': PlutoCell(value: ''),
        'director': PlutoCell(value: ''),
      }),
    ];

    // 화면 로드 후 발주 데이터가 있으면 사원 컬럼 도장 표시
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.orderData.isNotEmpty) {
        setState(() {
          approvalRows.first.cells['staff']!.value = 'ㅁ';
        });
      }
    });
  }

  // 모든 컬럼 도장 완료 여부 확인
  bool isAllStamped() {
    for (var cell in approvalRows.first.cells.values) {
      if (cell.value == null || cell.value == '') return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('결재하기 (Sign)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 결재 서식 테이블
            SizedBox(
              height: 80,
              child: PlutoGrid(
                columns: approvalColumns,
                rows: approvalRows,
                configuration: PlutoGridConfiguration(
                  style: PlutoGridStyleConfig(
                    columnHeight: 40,
                    rowHeight: 40,
                  ),
                ),
                onChanged: (event) {
                  // setState(() {}); // 도장 입력 시 화면 갱신
                },
              ),
            ),
            const SizedBox(height: 20),
            // 발주 완료 버튼
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (isAllStamped()) {
                    Get.defaultDialog(
                      title: '발주 완료',
                      middleText: '모든 결재가 완료되었습니다!',
                      textConfirm: '확인',
                      onConfirm: () => Get.back(),
                    );
                  } else {
                    Get.snackbar('경고', '모든 결재가 완료되지 않았습니다!');
                  }
                },
                child: const Text('발주하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
