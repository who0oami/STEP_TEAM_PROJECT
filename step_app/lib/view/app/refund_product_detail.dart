import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:step_app/util/message.dart';
import 'package:step_app/util/scolor.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/home.dart';

enum RefundReason { changeOfMind, productIssue, other }

class RefundProductDetail extends StatefulWidget {
  const RefundProductDetail({
    super.key,
    required this.orderNoText,
    required this.imageBytes,
    this.imageAssetPath,
    required this.productName,
    required this.brandName,
    required this.sizeText,
    required this.isPickedUp,
  });

  final String orderNoText;
  final Uint8List imageBytes;
  final String? imageAssetPath;

  final String productName;
  final String brandName;
  final String sizeText;
  final bool isPickedUp;

  @override
  State<RefundProductDetail> createState() =>
      _RefundProductDetailState();
}

class _RefundProductDetailState extends State<RefundProductDetail> {
  RefundReason? _selected = RefundReason.changeOfMind;
  late final TextEditingController refundTextController;

  @override
  void initState() {
    super.initState();
    refundTextController = TextEditingController();
  }

  @override
  void dispose() {
    refundTextController.dispose();
    super.dispose();
  }

  // ✅ bytes 없으면 assetPath로 표시
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
              color: const Color(0xFFEDEDED),
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 22),
            ),
    );
  }

  Widget _refundProductCard() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PColor.appBarBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productThumb(
            widget.imageBytes,
            assetPath: widget.imageAssetPath,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.brandName,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.sizeText} SIZE  /  ${widget.isPickedUp ? '픽업완료' : '픽업대기중'}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        title: const Text(
          '반품 신청',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: PColor.appBarBackgroundColor,
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.orderNoText,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              '반품 상품',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            _refundProductCard(),

            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                '어떤 문제가 있나요?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: PColor.appBarBackgroundColor,
              ),
              child: Column(
                children: RefundReason.values.map((reason) {
                  return RadioListTile<RefundReason>(
                    title: Text(
                      _label(reason),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withAlpha(180),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: reason,
                    groupValue: _selected,
                    onChanged: (value) {
                      setState(() {
                        _selected = value;
                      });
                    },
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
            ),

            if (_selected == RefundReason.other)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: PColor.appBarBackgroundColor,
                ),
                child: TextField(
                  controller: refundTextController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: '기타 사유를 입력해주세요',
                    border: InputBorder.none,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: ElevatedButton(
          onPressed: () {
            if (_selected == RefundReason.other &&
                refundTextController.text.isEmpty) {
              Message().snackBar('알림', '기타 사유를 입력해주세요');
              return;
            }
            Message().showDialog('완료', '반품 신청이 완료되었습니다.');
            Get.offAll(() => const Home());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PColor.buttonPrimary,
            foregroundColor: PColor.buttonTextColor,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('반품 신청', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  String _label(RefundReason refundReason) {
    switch (refundReason) {
      case RefundReason.changeOfMind:
        return '단순 변심';
      case RefundReason.productIssue:
        return '상품 문제';
      case RefundReason.other:
        return '기타';
    }
  }
}
