import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/view/app/order_history_page.dart';
import 'package:step_app/vm/database_handler_customer.dart';
import 'edit_profile_page.dart';

class ProfileViewPage extends StatefulWidget {
  final int? customerId;
  const ProfileViewPage({super.key, this.customerId});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  late CustomerHandler handler;
  Customer? _customer;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    handler = CustomerHandler();
    loadCustomer();
  }

  Future<void> loadCustomer() async {
    if (widget.customerId == null) {
      _customer = Customer(
        customer_id: 0,
        customer_name: "홍길동",
        customer_phone: "010-1234-5678",
        customer_pw: "1234",
        customer_email: "test@example.com",
        customer_address: "서울 강남구",
        customer_image: null,
      );
      profileImage = null;
      setState(() {});
      return;
    }

    final data = await handler.getCustomer(widget.customerId!);
    if (data != null) {
      setState(() {
        _customer = data;
        profileImage =
            (data.customer_image != null &&
                data.customer_image!.isNotEmpty)
            ? File(data.customer_image!)
            : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_customer == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("프로필"), centerTitle: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 상단
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(_customer!.customer_name),
                      buildInfoRow(_customer!.customer_phone),
                      buildInfoRow(_customer!.customer_email),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 프로필 편집 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditProfilePage(customer: _customer!),
                      ),
                    );

                    if (result != null && result is Customer) {
                      setState(() {
                        _customer = result;
                        profileImage =
                            (result.customer_image != null &&
                                result.customer_image!.isNotEmpty)
                            ? File(result.customer_image!)
                            : null;
                      });
                    } else {
                      await loadCustomer();
                    }
                  },
                  child: const Text("프로필 편집"),
                ),
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 12),

              // 구매목록
              Expanded(
                child: PurchaseListSection(
                  customerId: widget.customerId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class PurchaseListSection extends StatefulWidget {
  const PurchaseListSection({super.key, required this.customerId});
  final int? customerId;

  @override
  State<PurchaseListSection> createState() =>
      _PurchaseListSectionState();
}

class _PurchaseListSectionState extends State<PurchaseListSection> {
  bool _loading = true;
  String? _error;
  List<PurchaseListItem> _items = [];

  // ✅ 검색용
  final TextEditingController _searchController =
      TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPurchases() async {
    setState(() {
      _loading = true;
      _error = null;
      _items = [];
    });

    try {
      // ✅ 지금은 UI 확인용 더미
      final dummy = <PurchaseListItem>[
        PurchaseListItem(
          orderId: 1,
          imageBytes: Uint8List(0),
          productName: '에어줌 페가수스',
          brandName: 'NIKE',
          branchName: '강남구 대리점',
          sizeText: '270',
          pickupStatus: 0,
        ),
        PurchaseListItem(
          orderId: 2,
          imageBytes: Uint8List(0),
          productName: '슈퍼스타',
          brandName: 'ADIDAS',
          branchName: '서초구 대리점',
          sizeText: '265',
          pickupStatus: 1,
        ),
      ];

      if (!mounted) return;
      setState(() {
        _items = dummy;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('에러: $_error'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadPurchases,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (_items.isEmpty)
      return const Center(child: Text('구매 내역이 없습니다.'));

    // ✅ 제품명으로 필터링 (대소문자 무시)
    final q = _query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? _items
        : _items
              .where((e) => e.productName.toLowerCase().contains(q))
              .toList();

    return Column(
      children: [
        // ✅ 헤더: 구매 내역 + 검색창
        Row(
          children: [
            const Text(
              '구매 내역',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 250,
              height: 38,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: '제품명 검색',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  prefixIcon: const Icon(Icons.search, size: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('검색 결과가 없습니다.'))
              : ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return _buildPurchaseCard(item);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildPurchaseCard(PurchaseListItem item) {
    return InkWell(
      onTap: () => Get.to(() => OrderHistoryPage(item: item)),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFFF6F6F6),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imageBytes.isEmpty
                  ? Container(
                      width: 72,
                      height: 72,
                      alignment: Alignment.center,
                      color: const Color(0xFFEAEAEA),
                      child: const Icon(Icons.image_not_supported),
                    )
                  : Image.memory(
                      item.imageBytes,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '브랜드: ${item.brandName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '대리점: ${item.branchName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SIZE: ${item.sizeText}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.pickupStatus == 0 ? '픽업대기중' : '픽업완료',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: item.pickupStatus == 0
                        ? Colors.black54
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                if (item.pickupStatus == 0)
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () async {
                        final bool confirmed =
                            (await Get.to<bool>(
                              () => OrderHistoryPage(item: item),
                            )) ??
                            false;

                        if (confirmed) {
                          setState(() => item.pickupStatus = 1);
                        }
                      },
                      child: const Text(
                        '픽업 완료',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 리스트 아이템 모델 (화면에서만 상태 변경)
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
