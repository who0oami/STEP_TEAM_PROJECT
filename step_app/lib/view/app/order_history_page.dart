import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:step_app/view/app/payment_detail_page.dart';

import 'package:step_app/model/purchase_list_item.dart';
import 'package:step_app/view/app/branch_map_page.dart';
import 'package:step_app/view/app/refund_product_detail.dart';

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({super.key, required this.item});
  final PurchaseListItem item;

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  void _openQrBig() {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '픽업 QR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 240,
                height: 240,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE1E1E1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.qr_code_2, size: 180),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: Text(
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

    final String orderNoText = '주문번호 B-AC${i.orderId}';
    final bool isPickedUp = i.pickupStatus == 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('구매 내역'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderNoText,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  여기 수정: bytes + asset 둘 다 지원
                _productThumb(
                  i.imageBytes,
                  assetPath: i.imageAssetPath,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _productSummary(i, isPickedUp: isPickedUp),
                ),
              ],
            ),

            SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _fullOutlineButton(
                    text: '상품 상세',
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _fullOutlineButton(
                    text: '반품하기',
                    onPressed: () {
                      Get.to(
                        () => RefundProductDetail(
                          orderNoText: '주문번호 B-AC${i.orderId}',
                          imageBytes: i.imageBytes,
                          imageAssetPath: i.imageAssetPath,
                          productName: i.productName,
                          brandName: i.brandName,
                          sizeText: i.sizeText,
                          isPickedUp: isPickedUp,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            _fullOutlineButton(
              text: '결제 내역 상세보기',
              onPressed: () {
                Get.to(
                  () => PaymentDetailPage(
                    paymentNo: 'O-OC${i.orderId}344533129',
                    orderNo: 'B-AC${i.orderId}344533129',
                    imageBytes: i.imageBytes,
                    imageAssetPath: i.imageAssetPath, // ✅ 추가
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

            SizedBox(height: 18),
            Divider(height: 1),
            SizedBox(height: 18),

            _pickupInfoCard(branchName: i.branchName),

            SizedBox(height: 18),

            Text(
              '픽업 안내',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            _qrCard(),
          ],
        ),
      ),
    );
  }

  // ✅ 수정: bytes가 없으면 assetPath로 표시
  Widget _productThumb(Uint8List bytes, {String? assetPath}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: bytes.isNotEmpty
          ? Image.memory(
              bytes,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            )
          : (assetPath != null && assetPath.isNotEmpty)
          ? Image.asset(
              assetPath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            )
          : Container(
              width: 70,
              height: 70,
              color: Color(0xFFEDEDED),
              alignment: Alignment.center,
              child: Icon(Icons.image_not_supported, size: 22),
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
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2),
        Text(
          i.brandName,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              '${i.sizeText} SIZE  /  ${isPickedUp ? '픽업완료' : '픽업대기중'}',
              style: TextStyle(
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
          side: BorderSide(color: Color(0xFFE1E1E1)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _pickupInfoCard({required String branchName}) {
    final i = widget.item;

    final pickupAddress = '서울특별시 강남구 강남대로102길\n30 203호';
    final pickupDate = '2025.12.12 이후';
    final pickupTime = '10:00 ~ 21:00';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE9E9E9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '픽업 정보',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          _kvRow('픽업 위치', branchName.isEmpty ? '강남지점' : branchName),
          SizedBox(height: 10),
          _kvRow('픽업 주소', pickupAddress),
          SizedBox(height: 10),
          _kvRow('픽업 가능일', pickupDate),
          SizedBox(height: 10),
          _kvRow('운영 시간', pickupTime),
          SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                final lat = i.branchLat;
                final lng = i.branchLng;

                if (lat == null || lng == null) {
                  Get.snackbar('알림', '지점 좌표가 없습니다.');
                  return;
                }

                Get.to(
                  () => BranchMapPage(
                    branchName: i.branchName,
                    address: i.branchLocation,
                    lat: lat,
                    lng: lng,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFFE1E1E1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
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
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
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
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE9E9E9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE1E1E1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '픽업 QR 보기',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          InkWell(
            onTap: _openQrBig,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE1E1E1)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.qr_code_2, size: 42),
            ),
          ),
        ],
      ),
    );
  }
}
