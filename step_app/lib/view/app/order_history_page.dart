import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:step_app/util/message.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/app/payment_detail_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key, required this.item});
  final PurchaseListItem item;

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final Message _msg = Message();

  // ✅ QR 크게 보기 (GetX Dialog)
  void _openQrBig() {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '픽업 QR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),

              // ✅ 지금은 아이콘으로 표시 (나중에 실제 QR 이미지로 교체 가능)
              Container(
                width: 240,
                height: 240,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE1E1E1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.qr_code_2, size: 180),
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    '닫기',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i = widget.item;

    final String orderNoText = '주문번호 B-AC${i.orderId}'; // 임시
    final bool isPickedUp = i.pickupStatus == 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('구매 내역'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 주문번호
            Text(
              orderNoText,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // 상품 요약(이미지 + 정보)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productThumb(i.imageBytes),
                const SizedBox(width: 12),
                Expanded(
                  child: _productSummary(i, isPickedUp: isPickedUp),
                ),
              ],
            ),

            const SizedBox(height: 14),

            //  상품 상세(반) + 반품하기(반)
            Row(
              children: [
                Expanded(
                  child: _fullOutlineButton(
                    text: '상품 상세',
                    onPressed: () {
                      // 상품 상세 연결
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _fullOutlineButton(
                    text: '반품하기',
                    onPressed: () {
                      // 반품하기 연결
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 결제 내역 상세보기(전체)
            _fullOutlineButton(
              text: '결제 내역 상세보기',
              onPressed: () {
                Get.to(
                  () => PaymentDetailPage(
                    paymentNo: 'O-OC${i.orderId}344533129', // 임시
                    orderNo: 'B-AC${i.orderId}344533129', // 임시
                    imageBytes: i.imageBytes,
                    productTitle: i.productName,
                    optionLine: i.brandName,
                    sizeLine:
                        '${i.sizeText} SIZE  /  ${isPickedUp ? '픽업완료' : '픽업대기중'}',
                    initialAmountWon: 139200,
                    totalProductWon: 139200,
                    transactionAtText: '25/10/26 20:08',
                  ),
                );
              },
            ),

            const SizedBox(height: 18),
            const Divider(height: 1),
            const SizedBox(height: 18),

            // 픽업 정보 카드
            _pickupInfoCard(branchName: i.branchName),

            const SizedBox(height: 18),

            // 픽업 안내 + QR
            const Text(
              '픽업 안내',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _qrCard(), //  QR 누르면 크게 보기 연결됨
          ],
        ),
      ),
    );
  }

  // ---------------- UI Pieces ----------------

  Widget _productThumb(Uint8List bytes) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: bytes.isEmpty
          ? Container(
              width: 70,
              height: 70,
              color: const Color(0xFFEDEDED),
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 22),
            )
          : Image.memory(
              bytes,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _productSummary(
    PurchaseListItem i, {
    required bool isPickedUp,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          i.productName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          i.brandName,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              '${i.sizeText} SIZE  /  ${isPickedUp ? '픽업완료' : '픽업대기중'}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fullOutlineButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black87,
          side: const BorderSide(color: Color(0xFFE1E1E1)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _pickupInfoCard({required String branchName}) {
    const pickupAddress = '서울특별시 강남구 강남대로102길\n30 203호';
    const pickupDate = '2025.12.12 이후';
    const pickupTime = '10:00 ~ 21:00';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE9E9E9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '픽업 정보',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _kvRow('픽업 위치', branchName.isEmpty ? '강남지점' : branchName),
          const SizedBox(height: 10),
          _kvRow('픽업 주소', pickupAddress),
          const SizedBox(height: 10),
          _kvRow('픽업 가능일', pickupDate),
          const SizedBox(height: 10),
          _kvRow('운영 시간', pickupTime),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                // 지도 보기 연결
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE1E1E1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
              ),
              child: const Text(
                '지도 보기',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kvRow(String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 76,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _qrCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE9E9E9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE1E1E1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '픽업 QR 보기',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // ✅ QR 눌렀을 때 크게 보기
          InkWell(
            onTap: _openQrBig,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE1E1E1)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.qr_code_2, size: 42),
            ),
          ),
        ],
      ),
    );
  }
}

// PurchaseListItem은 “여기 한 군데”에만 둔다 (중복 금지)
class PurchaseListItem {
  final int orderId;
  final Uint8List imageBytes;
  final String productName;
  final String brandName;
  final String branchName;
  final String sizeText;

  int pickupStatus; // 0=대기, 1=완료

  PurchaseListItem({
    required this.orderId,
    required this.imageBytes,
    required this.productName,
    required this.brandName,
    required this.branchName,
    required this.sizeText,
    this.pickupStatus = 0,
  });
}
