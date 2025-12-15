import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailPage extends StatefulWidget {
  PaymentDetailPage({
    super.key,
    required this.paymentNo,
    required this.orderNo,
    required this.imageBytes,
    this.imageAssetPath, //
    this.isPickedUp = false,
    required this.productTitle,
    required this.optionLine,
    required this.sizeLine,
    required this.initialAmountWon,
    required this.totalProductWon,
    required this.transactionAtText,
  });

  final String paymentNo;
  final String orderNo;
  final Uint8List imageBytes;

  final String? imageAssetPath; // ✅ 추가

  final String productTitle;
  final String optionLine;
  final String sizeLine;

  final int initialAmountWon;
  final int totalProductWon;
  final String transactionAtText;

  final bool isPickedUp;

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final w = widget;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('결제 내역 상세'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Text(
                    '결제번호 >  ${w.paymentNo}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ 여기 수정: bytes 없으면 assetPath로 표시
                  _thumb(w.imageBytes, assetPath: w.imageAssetPath),
                  SizedBox(width: 12),
                  Expanded(
                    child: _productInfo(
                      orderNo: w.orderNo,
                      title: w.productTitle,
                      option: w.optionLine,
                      sizeLine: w.sizeLine,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '픽업완료',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              child: Row(
                children: [
                  Text(
                    '최초 결제금액',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${_won(w.initialAmountWon)}원',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: _amountRow(
                '총 구매가',
                '${_won(w.totalProductWon)}원',
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Text(
                    '거래 일시',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Text(
                    w.transactionAtText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '결제정보',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '카카오페이',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '체결 후 결제 정보 변경은 불가하며, 환불 전환은 카드사 문의 바랍니다.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ 수정: bytes 없으면 assetPath로 표시 (디자인/크기 그대로)
  Widget _thumb(Uint8List bytes, {String? assetPath}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: bytes.isNotEmpty
          ? Image.memory(
              bytes,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            )
          : (assetPath != null && assetPath.isNotEmpty)
          ? Image.asset(
              assetPath,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            )
          : Container(
              width: 64,
              height: 64,
              color: Color(0xFFEDEDED),
              alignment: Alignment.center,
              child: Icon(Icons.image_not_supported, size: 22),
            ),
    );
  }

  Widget _productInfo({
    required String orderNo,
    required String title,
    required String option,
    required String sizeLine,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주문번호 $orderNo',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2),
        Text(
          option,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
        ),
        SizedBox(height: 10),
        Text(
          sizeLine,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _amountRow(String left, String right) {
    return Row(
      children: [
        Text(
          left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Spacer(),
        Text(
          right,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _won(int value) {
    final s = value.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idxFromEnd = s.length - i;
      buf.write(s[i]);
      if (idxFromEnd > 1 && idxFromEnd % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }
}
