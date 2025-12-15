import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

/* 
Description : 결재 페이지
  - 1) 발주 테이블 + 결재 서식 미니 테이블 동시 표시
  - 2) 결재 테이블: 사원/팀장/이사 도장 표시
  - 3) 발주 완료 버튼 클릭 시 모든 결재 완료되면 '발주 완료' 알러트 표시
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
  late List<PlutoColumn> orderColumns;
  late List<PlutoRow> orderRows;

  late List<PlutoColumn> approvalColumns;
  late List<PlutoRow> approvalRows;

  @override
  void initState() {
    super.initState();

    // 발주 테이블 컬럼 정의
    orderColumns = [
      PlutoColumn(title: '발주일자', field: 'order_date', type: PlutoColumnType.text(), width: 120),
      PlutoColumn(title: '제조사', field: 'manufacturer', type: PlutoColumnType.text(), width: 120),
      PlutoColumn(title: '제품', field: 'product', type: PlutoColumnType.text(), width: 120),
      PlutoColumn(title: '사이즈', field: 'size', type: PlutoColumnType.text(), width: 80),
      PlutoColumn(title: '컬러', field: 'color', type: PlutoColumnType.text(), width: 80),
      PlutoColumn(title: '금액', field: 'price', type: PlutoColumnType.number(), width: 100),
      PlutoColumn(title: '입고수량', field: 'quantity', type: PlutoColumnType.number(), width: 100),
      PlutoColumn(title: '총금액', field: 'total_price', type: PlutoColumnType.number(), width: 120),
    ];

    // 발주 테이블 데이터 초기화
    orderRows = widget.orderData.map((data) {
      return PlutoRow(
        cells: {
          'order_date': PlutoCell(value: data['order_date'].toString()),
          'manufacturer': PlutoCell(value: data['manufacturer']),
          'product': PlutoCell(value: data['product']),
          'size': PlutoCell(value: data['size']),
          'color': PlutoCell(value: data['color']),
          'price': PlutoCell(value: data['price']),
          'quantity': PlutoCell(value: data['quantity']),
          'total_price': PlutoCell(value: data['total_price']),
        },
      );
    }).toList();

    // 결재 테이블 컬럼 정의
    approvalColumns = [
      PlutoColumn(title: '사원', field: 'staff', type: PlutoColumnType.text(), width: 80),
      PlutoColumn(title: '팀장', field: 'manager', type: PlutoColumnType.text(), width: 80),
      PlutoColumn(title: '이사', field: 'director', type: PlutoColumnType.text(), width: 80),
    ];

    // 결재 테이블 초기 데이터
    approvalRows = [
      PlutoRow(cells: {
        'staff': PlutoCell(value: widget.orderData.isNotEmpty ? 'ㅁ' : ''),
        'manager': PlutoCell(value: ''),
        'director': PlutoCell(value: ''),
      }),
    ];
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 발주 테이블
              SizedBox(
                height: 250,
                child: PlutoGrid(
                  columns: orderColumns,
                  rows: orderRows,
                  configuration: const PlutoGridConfiguration(
                    style: PlutoGridStyleConfig(columnHeight: 40, rowHeight: 40),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 결재 테이블
              SizedBox(
                height: 80,
                child: PlutoGrid(
                  columns: approvalColumns,
                  rows: approvalRows,
                  configuration: const PlutoGridConfiguration(
                    style: PlutoGridStyleConfig(columnHeight: 40, rowHeight: 40),
                  ),
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
      ),
    );
  }
}
