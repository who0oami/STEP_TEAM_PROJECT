import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:step_app/model/product.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/vm/database_handler_product.dart';

/* 
Description : 재고 현황 페이지
  - DB에서 제품 리스트를 가져와 PlutoGrid에 표시
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

  final DatabaseHandlerProduct dbHandler = DatabaseHandlerProduct();

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
    ];

    loadData(); // DB에서 데이터 불러오기
  }

  Future<void> loadData() async {
    List<Product> products = await dbHandler.queryProduct();

    setState(() {
      rows = products.map((p) => productToRow(p)).toList();
    });
  }

  // 제조사 ID를 이름으로 변환
  String manufacturerIdToName(int id) {
    switch (id) {
      case 1:
        return 'NIKE';
      case 2:
        return 'NEW BALANCE';
      default:
        return 'Unknown';
    }
  }

  PlutoRow productToRow(Product p) {
    return PlutoRow(
      cells: {
        'product_id': PlutoCell(value: p.product_id),
        'product': PlutoCell(value: '${manufacturerIdToName(p.category_manufacturer_id)} ${p.category_size_id}'),
        'manufacturer': PlutoCell(value: manufacturerIdToName(p.category_manufacturer_id)),
        'price': PlutoCell(value: p.product_price),
        'quantity': PlutoCell(value: p.product_quantity),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            "재고 현황",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
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
      ),
    );
  }
}
