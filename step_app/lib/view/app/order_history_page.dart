import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/profile_view_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key, required this.item});
  final PurchaseListItem item;

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final i = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: const Text('구매 상세(임시)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: i.imageBytes.isEmpty
                  ? Container(
                      width: double.infinity,
                      height: 220,
                      alignment: Alignment.center,
                      color: const Color(0xFFEAEAEA),
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                      ),
                    )
                  : Image.memory(
                      i.imageBytes,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 16),

            Text(
              i.productName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),

            _infoRow('브랜드', i.brandName),
            const SizedBox(height: 6),
            _infoRow('대리점', i.branchName),
            const SizedBox(height: 6),
            _infoRow('사이즈', i.sizeText),
            const SizedBox(height: 6),
            _infoRow('주문번호', i.orderId.toString()),
            const SizedBox(height: 6),
            _infoRow('픽업상태', i.pickupStatus == 0 ? '픽업대기중' : '픽업완료'),

            const Spacer(),

            // ✅ 대기중일 때만 확정 버튼 → 누르면 true 반환
            if (i.pickupStatus == 0)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // 둘 중 하나만 써도 됨. 지금은 GetX로 통일:
                    Get.back(result: true);
                    // Navigator.pop(context, true);
                  },
                  child: const Text('픽업 완료 확정'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}
