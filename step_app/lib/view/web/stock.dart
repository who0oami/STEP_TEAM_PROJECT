import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:step_app/model/product.dart';
import 'package:step_app/util/scolor.dart';
/* 
Description : 재고 현황 페이지
  - 1) 탭바에서 넘어온 화면
  - 2) 왼쪽에 기존 탭바 고정되어 있고 오른쪽에 재고 현황 보여줄 예정
  - 3 ) 데이터 가져오기 전, 컬럼명 만들어주기
  - 4 ) 리스트에 데이터 넣어주기
Date : 2025-12-13
Author : 지현
*/

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  // Property
  late List<PlutoColumn> columns;
  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();
    columns = [
      PlutoColumn(
        title: 'ID',
        field: 'product_id',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: '제품',
        field: 'product',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: '제조사',
        field: 'manufacturer',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: '가격',
        field: 'price',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: '수량',
        field: 'quantity',
        type: PlutoColumnType.number(),
      ),
    ]; // columns
  loadData();
  }
  // 더미 데이터 생성
  Future<void> loadData() async {
  final products = [
    Product(
      product_id: 1,
      category_product_id: '운동화',
      category_manufacturer_id: '나이키',
      category_product_size_id: '260',
      category_color_id: '화이트',
      product_price: 239000,
      product_quantity: 10,
      product_image: Uint8List(0),
    ),
  ];

  setState(() {
    rows = productListToRows(products);
  });
}

  // 한 줄 
  PlutoRow productToRow(Product p) {
    return PlutoRow(
      cells: {
        'product_id': PlutoCell(value: p.product_id),
        'product': PlutoCell(value: p.category_product_id),
        'manufacturer': PlutoCell(value: p.category_manufacturer_id),
        'price': PlutoCell(value: p.product_price),
        'quantity': PlutoCell(value: p.product_quantity),
      },
    );
  } // PlutoRow
  // 여러 개 Product 인 경우
  List<PlutoRow> productListToRows(List<Product> list) {
  return list.map((p) => productToRow(p)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Text(
                  "재고 현황",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PlutoGrid(
              columns: columns,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                event.stateManager.setShowColumnFilter(true);
              },
              ),
            ),
          ),
        ],
      )
    );
  }
}