import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:step_app/view/web/sign.dart';
/* 
Description : 발주하기 페이지
  - 1) 테이블 오른쪽 위에 "+신규발주" 버튼 
        -> 클릭 시 알러트 -> 새로 화면 구성
  - 2) 테이블 오른쪽 하단 "발주하기" 버튼 
        -> 클릭 시 테이블에 있는 데이터 가진 채로 결재 페이지 이동 
  - 3) 컬럼별 하단 드롭다운 필터 적용
  - 4) 입고수량 변경 시 총금액 자동 계산
Date : 2025-12-14
Author : 지현
*/

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({super.key});

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  // Property
  late List<PlutoColumn> columns; // 테이블 컬럼 설정
  List<PlutoRow> rows = []; // 테이블 데이터

  @override
  void initState() {
    super.initState();

    // 컬럼 초기화
    columns = [
      PlutoColumn(
        title: '발주일자',
        field: 'order_date',
        type: PlutoColumnType.date(),
        width: 120,
      ),
      PlutoColumn(
        title: '제조사',
        field: 'manufacturer',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: '제품',
        field: 'product',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: '사이즈',
        field: 'size',
        type: PlutoColumnType.text(),
        width: 80,
      ),
      PlutoColumn(
        title: '컬러',
        field: 'color',
        type: PlutoColumnType.text(),
        width: 80,
      ),
      PlutoColumn(
        title: '금액',
        field: 'price',
        type: PlutoColumnType.number(),
        width: 100,
      ),
      PlutoColumn(
        title: '입고수량',
        field: 'quantity',
        type: PlutoColumnType.number(),
        width: 100,
      ),
      PlutoColumn(
        title: '총금액',
        field: 'total_price',
        type: PlutoColumnType.number(),
        width: 120,
      ),
    ];

    // 초기 더미 데이터
    rows = [
      PlutoRow(
        cells: {
          'order_date': PlutoCell(value: DateTime.now()),
          'manufacturer': PlutoCell(value: '나이키'),
          'product': PlutoCell(value: '운동화'),
          'size': PlutoCell(value: '260'),
          'color': PlutoCell(value: '화이트'),
          'price': PlutoCell(value: 239000),
          'quantity': PlutoCell(value: 10),
          'total_price': PlutoCell(value: 239000 * 10),
        },
      ),
    ];
  }

  // 테이블 초기화
  void resetTable() {
    rows.clear();
    setState(() {});
  }

  // 입고수량 변경 시 총금액 계산
  void updateTotalPrice(PlutoRow row) {
    final price = row.cells['price']!.value ?? 0;
    final quantity = row.cells['quantity']!.value ?? 0;
    row.cells['total_price']!.value = price * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('발주하기'),
        actions: [
          // 오른쪽 상단 "+신규발주" 버튼
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: '신규 발주',
                middleText: '새로 작성하시겠습니까?\n이전 내용은 사라집니다.',
                textCancel: '취소',
                textConfirm: '확인',
                onConfirm: () {
                  resetTable();
                  Get.back();
                },
              );
            },
            child: const Text('+신규발주'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 테이블 영역
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  // 컬럼 필터 제거, 단순 표시
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  // 입고수량 변경 시 총금액 자동 계산
                  if (event.column.field == 'quantity') {
                    setState(() {
                      updateTotalPrice(event.row);
                    });
                  }
                },
              ),
            ),
          ),

          // 오른쪽 하단 "발주하기" 버튼
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // 테이블 데이터를 Map 형태로 가져오기
                  final orderData = rows.map((row) {
                    return row.cells.map((key, cell) => MapEntry(key, cell.value));
                  }).toList();
                  // GetX를 사용하여 결재 페이지로 이동
                  Get.to(() => Sign(orderData: orderData));
                },
                child: const Text('발주하기'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}