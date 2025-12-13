import 'dart:typed_data';
import 'package:flutter/material.dart';

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({
    super.key,
    required this.paymentNo,
    required this.orderNo,
    required this.imageBytes,
    required this.productTitle,
    required this.optionLine,
    required this.sizeLine,
    required this.initialAmountWon,
    required this.totalProductWon,
    required this.transactionAtText,
  });

  final String paymentNo; // 결제번호
  final String orderNo; // 주문번호
  final Uint8List imageBytes;

  final String productTitle; // 제품명
  final String optionLine; // 옵션/모델/브랜드 등
  final String sizeLine; // 예: "280 SIZE  /  픽업완료"

  final int initialAmountWon; // 최초 결제금액
  final int totalProductWon; // 총 구매가
  final String transactionAtText; // 거래 일시

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
        title: const Text('결제 내역 상세'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),

            // 결제번호
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Text(
                    '결제번호 >  ${w.paymentNo}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),

            // 상품 요약
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _thumb(w.imageBytes),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _productInfo(
                      orderNo: w.orderNo,
                      title: w.productTitle,
                      option: w.optionLine,
                      sizeLine: w.sizeLine,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // ✅ 픽업완료 + >
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
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

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),

            // 최초 결제금액
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              child: Row(
                children: [
                  const Text(
                    '최초 결제금액',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_won(w.initialAmountWon)}원',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),

            // ✅ 총 구매가만 남김
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: _amountRow(
                '총 구매가',
                '${_won(w.totalProductWon)}원',
              ),
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),

            // 거래 일시
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                children: [
                  const Text(
                    '거래 일시',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    w.transactionAtText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),

            // ✅ 결제정보 (안내문 한 줄)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '결제정보',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
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
                  SizedBox(height: 10),
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
            ),
          ],
        ),
      ),
    );
  }

  // ---------- UI helpers ----------

  Widget _thumb(Uint8List bytes) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: bytes.isEmpty
          ? Container(
              width: 64,
              height: 64,
              color: const Color(0xFFEDEDED),
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 22),
            )
          : Image.memory(
              bytes,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
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
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          option,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          sizeLine,
          style: const TextStyle(
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
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        Text(
          right,
          style: const TextStyle(
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
